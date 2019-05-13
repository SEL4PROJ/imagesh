#!/bin/bash

# This script is to convert a user to use the imageshell on this machine

set -e

USER="$1"

id $USER &> /dev/null || ( echo "Not heard of the login: $USER"; exit 1 )

# Add some uid space for the rootless containers
for f in /etc/subuid /etc/subgid; do
	grep "$USER" "$f" &> /dev/null && ( echo "$USER already in $f. Bailing out!" && exit 1 )
	echo "$USER:100000:65536" >> "$f"
done

# Make a homedir for them, and set it up
(
	mkdir /export/home/"$USER"
	chown "$USER":"$USER" /export/home/"$USER"
	echo >> /etc/auto.home "$USER	:/export/home/&"
	cd /export/home/"$USER"
	ln -fs /net/nfshomes/export/home/insecure/"$USER" nfshome
	systemctl restart autofs
)

# Override the ldap shell with the imagesh one
sss_override user-add "$USER" -s /usr/local/bin/imagesh
