#!/bin/sh
cat >> $1/etc/fstab <<EOF
#/dev/sda1	/var/lib	xfs	defaults	0	0
EOF
