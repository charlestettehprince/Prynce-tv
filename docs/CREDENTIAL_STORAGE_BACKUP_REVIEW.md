# PRYNCE TV — Credential Storage and Backup Behaviour Review

**Audit date:** 3 November 2026  
**Pinned engine:** OpenTV `443811904b6437720d37bb1064c0830906c3515f`  
**Scope:** Static source inspection of Room entities/database creation, settings preferences, manifest backup flags, and available encryption references.

## Executive finding

The inspected OpenTV implementation stores several secrets in app-private storage, but the inspected source does not show application-layer encryption for those values.

- Provider credentials and Stalker MAC addresses are Room columns in the `sources` table.
- SMB/NAS username and password are stored in the `opentv_settings` SharedPreferences file.
- The user's TMDB API key is stored in the same preferences file.
- Playlist URLs, Stremio add-on manifest URLs and some provider-derived playback URLs may themselves contain access tokens or credentials.
- The manifest currently has `android:allowBackup="true"`.
- No SQLCipher, AndroidX encrypted-preferences, Android Keystore wrapper, or EncryptedFile usage was found in the pinned source search.

This does not mean another ordinary Android app can freely read app-private files. Android's app sandbox is a meaningful protection. The concern is at-rest exposure in backup/device-transfer contexts, rooted or compromised devices, forensic access, and any accidental secret leakage through logs, exports or diagnostics.

## Evidence and data map

| Data | Source location | Storage | Sensitivity |
|---|---|---|---|
| Xtream username/password | `data/model/Models.kt`, `Source` entity | Room `sources` columns | High |
| Stalker MAC | `data/model/Models.kt`, `Source.macAddress` | Room `sources` column | High; acts as portal identity/credential |
| M3U playlist URL | `Source.url` | Room `sources` column | Potentially high; URL can contain a token |
| SMB username/password | `core/AppSettings.kt`, `KEY_SMB_USER`, `KEY_SMB_PASS` | `opentv_settings` SharedPreferences | High |
| TMDB API key | `core/AppSettings.kt`, `KEY_TMDB_KEY` | `opentv_settings` SharedPreferences | Medium/high |
| Stremio add-on manifest URLs | `core/AppSettings.kt`, `KEY_STREMIO_ADDONS` | JSON in `opentv_settings` | Potentially high; URL may embed access tokens |
| Other catalogue and viewing data | Room entities in `OpenTvDatabase.kt` | `opentv.db` | Personal usage/profile data |

### Database details

`OpenTvDatabase.build()` creates the Room database named `opentv.db` using the normal Room `Room.databaseBuilder`, enables WAL, and configures schema migrations. The inspected builder does not configure SQLCipher or another encrypted SQLite driver. The `Source` entity has nullable `username`, `password`, and `macAddress` fields. The app-private directory reduces exposure to other sandboxed apps, but the values are not shown to be encrypted by the application before storage.

### Preferences details

`AppSettings` obtains `opentv_settings` with `Context.MODE_PRIVATE`. SMB password and TMDB key are read and written as ordinary preference strings. No encrypted-preferences or Keystore-backed wrapper was found in the pinned source search.

### Backup details

The inspected manifest enables Android backup. No explicit `fullBackupContent` or `dataExtractionRules` reference appears in that manifest. Android backup and device-to-device transfer behavior varies by OS version and OEM, so this audit does **not** claim that every device uploads or transfers these exact files. It does establish that the app has not explicitly documented or configured exclusions in the inspected manifest.

## Recommended design — staged, migration-safe

### Stage 1: decide backup policy before editing

There are two legitimate product choices:

**Option A — Privacy-first, no credential-bearing app backup (recommended default for a TV app).**
- Explicitly exclude the provider database and `opentv_settings` from cloud backup and device-to-device transfer using the appropriate Android backup and data-extraction rules.
- Explain clearly that users will need to re-enter provider, SMB and API credentials after reinstall/device migration.
- Decide separately whether non-sensitive viewing preferences and favourites should be exportable. Do not export secrets in a plain backup.

