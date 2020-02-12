ARG     KERNEL_IMAGE=$KERNEL_IMAGE
ARG     BASE_IMAGE=$BASE_IMAGE

FROM    $KERNEL_IMAGE AS kernel_image


FROM    $BASE_IMAGE AS firmware

COPY    --from=kernel_image /firmware.tar /

RUN     mkdir /out
WORKDIR /out

RUN     tar -xf /firmware.tar



FROM    scratch

COPY    --from=firmware /out/ /
