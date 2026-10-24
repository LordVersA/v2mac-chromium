# Chromium for V2Mac Sandbox

Chromium (the open-source browser behind Google Chrome) as a V2Mac Secure Sandbox app: it runs in a
mini VM, every site sees only that mini VM's exit server, and the time zone follows the exit.

Google Chrome itself has no Linux ARM64 build, and the sandbox runs ARM64, so this is Debian's
Chromium package. Install it from the V2Mac Store in the Sandbox window.

- Permissions: clipboard (copy and paste with the Mac) and Shared (downloads and uploads go through
  `~/V2Mac Sandbox/<Mini VM>/Shared`; save there as `~/Shared`).
- Chromium runs with `--no-sandbox`: the mini VM's container allows no user namespaces or setuid, so
  Chromium's own sandbox can't start. The container and the mini VM are the isolation.

Build: `Scripts/package.sh . "$(cat base.txt)" <url prefix>`. Release: push a `v*` tag; the workflow
attaches the image and the filled `plugin.json`, which is submitted to the V2Mac store.
Built from [v2mac-plugin-template](https://github.com/LordVersA/v2mac-plugin-template). Licence: 0BSD.
