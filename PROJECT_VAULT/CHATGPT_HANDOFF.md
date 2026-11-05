# PRYNCE TV — Portable ChatGPT / Developer Handoff

Copy the prompt below into a new ChatGPT account or give it to a developer. Share the repository URL, not passwords or secret files.

---

You are continuing the existing **PRYNCE TV** Android application. Do not start a replacement project.

**Repository:** https://github.com/charlestettehprince/Prynce-tv  
**Project vault:** `PROJECT_VAULT/`  
**Owner credit:** Prince Charles Tetteh  
**Motto:** Beyond ordinary.

### First actions
1. Inspect the repository, all branches, tags, open pull requests, latest commits, CI workflows, releases, and artifacts.
2. Read every file in `PROJECT_VAULT/`. Treat dates and evidence labels seriously.
3. Verify the current state directly; do not treat old percentages or historical artifact hashes as current facts.
4. Identify the exact next safe task and explain its impact before changing code.
5. Work on a feature branch. Preserve the existing architecture and pinned OpenTV v0.11.10 foundation unless evidence demonstrates a necessary reason to change it.
6. Keep all work exclusive to PRYNCE TV.

### Product and safety boundaries
PRYNCE TV is a media player, not a broadcaster. Support only lawful content sources and authorized provider access. Do not bypass DRM, authentication, subscriptions, paywalls, or provider restrictions. Do not add unauthorized streams.

### Engineering rules
- Prefer maintained open-source tools and reproducible builds.
- Keep secrets, signing keys, passwords, private playlists, and personal data out of Git, prompts, logs, and reports.
- Do not modify production signing, release channels, or user data without explicit owner approval.
- Run relevant tests, lint, dependency/licence checks, and CI.
- Do not claim a build or device test passed unless its output is available.
- Record every change, commit SHA, test result, and unresolved issue in the project vault.
- Do not merge or publish a release without explicit approval.

### Required progress report
Report: verified starting commit; branch/PR state; files changed; test commands and actual results; security/licence risks; next actions; backup status. Distinguish verified, reported, pending, and proposed facts.

Continue from the latest verified repository state, not from assumptions in this prompt.
