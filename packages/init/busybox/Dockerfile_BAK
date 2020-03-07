ARG	BASE_IMAGE=$BASE_IMAGE
FROM	$BASE_IMAGE AS rootfs

WORKDIR	/rootfs

RUN	mkdir -p \
	run/resolvconf \
	etc/unitfiles \
	lib/firmware \
	lib/modules \
	var/log \
	var/lib \
	proc \
	root \
	etc \
	mnt \
	dev \
	sys \
	run \
	tmp

RUN	ln -s ../tmp var/tmp
RUN	ln -s ../run var/run

RUN     ln -s /var/lib/apk var/lib/apk
RUN     ln -s /etc/apk etc/apk

### alpine busybox
#RUN	apk --update --no-cache --root /rootfs --initdb add \
#	busybox 

# alpine static busybox
RUN	apk --update --no-cache --root /rootfs --initdb add \
	busybox-static
RUN	mv /rootfs/bin/busybox.static /rootfs/bin/busybox
#RUN	mkdir -p usr
#RUN	ln -s bin usr/sbin
RUN	ln -s bin sbin


RUN	rm -rf \
	var/lib/apk \
	etc/apk \
	dev/* \
	etc/logrotate.d \
	etc/network \
	etc/udhcpd.conf \
	lib/apk \
	root \
	usr/etc \
	var/cache \
	var/lib/*

RUN     ln -s bin/busybox init

RUN	chroot /rootfs /bin/busybox --install -s /bin

#RUN	cp -a \
#	/etc/passwd \
#	/etc/group \
#	\
#	etc/
#
RUN	echo "nameserver 8.8.8.8" > run/resolvconf/resolv.conf
#
#RUN	chroot /rootfs echo root:password | /usr/sbin/chpasswd 

COPY	files/ /rootfs/


FROM	scratch

COPY	--from=rootfs /rootfs/ /
