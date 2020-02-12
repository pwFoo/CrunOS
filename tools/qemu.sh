#!/bin/sh

MEMORY=1024M
PROJECT_NAME=rustysd
DIR=$(dirname $(find . -name rustysd-kernel))
INITRD="$DIR/$PROJECT_NAME-initrd.img"
KERNEL="$DIR/$PROJECT_NAME-kernel"
APPEND="console=ttyAMA0,115200 console=tty highres=off console=ttyS0 random.trust_cpu=on"


while [ "$1" != "" ]; do
        case $1 in
		-m|-mem)
			shift
			MEMORY=$1
		;;
		-a|-append)
			shift
			APPEND=$1
		;;
		-i|-initrd)
			shift
			INITRD=$1
		;;
        esac
        shift
done


/usr/bin/qemu-system-x86_64 -m $MEMORY -enable-kvm -kernel $KERNEL -initrd $INITRD -nographic -device pvpanic -append "$APPEND"