**Option B — Restore user data, but only after a secure export design exists.**
- Do not let default platform backup copy plaintext secrets.
- Create an explicit encrypted export/import format, protected by a user-chosen passphrase or a secure device-to-device transfer key exchange.
- Keep credentials out of ordinary diagnostic exports and sync bundles.
- Provide clear recovery expectations: Android Keystore keys are device-bound and should not be assumed to migrate to another device.

Do not simply set `allowBackup=false` without reviewing the effect on all app data and testing device-to-device migration. It is a blunt setting and OEM behavior differs.

### Stage 2: protect secrets at rest

Preferred implementation path:
1. Introduce a small `CredentialVault` abstraction backed by Android Keystore AES-GCM keys.
2. Store provider password, Stalker MAC, SMB password, token-bearing playlist/add-on URLs and TMDB key as authenticated ciphertext. Keep non-secret fields queryable.
3. Avoid putting plaintext secrets into logs, crash messages, analytics, clipboard history or UI state snapshots.
4. Keep keys non-exportable in Android Keystore; handle invalidated/unavailable keys as a recoverable user re-entry case.
5. Use a versioned ciphertext envelope (version, nonce/IV, ciphertext) so future cryptographic migrations are possible.

SQLCipher is a viable alternative if whole-database encryption is desired, but it adds native binary size, ABI and build complexity. It should be evaluated separately against the supported Android TV/Fire TV device matrix rather than added casually.

### Stage 3: safe migration

- Add a schema migration or a versioned preferences migration that reads existing plaintext values, encrypts them, verifies decryption, and only then clears the old plaintext.
- Make the migration idempotent and transactional where possible.
- Do not drop the old database or use Room's destructive fallback for a credential migration.
- If encryption fails or the Keystore key is unavailable, preserve the original data and ask the user to re-enter the affected secret; never silently wipe provider configurations.
- Test fresh install, upgrade from every supported schema version, interrupted migration, app restore, uninstall/reinstall, and device-to-device transfer.

## Proposed test matrix

| Test | Expected result |
|---|---|
| Fresh install and add Xtream provider | Credentials work; stored form is ciphertext |
| Add Stalker provider | MAC is protected at rest and portal still authenticates |
| Add M3U URL with query token | Token is not exposed in plaintext database/logs |
| Configure SMB target | Password is protected; NAS test and recording still work |
| Configure TMDB key/add-on URL | Secret-bearing values are protected |
| Upgrade existing install | Existing sources and settings remain usable |
| Interrupted migration | No silent credential/data loss; retry or safe re-entry path |
| Cloud backup / restore | Matches explicitly chosen backup policy |
| Device-to-device transfer | Matches policy; Keystore secrets are not assumed portable |
| Rooted/forensic threat review | Document residual limits; app-level encryption is not a guarantee on a compromised live device |

## Decision needed before source changes

The recommended default is **Option A for automatic platform backup** (exclude the credential-bearing database and settings file) plus a later explicit encrypted export feature if users need migration. This avoids silently backing up provider secrets, but it also means favourites/catalogue/settings in the excluded files will not be restored automatically.

No source files, backup settings, database schema, credentials or APKs were changed in this review. No runtime backup/restore or physical-device test was performed. A maintainer/product decision is required before changing backup behavior because it affects user data recovery.

## Evidence files inspected

- `app/src/main/java/app/opentv/data/model/Models.kt`
- `app/src/main/java/app/opentv/data/db/OpenTvDatabase.kt`
- `app/src/main/java/app/opentv/core/AppSettings.kt`
- `app/src/main/AndroidManifest.xml`
- `app/src/main/java/app/opentv/recording/SmbClient.kt`

Pinned upstream commit: `443811904b6437720d37bb1064c0830906c3515f`.
