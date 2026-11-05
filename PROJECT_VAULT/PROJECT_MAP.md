# PRYNCE TV — Project Map

## Product boundary
PRYNCE TV is an Android media player. It is not a content broadcaster or a source of unlicensed streams. Integrations must use lawful, authorized provider access and respect provider terms, authentication, DRM, and subscriptions.

## Primary source of truth
- Git repository: https://github.com/charlestettehprince/Prynce-tv
- Main development branch: `main`
- Documentation vault branch: `docs/prynce-tv-project-vault`
- Upstream player foundation recorded by project README: OpenTV v0.11.10

## Areas to inventory during a full recovery
- Android application source and Gradle configuration
- App branding, icons, themes, layouts, and localization
- Player engine integration and provider configuration boundaries
- Unit, instrumentation, lint, and UI tests
- GitHub Actions workflows and build artifacts
- Dependency versions and licence notices
- Privacy policy, permissions, and data-handling notes
- Release signing and distribution process
- Device compatibility matrix

## Separation rules
- Keep PRYNCE TV code, issues, releases, credentials, documentation, and backups separate from every other PRYNCE project.
- Never copy another project's Supabase project, database, Wix site, domain, API keys, or user data into PRYNCE TV.
- Do not introduce a backend or user-account system unless a documented product requirement justifies it.
- Prefer local/offline operation where consistent with the existing architecture and product requirements.

## Recovery checklist
- [ ] Clone the repository and fetch all branches/tags.
- [ ] Record commit SHAs and open/closed PRs.
- [ ] Inventory source modules, dependencies, workflows, tests, and licences.
- [ ] Identify build instructions and required SDK/JDK versions.
- [ ] Inventory app permissions and network endpoints.
- [ ] Identify provider configuration format without copying private credentials.
- [ ] Record supported devices and known defects.
- [ ] Verify artifact provenance and signatures.
