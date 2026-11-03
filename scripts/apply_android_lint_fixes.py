#!/usr/bin/env python3
"""Apply small, deterministic PRYNCE TV compatibility fixes to the pinned OpenTV checkout.

The upstream submodule remains pinned and unmodified in Git. This script applies the
reviewed local build-time patch set after checkout so CI reproduces the exact source
that is compiled. Fail loudly if upstream source changes invalidate a patch.
"""
from pathlib import Path

ROOT = Path("app/src/main")
FILES = {
    "recording": ROOT / "java/app/opentv/recording/RecordingAlarmReceiver.kt",
    "reminder": ROOT / "java/app/opentv/reminders/ReminderAlarmReceiver.kt",
    "activity": ROOT / "java/app/opentv/MainActivity.kt",
}


def add_imports(path: Path, anchor: str, imports: str) -> None:
    text = path.read_text()
    if "import android.Manifest" in text and "import androidx.core.content.ContextCompat" in text:
        return
    if anchor not in text:
        raise SystemExit(f"Import anchor not found in {path}")
    path.write_text(text.replace(anchor, imports + anchor, 1))


def replace_once(path: Path, old: str, new: str) -> None:
    text = path.read_text()
    if new in text:
        return
    if old not in text:
        raise SystemExit(f"Expected source block not found in {path}; refusing a blind patch")
    path.write_text(text.replace(old, new, 1))


permission_imports = (
    "import android.Manifest\n"
    "import android.content.pm.PackageManager\n"
    "import androidx.core.content.ContextCompat\n"
)

for key in ("recording", "reminder"):
    add_imports(FILES[key], "import android.app.Notification\n", permission_imports)

replace_once(
    FILES["recording"],
    """    private fun safeNotify(context: Context, id: Int, notification: Notification) {
        runCatching { NotificationManagerCompat.from(context).notify(id, notification) }
    }""",
    """    private fun safeNotify(context: Context, id: Int, notification: Notification) {
        // Android 13+ makes notification permission runtime-grantable. Alarm delivery must
        // remain safe when the viewer has declined it.
        if (
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) !=
                PackageManager.PERMISSION_GRANTED
        ) return
        runCatching { NotificationManagerCompat.from(context).notify(id, notification) }
    }""",
)

replace_once(
    FILES["reminder"],
    """        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_BASE + reminder.id.toInt(), builder.build() as Notification)""",
    """        // Android 13+ makes notification permission runtime-grantable. Do not crash when
        // a viewer has declined notifications; the reminder has still been processed.
        if (
            Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU &&
            ContextCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) !=
                PackageManager.PERMISSION_GRANTED
        ) return
        NotificationManagerCompat.from(context)
            .notify(NOTIFICATION_BASE + reminder.id.toInt(), builder.build() as Notification)""",
)

replace_once(
    FILES["activity"],
    """    fun enterPipNow() {
        if (!supportsPip()) return""",
    """    fun enterPipNow() {
        // Keep the API-level guard local so static analysis can verify calls introduced in API 26.
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.O || !supportsPip()) return""",
)

print("Applied and verified Android notification-permission and PiP API guards.")
