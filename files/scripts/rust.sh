#!/usr/bin/env bash
set -euo pipefail

# Replacing possible things with memory safe rust
# ================================================
# Current Status:
# 	- Default shell : Nushell
# 	- /bin/sudo & /usr/bin/sudo --> sudo-rs but sudo as a package exists
#	- GNU Core Utils with Uutils
#		- N/A



rm /usr/bin/sudo && ln -s /usr/bin/sudo-rs /usr/bin/sudo
rm /usr/bin/su   && ln -s /usr/bin/su-rs /usr/bin/su
