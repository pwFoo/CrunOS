ARG	BASE_IMAGE=$BASE_IMAGE
FROM 	$BASE_IMAGE as rngd

#RUN     apk --update --no-cache add wget bc build-base gawk xorriso libelf-dev openssl-dev bison flex linux-headers perl rsync git argp-standalone gettext
RUN     apk --update --no-cache add wget bc build-base gawk xorriso openssl-dev bison flex linux-headers perl rsync git argp-standalone gettext

ARG     RNGTOOLS_VERSION=5
ENV     RNGTOOLS_DL=https://downloads.sourceforge.net/sourceforge/gkernel/rng-tools-$RNGTOOLS_VERSION.tar.gz

ARG     BUILD=/build
ARG     OUT=/out

RUN     mkdir -p $BUILD $OUT

WORKDIR $BUILD

RUN     wget -O rngtools.tar.gz $RNGTOOLS_DL
RUN     tar -xf rngtools.tar.gz

WORKDIR $BUILD/rng-tools-$RNGTOOLS_VERSION


ARG     NUM_JOBS=2


RUN	./configure \
	--prefix=/usr \
	--sbindir=/usr/sbin \
	CFLAGS="-static" LIBS="-l argp"

RUN	make

RUN	make DESTDIR=$OUT install



FROM    scratch

COPY    --from=rngd /out/usr/sbin/rngd /usr/sbin/rngd

CMD	["/usr/sbin/rngd", "-f", "-r", "/dev/urandom", "-p", "/var/run/rngd.pid"]
