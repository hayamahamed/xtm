#!/usr/bin/env nu

dnf install sudo-rs

rm /usr/bin/sudo
rm /usr/bin/su

ln -s sudo sudo-rs
ln -s su su-rs
