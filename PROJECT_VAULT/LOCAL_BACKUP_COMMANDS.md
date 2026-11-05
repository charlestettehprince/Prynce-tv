# PRYNCE TV — Local Backup Commands

These commands are templates for the project owner to run on a trusted computer. They do not run from GitHub and do not transmit credentials to ChatGPT.

## Requirements
- Git
- restic
- A backup destination you control
- A strong restic repository password stored separately in a password manager

## Linux / macOS / Git Bash: create or refresh a mirror
```bash
git clone --mirror https://github.com/charlestettehprince/Prynce-tv.git Prynce-tv.git
cd Prynce-tv.git
git remote update --prune
git fsck --full
cd ..
```

If the mirror already exists, run the refresh commands inside it; do not clone over it.

## Encrypted backup with restic
Set the repository location using the destination type you selected. Examples:
```bash
export RESTIC_REPOSITORY="/path/to/encrypted-backup-repository"
# Enter password interactively when restic prompts; do not put it in shell history.
restic init
restic backup ./Prynce-tv ./Prynce-tv.git
restic snapshots
restic check
```

For cloud destinations, configure the relevant restic backend using its official documentation. Avoid embedding cloud keys or passwords in this file. If a repository is already initialized, skip `restic init`.

## Windows PowerShell
```powershell
git clone --mirror https://github.com/charlestettehprince/Prynce-tv.git Prynce-tv.git
git -C .\Prynce-tv.git remote update --prune
git -C .\Prynce-tv.git fsck --full
```

For encrypted backups on Windows, install restic and follow its official documentation for setting a repository path and securely entering the password. Do not save the password in a .ps1 file.

## Important
- A Git mirror does not contain GitHub Actions artifacts, GitHub secrets, private signing keys, provider accounts, or content outside the repository.
- Back up only project-owned assets that you are authorized to store.
- Never commit the encrypted backup repository into the source repository.
- Test restoration before relying on a backup.
- These commands have not been executed as part of this documentation update.
