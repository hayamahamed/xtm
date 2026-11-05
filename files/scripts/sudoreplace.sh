#!/usr/bin/env bash

dnf install sudo-rs

rm /usr/bin/sudo
rm /usr/bin/su

ln -s /usr/bin/sudo /usr/bin/sudo-rs
ln -s /usr/bin/su /usr/binsu-rs
