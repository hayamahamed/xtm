#!/usr/bin/env bash


rm /usr/bin/sudo
rm /usr/bin/su

ln -s /usr/bin/sudo-rs /usr/bin/sudo
ln -s /usr/bin/su-rs /usr/binsu
