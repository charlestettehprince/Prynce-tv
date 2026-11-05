# PRYNCE TV — Backup and Portability Plan

## Goal
Make the complete PRYNCE TV project recoverable on a new laptop, GitHub account, cloud provider, or ChatGPT account without depending on one chat history.

## Recommended 3-2-1 approach
Keep at least 3 copies, on 2 different storage types, with 1 encrypted copy off-site:
1. Working copy on the laptop.
2. GitHub repository and a second private Git mirror under an account controlled by the owner.
3. Encrypted backup on a separate cloud storage account or external drive.

A second Gmail address is useful for account recovery and notifications, but email is not a project backup system.

## What must be backed up
- Full Git repository history, all branches, and tags.
- Project documentation and decision log.
- Build configuration and workflow files.
- Release notes and checksums.
- Non-secret configuration templates (for example, `.env.example`).
- Test reports and approved screenshots.
- Any project-owned assets with clear licence/ownership.
- Provider setup instructions, but not private playlists, passwords, or tokens.

## What must never be placed in Git or this vault
- Passwords, API keys, access tokens, service-role keys.
- Android keystores, signing passwords, private certificates.
- Private provider playlists or subscription details.
- Personal data or user viewing history.
- Any copyrighted provider media that the project is not authorized to redistribute.

Store secrets in a reputable password manager or encrypted secret store. Keep an offline recovery method for the password manager.

## Portable Git mirror
On a trusted computer with Git installed:
```bash
git clone --mirror https://github.com/charlestettehprince/Prynce-tv.git Prynce-tv.git
cd Prynce-tv.git
git remote -v
git fsck --full
```
Keep this mirror private. To refresh it later:
```bash
git remote update --prune
git fsck --full
```
A mirror clone is a Git repository backup; it does not include GitHub Actions artifacts, secrets, releases stored outside Git, or external provider content. Export those separately where appropriate.

## Encrypted file backup with restic (proposed)
Use restic with a strong unique repository password and an off-site destination. Store the password separately in a password manager and a sealed recovery method. Test restoration regularly; an untested backup is not a recovery plan.

## External storage sync with rclone (proposed)
Use rclone only after verifying the destination account and encryption configuration. Prefer rclone crypt for cloud copies. Do not sync plaintext secrets.

## Backup verification
- [ ] Confirm mirror contains all expected branches and tags.
- [ ] Run `git fsck --full`.
- [ ] Confirm archive and backup sizes.
- [ ] Restore to a clean folder or spare machine.
- [ ] Build from the restored copy.
- [ ] Check that no secrets were included.
- [ ] Record date, tool versions, commit SHA, and restore result.

## Limits
GitHub is not a full backup of every external service. Actions artifacts expire; GitHub secrets are not exportable as plain text; external storage and provider data require separate lawful backups. No backup or restore was performed by adding this document.
