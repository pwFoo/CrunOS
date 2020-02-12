ARG     KERNEL_IMAGE=$KERNEL_IMAGE
ARG     BASE_IMAGE=$BASE_IMAGE
 
FROM	$KERNEL_IMAGE AS kernel_image

FROM	$BASE_IMAGE AS kernel

RUN	mkdir -p /out /lib/modules /lib/firmware

COPY    files/ /

# kernel
COPY	--from=kernel_image /kernel.tar /

RUN	tar -xf /kernel.tar -C /out

## modules
#COPY    --from=kernel_image /modules.tar /
#
#RUN	tar -xf /modules.tar
#
#RUN	/collect-modules.sh "" /mnt
#
#WORKDIR	/mnt
#
#RUN	tar cf /out/kernel.tar lib/modules		# empty modules at the moment (preselected modules doesn't work?!)
RUN	tar cf /out/kernel.tar /lib/modules  		# empty archive to not break the build...

# firmware
#COPY	--from=kernel_image /firmware.tar /
RUN	tar cf /out/firmware.tar /lib/firmware		# empty firmware at the moment

# debug
RUN	ls -lh /out
RUN	tar -tf /out/kernel.tar
RUN	tar -tf /out/firmware.tar



FROM	scratch

COPY	--from=kernel /out/ /
