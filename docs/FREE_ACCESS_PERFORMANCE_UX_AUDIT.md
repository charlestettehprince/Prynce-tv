# PRYNCE TV — Free Access, Onboarding and Performance Audit

**Date:** 3 November 2026  
**Scope:** User's requirement that PRYNCE TV and its public website remain free to access, simple to enter, and fast on phones and TV devices. Static review only.

## Product access policy

1. PRYNCE TV should be free to download and use. Do not introduce a PRYNCE-paid subscription, paywall, or mandatory PRYNCE account for basic playback, browsing, local profiles, favourites or settings.
2. The app is a media player, not a broadcaster. Users may need an account or paid plan from a separate TV/IPTV provider to access that provider's content. That provider's price, terms and availability are independent of PRYNCE. PRYNCE must not promise free access to channels or content it does not own or have rights to distribute.
3. Keep public PRYNCE website information and the TV directory readable without signing in. A website login should be reserved for private administration or genuinely optional account features; never make it a gate to the public homepage or basic TV information.
4. The current app's provider credentials are not a PRYNCE account. They are details the viewer enters for a provider they are authorised to use.
5. Existing profiles are local app profiles, not a PRYNCE cloud identity. Do not label them as account login or add mandatory cloud registration without a separate product decision.

## What the source review confirms

### Free / no mandatory PRYNCE login
- The pinned OpenTV onboarding flow checks whether a media source is configured. A first-time user is sent to the add-source screen; a returning user goes to the home screen.
- The onboarding screen offers M3U playlist, Xtream-compatible provider and Stalker portal setup.
- The app contains local profiles and local data storage, but the inspected launch/navigation flow does not show a mandatory PRYNCE user-account sign-in gate.
- TV setup includes phone-assisted pairing to reduce typing on a television remote.
- The README defines PRYNCE TV as a player and explicitly requires authorised user sources.

### Existing speed foundations
- The app uses Jetpack Compose and lazy ServiceLocator properties for most repositories and clients.
- The application has an app-wide Coil image loader, a memory cache, a 256 MB disk image cache, disabled crossfades and RGB_565 for opaque images. This is intended to reduce repeat downloads and image memory use, but the cache's real impact on low-memory devices has not been benchmarked.
- Startup maintenance and EPG synchronisation are launched in a background coroutine scope rather than awaited before the first frame. Their CPU, network and battery impact still needs profiling.
- Release configuration already enables R8 minification and resource shrinking.
- The reviewed app Gradle file does not configure the AndroidX Baseline Profile plugin or a dedicated Macrobenchmark module.
- No cold-start trace, time-to-interactive measurement, frame-jank benchmark, low-memory test or real-device performance result was available in this audit.

## UX and performance work plan

### Priority 1 — keep first use simple
- Launch into a clear home/onboarding screen with two obvious paths: **Browse official TV links** and **Connect my TV provider**.
- Explain in plain language that PRYNCE TV is free, while a third-party provider may charge separately.
- Keep browsing and public information available before provider setup.
- Use the existing phone-to-TV pairing route and make QR instructions short.
- Offer paste/autofill for long provider details, with clear show/hide password control and safe error messages.
- Do not add mandatory PRYNCE registration. If optional sync/account features are ever introduced, preserve guest mode.

### Priority 2 — measurable speed
- Add AndroidX Baseline Profiles for the real first-run and returning-user journeys. Android's documentation reports that Baseline Profiles can improve code execution speed from first launch; the actual gain must be measured on PRYNCE devices.
- Add Macrobenchmark startup tests and record cold-start TTID/TTFD on a representative low-end phone and Android TV device.
- Keep first frame independent of network, EPG refresh and optional background maintenance.
- Profile database opening, first source load, guide loading, image decoding, Compose recomposition and navigation before changing cache sizes or dependencies.
- Use WebP/vector assets where suitable; retain original owner branding.
- Track memory, network bytes and battery on low-memory/slow-connection devices. Avoid making the image cache larger until profiling shows it helps.

### Priority 3 — simple, accessible navigation
- Keep the primary actions visible and labels plain.
- Ensure touch targets are comfortable on phones and focus targets are clear on TV remotes.
- Support keyboard, D-pad, screen readers, scalable text and reduced motion.
- Make back navigation predictable and avoid duplicate or deeply nested navigation.
- Show useful offline/error states instead of indefinite spinners.
- Keep advanced provider options out of the initial path unless requested.

### Priority 4 — public website access
- Public pages should load without account creation, payment or membership.
- Use one clear PRYNCE TV entry point from the main PRYNCE website.
- Keep sign-in out of the public browsing path. Wix owner/editor access remains a separate administrative login.
- If a visitor-facing account is later needed, make it optional and provide account recovery; do not make it a condition for reading public pages or opening official broadcaster destinations.

## Acceptance targets (to measure, not claim)

- Cold-start time-to-first-frame and time-to-interactive: measure with Macrobenchmark on actual devices; set a target after baseline data.
- Returning-user launch: no provider re-entry if the user has already saved a source.
- First-time path: reach official directory or provider setup without account creation.
- Phone and TV: all key actions reachable by touch and D-pad.
- Slow connection: public directory and saved local information remain usable; network-dependent provider playback clearly reports connectivity.
- No mandatory PRYNCE subscription, paywall or login gate for basic use.

## Decisions / boundaries

- Keep the current OpenTV engine and existing Wix website. No platform migration is justified by this audit.
- Do not introduce paid services or recurring infrastructure solely to implement basic free access.
- Third-party provider subscriptions are outside PRYNCE's control; do not advertise protected channels as free.
- No source code, UI, website, authentication configuration, account data or app binary was changed during this audit.
- No physical device test or performance benchmark was run. This report is a verified static review and implementation plan, not proof of measured speed.

## Reference

- Android app startup and Baseline Profile guidance: https://developer.android.com/topic/performance/appstartup/best-practices
- Android authentication and onboarding guidance: https://developer.android.com/design/ui/mobile/guides/patterns/onboarding
- Android passkey guidance: https://developer.android.com/design/ui/mobile/guides/patterns/passkeys
