#!/usr/bin/env bash

dnf install sudo-rs

rm /usr/bin/sudo
rm /usr/bin/su

ln -s /usr/bin/sudo-rs /usr/bin/sudo
ln -s /usr/bin/su-rs /usr/binsu
