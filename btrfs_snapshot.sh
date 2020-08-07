#!/bin/bash

#______________________________________________________________________________
#----- make snapshots for subvolumes @ @home ----------------------------------
#----- DISK - btrfs device ----------------------------------------------------

DISK="/dev/nvme0n1p4"

mkdir -p /mnt/btrfs
STATUS=`(mount -t btrfs $DISK /mnt/btrfs &>/dev/null && echo OK) || echo Fail`
if [[ "$STATUS" = "OK" ]]
then
	mkdir -p /mnt/btrfs/snapshots

	for SUB in @ @home
	do
		btrfs subvolume snapshot /mnt/btrfs/${SUB} /mnt/btrfs/snapshots/${SUB}_$(date +"%y-%m-%d_%H-%M")
	done
	echo "Snapshot created"
	umount /mnt/btrfs
else
	echo "FAIL"
fi
