# CLAUDE.md (chromium)

Secure Sandbox plugin: Debian's Chromium, `display: gui`. Made from `../plugin-template`; its
`docs/plugin-api.md` is the API and `../store/REVIEW.md` what the store checks.

- Debian packages only, `FROM` the base pinned in `base.txt` (from `../store/bases.json`). Google
  Chrome has no Linux arm64 build; don't add Google's repo.
- `start.sh` turns sway's forced fullscreen off for Chromium (fullscreen hides its tabs and address
  bar) and passes `--ozone-platform=wayland` (the base has no Xwayland) and `--no-sandbox`.
- Test locally: `Scripts/package.sh . "$(cat base.txt)" http://127.0.0.1:8765`, then run the image
  with the sandbox's flags (`--cap-drop=all --read-only`, tmpfs `/tmp`) under headless sway.
- Release: bump `version` and `changelog` in `plugin.json`, tag `vX.Y.Z` when the user says, then a
  store PR changing `submissions/chromium.json`. Public repo: `LordVersA/v2mac-chromium`.
