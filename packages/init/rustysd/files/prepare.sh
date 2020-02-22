#!/bin/sh

for DIR in $(find /containers/ -type d -maxdepth 2 -mindepth 2); do
        NAME=${DIR##*/}
        TYPE=$(echo $DIR | cut -d / -f 3)

        sed "s#{{NAME}}#$NAME#g" /etc/unitfile.tpl | \
        sed "s#{{DIR}}#$DIR#g" | \
        sed "s#{{TYPE}}#$TYPE#g" > /unitfiles/$NAME.service

        mount -t overlay overlay -o lowerdir=$DIR/lower,upperdir=$DIR/rootfs,workdir=$DIR/tmp $DIR/rootfs
done
