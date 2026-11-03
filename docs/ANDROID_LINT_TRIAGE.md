# PRYNCE TV — Android Lint Triage

**Audit date:** 3 November 2026  
**Repository:** `charlestettehprince/Prynce-tv`  
**Latest inspected workflow:** [Run #107 / 41629319388](https://github.com/charlestettehprince/Prynce-tv/actions/runs/41629319388)  
**Branch:** `fix/locale-formatting-lint`  
**Lint report artifact:** `13227652811` (`prynce-tv-android-lint-reports`)  
**Report files:** `lint-results-debug.xml` and `lint-results-debug.html`  
**Lint tool version:** 8.9.1

## Result

The archived XML contains **187 findings: 184 warnings, 3 informational findings, and zero errors/fatal findings**. The CI lint task completed successfully. This means the configured lint gate passed; it does not mean every warning is fixed or that the app has passed device acceptance.

| Finding ID | Count | Triage |
|---|---:|---|
| GradleDependency | 73 | Review update candidates in controlled groups; do not bulk-upgrade, especially Media3/Compose/AndroidX, without compatibility and regression checks. |
| UseKtx | 37 | Low-risk maintainability opportunities; batch by API family and preserve behavior. |
| MissingTranslation | 18 | User-facing localization backlog. The 18 base-string keys are missing in multiple configured locales; do not silence the check as a substitute for translations. |
| UnusedResources | 14 | Verify generated/dynamic references and build-time injected resources before removal. |
| IconLocation | 7 | Bitmap-density placement warnings for branding assets. Confirm intended scaling and density behavior before moving resources. |
| IconLauncherShape | 5 | Round launcher icon shape warnings. Review adaptive/round icon behavior on real launchers before changing owner-approved artwork. |
| IconDuplicates | 1 | Two icon files have identical contents; check whether both are intentionally referenced before deduplication. |
| PluralsCandidate | 8 | Convert count-bearing strings to Android plurals with correct locale rules and call-site updates. |
| ModifierParameter | 4 | Compose API consistency cleanup; low risk but verify call sites. |
| ConstantLocale | 4 | Avoid capturing the default locale in static/final values if runtime locale changes must be reflected. |
| AndroidGradlePluginVersion | 3 | Version advisory only; evaluate a separate toolchain upgrade with CI compatibility checks. |
| AutoboxingStateCreation | 3 | Informational Compose state optimization suggestions. |
| ObsoleteSdkInt | 2 | Remove only after confirming minSdk and intended compatibility branches. |
| UseTomlInstead | 2 | Move remaining dependency declarations into the version catalog if that improves consistency. |
| AppBundleLocaleChanges | 1 | Decide whether dynamic language changes require Play language-split configuration; validate the intended distribution model. |
| PictureInPictureIssue | 1 | **Higher priority:** review PiP auto-entry and source-rectangle behavior on supported Android versions; test phone and TV behavior. |
| DiscouragedApi | 1 | **Higher priority:** fixed orientation restriction may letterbox or constrain other form factors. Review the manifest and preserve intended TV landscape behavior without unnecessarily locking phone/tablet layouts. |
| UsableSpace | 1 | Review storage-space checks and whether allocatable-space APIs improve recording/storage decisions. |
| LocaleFolder | 1 | Review the legacy Indonesian resource qualifier naming and migration impact. |
| Typos | 1 | Verify the reported repeated word in the Turkish translation before editing. |
| IconDuplicates | 1 | Two icon files have identical contents; check whether both are intentionally referenced before deduplication. |

## Recommended execution order

1. **Behavior and form-factor:** inspect PiP guidance and fixed-orientation manifest entry. Make narrowly scoped changes only after reading the exact source and checking the Android-version guards.
2. **Locale correctness:** inspect the four default-locale formatting findings and four static-locale captures. Correct runtime behavior without changing translation semantics.
3. **Localization and pluralization:** map the 18 untranslated keys and eight plural candidates; prioritize the languages the product intends to ship, and do not invent translations.
4. **Branding resources:** inspect the five round-icon findings, seven densityless bitmap findings, and duplicate icon warning. Preserve the original PRYNCE artwork and validate launcher resources on devices.
5. **Safe cleanup:** review unused resources, KTX suggestions, Compose modifier naming, and storage API recommendation. Check generated/build-time references before deleting anything.
6. **Dependency/toolchain maintenance:** review the 73 dependency advisories and three Android Gradle Plugin advisories in a compatibility matrix. Keep OpenTV pinned and avoid a broad dependency jump until a separate build/test run proves compatibility.

## Guardrails

- Do not disable or suppress warnings merely to make the report look clean.
- Do not blindly update dependencies or change the pinned OpenTV engine.
- Do not remove resources until generated and dynamic references are checked.
- Do not alter or redraw the original PRYNCE logo/wordmark.
- No source changes were made as part of this triage. This is an evidence-based report from the downloaded CI artifact, not a device test.
- The successful CI lint task is not proof of real Android phone/Android TV playback, PiP behavior, launcher appearance, or offline behavior.

## Evidence

The report was downloaded from GitHub Actions artifact `13227652811` for workflow run `41629319388`. The XML was parsed independently and grouped by lint issue ID and severity. Reconciliation against the pinned source confirmed the orientation advisory is attached to `screenOrientation="fullUser"`, which is not a fixed portrait/landscape lock. The latest report has no `DefaultLocale` findings after the two recording-size formatter patches in PR #8. Android's official guidance describes lint as static analysis and recommends fixing relevant findings before publishing: [Android lint documentation](https://developer.android.com/studio/write/lint).
