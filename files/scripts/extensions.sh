#!/usr/bin/bash
set -u

BMS=blur-my-shell@aunetx
DTD=dash-to-dock@micxgx.gmail.com
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/carbonwarp"
MARK="$STATE_DIR/extensions-defaults-v2"
LOG="$STATE_DIR/extensions-defaults.log"

[ -e "$MARK" ] && exit 0

is_active() {
  gnome-extensions info "$1" 2>/dev/null | grep -q 'State: *ACTIVE'
}

# Wait up to 60s for both extensions to be running
for _ in $(seq 1 60); do
  is_active "$BMS" && is_active "$DTD" && break
  sleep 1
done

# Not running (e.g. version mismatch): change nothing, try again next login
is_active "$BMS" && is_active "$DTD" || exit 0

# Let the extensions finish writing their own settings first
sleep 3

mkdir -p "$STATE_DIR"

set_key() {
  gsettings set "$@" 2>>"$LOG" || echo "FAILED: $*" >>"$LOG"
}

# ---- Blur my Shell first ----
B=org.gnome.shell.extensions.blur-my-shell

# Top bar: dynamic, sigma 0, background blur on, transparent
set_key $B.panel blur true
set_key $B.panel static-blur false
set_key $B.panel sigma 0
set_key $B.panel brightness 1.0
set_key $B.panel override-background true
set_key $B.panel style-panel 0

# Leave the dock to Dash to Dock
set_key $B.dash-to-dock blur false
set_key $B.dash-to-dock override-background false

# Everything else off
for group in overview appfolder lockscreen screenshot applications window-list coverflow-alt-tab; do
  set_key $B.$group blur false
done

# ---- Dash to Dock after ----
D=org.gnome.shell.extensions.dash-to-dock

set_key $D show-trash false
set_key $D show-mounts false
set_key $D background-opacity 0.0
set_key $D transparency-mode 'FIXED'
set_key $D dock-position 'BOTTOM'
set_key $D dash-max-icon-size 34
set_key $D custom-theme-shrink false

touch "$MARK"
