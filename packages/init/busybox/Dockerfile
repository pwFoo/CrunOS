ARG     BASE_IMAGE=$BASE_IMAGE
FROM    $BASE_IMAGE AS busybox

RUN	apk --update --no-cache add \
	busybox-static

WORKDIR	/rootfs

RUN	mkdir -p \
	run/resolvconf \
	lib/firmware \
	var/log \
	proc \
	sys \
	dev \
	run \
	tmp \
	bin
	
RUN	echo "nameserver 8.8.8.8" > run/resolvconf/resolv.conf

RUN	cp -a /bin/busybox.static bin/busybox

RUN	chroot /rootfs /bin/busybox --install -s /bin/

RUN	chroot /rootfs ln -s /bin/busybox /init

COPY	files/ /rootfs/


FROM	scratch

COPY	--from=busybox /rootfs/ /
