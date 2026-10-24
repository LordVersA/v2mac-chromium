#!/bin/sh
# The base's sway makes every window fullscreen, which Chromium takes as F11 (no tabs, no address bar).
# Its window is still the only one, so it fills the screen without it.
SWAYSOCK=$(ls "$XDG_RUNTIME_DIR"/sway-ipc.*.sock | head -n1) swaymsg 'for_window [app_id="chromium"] fullscreen disable' >/dev/null
# Chromium's own profile lock names this container's hostname, new at every launch, so after any hard
# stop it refuses the profile ("in use on another computer") and exits. flock guards it instead: the lock
# file is on the mini VM's disk, so it holds across containers, and the kernel drops it however Chromium ends.
mkdir -p ~/.config/chromium
exec 9>~/.config/chromium/.v2mac-lock
flock -n 9 || { echo "Chromium is already open in this mini VM." >&2; exit 1; }
rm -f ~/.config/chromium/SingletonLock ~/.config/chromium/SingletonCookie ~/.config/chromium/SingletonSocket
# --no-sandbox: the container allows no user namespaces or setuid; the container and mini VM isolate it.
exec chromium --ozone-platform=wayland --no-sandbox --no-first-run --no-default-browser-check "$@"
