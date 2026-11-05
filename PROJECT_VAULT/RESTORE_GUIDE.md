# PRYNCE TV — Restore and Recovery Guide

This guide is for restoring the project on a new computer or account. It does not contain credentials.

## 1. Restore the source repository
Install Git from its official distribution, then run:

```bash
git clone --mirror https://github.com/charlestettehprince/Prynce-tv.git Prynce-tv.git
git clone https://github.com/charlestettehprince/Prynce-tv.git Prynce-tv
cd Prynce-tv
git remote -v
git branch -a
git fsck --full
```

The mirror stores Git refs and history; the normal clone is the editable working copy.

## 2. Restore the encrypted backup
Install restic and configure the same repository destination and recovery password using your password manager. Then:

```bash
restic snapshots
restic check
restic restore latest --target ./restored-prynce-tv
```

Use the actual snapshot ID instead of `latest` if you need a specific restore point. Verify the restored files before replacing anything.

## 3. Restore the Android build environment
- Install the JDK, Android SDK, and Gradle-compatible environment required by the repository.
- Open the project in Android Studio or use the documented Gradle wrapper.
- Read the repository README and workflow files for exact version requirements.
- Run tests and lint before building.
- Do not copy a debug-signed APK into a production release channel.

## 4. Reconnect external services
Git history does not restore GitHub secrets, signing keys, external provider accounts, private configuration, or expiring Actions artifacts. Recreate access using the service's official account recovery and secret-management process. Never paste credentials into ChatGPT.

## 5. Verify recovery
- [ ] Repository and branches present.
- [ ] Git integrity check passes.
- [ ] Encrypted backup decrypts and restores.
- [ ] Build environment matches documented versions.
- [ ] Tests and lint run with recorded results.
- [ ] No secrets accidentally included.
- [ ] Restore date and commit SHA recorded in CHANGELOG.md.
