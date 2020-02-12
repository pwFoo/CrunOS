ARG     KERNEL_IMAGE=$KERNEL_IMAGE
ARG     BASE_IMAGE=$BASE_IMAGE
 
FROM	$KERNEL_IMAGE AS kernel_image
FROM	$BASE_IMAGE AS modules

COPY	--from=kernel_image /modules.tar /

RUN	mkdir /out
WORKDIR	/out

RUN	tar -xf /modules.tar



FROM	scratch

COPY	--from=modules /out/ /
