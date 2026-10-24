#!/bin/sh
# The base's sway makes every window fullscreen, which Chromium takes as F11 (no tabs, no address bar).
# Its window is still the only one, so it fills the screen without it.
SWAYSOCK=$(ls "$XDG_RUNTIME_DIR"/sway-ipc.*.sock | head -n1) swaymsg 'for_window [app_id="chromium"] fullscreen disable' >/dev/null
# --no-sandbox: the container allows no user namespaces or setuid; the container and mini VM isolate it.
exec chromium --ozone-platform=wayland --no-sandbox --no-first-run --no-default-browser-check "$@"
