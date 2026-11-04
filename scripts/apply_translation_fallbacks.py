#!/usr/bin/env python3
"""Add explicit English fallbacks for known missing upstream locale resources."""
from pathlib import Path
import re

RES = Path("app/src/main/res")
KEYS = {
    "common_edit", "exit_title", "exit_body", "exit_confirm", "exit_cancel",
    "settings_edit_provider_title", "recset_pw_show", "recset_pw_hide",
    "about_support_body", "about_sponsor_github", "about_donate_paypal",
    "rec_watching_live_badge", "rec_live_warn_title", "rec_live_warn_body",
    "rec_live_warn_watch", "rec_live_warn_keep",
}

source = (RES / "values/strings.xml").read_text(encoding="utf-8")
fallbacks = {}
for key in KEYS:
    match = re.search(
        rf'^\s*<string\s+name="{re.escape(key)}"[^>]*>.*?</string>\s*$',
        source, re.MULTILINE,
    )
    if not match:
        raise SystemExit(f"Missing default string resource: {key}")
    fallbacks[key] = match.group(0).strip()

updated = 0
for folder in sorted(RES.glob("values-*")):
    target = folder / "strings.xml"
    if not target.is_file():
        continue
    text = target.read_text(encoding="utf-8")
    additions = [
        fallbacks[key] for key in sorted(KEYS)
        if not re.search(rf'<string\s+name="{re.escape(key)}"', text)
    ]
    if not additions:
        continue
    block = (
        "\n    <!-- English fallback for strings not yet translated in this locale. -->\n"
        + "\n".join("    " + item for item in additions)
        + "\n"
    )
    if "</resources>" not in text:
        raise SystemExit(f"Malformed resource file: {target}")
    target.write_text(text.replace("</resources>", block + "</resources>", 1), encoding="utf-8")
    updated += len(additions)
    print(f"{target}: added {len(additions)} English fallback(s)")

print(f"Translation fallback pass complete: {updated} entries added; existing translations preserved.")
