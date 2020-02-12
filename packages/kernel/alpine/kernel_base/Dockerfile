ARG	KERNEL_BASE=$KERNEL_BASE
FROM	$KERNEL_BASE AS kernel

ARG	KERNEL_BASE_PKG=$KERNEL_BASE_PKG
RUN	apk --update --no-cache add \
	$KERNEL_BASE_PKG

RUN 	for d in /lib/modules/*; do depmod -b . $(basename $d); done

RUN 	mkdir /out

RUN	mv /boot/vmlinuz-*    /boot/kernel
RUN	mv /boot/config-*     /boot/config
RUN	mv /boot/System.map-* /boot/System.map

RUN	tar -C /boot -cf /out/kernel.tar kernel config System.map
RUN 	tar -cf /out/modules.tar /lib/modules
RUN	tar -cf /out/firmware.tar /lib/firmware

RUN	ls -lh /out/


FROM	scratch

COPY 	--from=kernel /out/ /
