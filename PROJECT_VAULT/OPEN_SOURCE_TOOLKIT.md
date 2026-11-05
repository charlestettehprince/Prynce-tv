# PRYNCE TV — Open-Source Toolkit

This is a recommended toolkit, not a claim that every tool is installed or configured.

| Need | Tool | Purpose |
|---|---|---|
| Source history | Git | Version control and portable history |
| Git hosting | GitHub or self-hosted Forgejo | Primary remote and optional independent mirror |
| Local Git web UI | Forgejo | Self-hosted repository interface |
| Encrypted backups | restic | Deduplicated, encrypted backup snapshots |
| Cloud/object sync | rclone | Transfer/sync to supported storage; pair with encryption |
| File encryption | age | Simple public-key file encryption |
| Password storage | KeePassXC | Offline password vault |
| Local file sync | Syncthing | Device-to-device folder synchronization |
| Search documentation | Meilisearch | Searchable local project docs if a local knowledge portal is later built |
| Self-hosted meta-search | SearXNG | Privacy-respecting meta-search for research |
| Android build | Android Gradle Plugin / Gradle | Reproducible app builds; verify versions from repo |
| Static checks | Android Lint, tests | Code quality and regression checks |
| Dependency audit | OWASP Dependency-Check or OSV-Scanner | Identify known dependency vulnerabilities |
| SBOM | Syft | Generate a software bill of materials |
| Vulnerability scan | Grype | Scan images/filesystems/SBOMs where applicable |

## Recommended simple setup
Start with Git + a private Git mirror + restic + KeePassXC. Add Syncthing for laptop/desktop transfer. Add SearXNG or Meilisearch only if a searchable knowledge portal is genuinely needed.

## Safety and maintenance
- Download tools from their official project sites or verified package repositories.
- Pin tool versions for repeatable builds.
- Review licences and maintenance activity before adopting a dependency.
- Avoid installing a large self-hosted stack on a low-resource laptop unless it solves a real problem.
- Never use search results to bypass provider access controls or obtain unauthorized streams.
