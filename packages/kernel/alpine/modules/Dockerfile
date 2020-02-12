ARG     KERNEL_IMAGE=$KERNEL_IMAGE
ARG     BASE_IMAGE=$BASE_IMAGE

FROM    $KERNEL_IMAGE AS kernel_image


FROM    $BASE_IMAGE AS modules

COPY	files/ /
COPY    --from=kernel_image /modules.tar /

RUN     mkdir /out

RUN     tar -xf /modules.tar

RUN     /collect-modules.sh                             # ToDo: check firmware dependencies?



FROM    scratch

COPY    --from=modules /out/ /
