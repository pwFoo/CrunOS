FROM 	registry.fedoraproject.org/fedora:latest AS base
RUN 	dnf -y install \
	git \
	dnf-utils \
	gcc \
	meson \
	ninja-build \
	libcap-static \
	make \
	python \
	automake \
	autoconf \
	libcap-devel \
	systemd-devel \
	yajl-devel \
	libseccomp-devel \
	cmake \
	go-md2man \
	glibc-static \
	python3-libmount \
	libtool \
	diffutils


FROM 	base AS systemd

RUN 	mkdir /out 

RUN	yum-builddep -y systemd 

RUN	git clone --depth 1 https://github.com/systemd/systemd.git

RUN	mkdir systemd/build; \
	cd systemd/build; \
	meson .. -Dselinux=false --buildtype minsize --strip; \
	ninja version.h; \
	ninja libsystemd.a; \
	cp libsystemd.a /out


FROM 	base AS yajl

RUN 	mkdir /out

RUN	git clone --depth=1 https://github.com/lloyd/yajl.git

RUN	cd yajl; \
	./configure LDFLAGS=-static; \
	cd build; \
	make -j $(nproc); \
	find . -name '*.a' -exec cp \{\} /out \;


FROM 	base AS seccomp

RUN 	mkdir /out 

RUN	git clone --depth=1 https://github.com/seccomp/libseccomp.git

RUN	cd libseccomp; \
	./autogen.sh; \
	./configure --enable-static; \
	make -j $(nproc); \
	find . -name '*.a' -exec cp \{\} /out \;


FROM 	base AS crun

COPY 	--from=systemd /out/* /usr/lib64/
COPY 	--from=yajl /out/* /usr/lib64/
COPY 	--from=seccomp /out/* /usr/lib64/

RUN	git clone https://github.com/containers/crun.git /crun

WORKDIR	/crun

ARG	COMMIT=$COMMIT
#RUN	[ -z "$COMMIT" ] || git checkout $COMMIT
RUN	[ -z "$COMMIT" ] || git fetch https://github.com/containers/crun.git $COMMIT

RUN	./autogen.sh

RUN	./configure CRUN_LDFLAGS='-all-static' LDFLAGS="-static-libgcc -static" LIBS="/usr/lib64/libsystemd.a /usr/lib64/librt.a /usr/lib64/libpthread.a /usr/lib64/libcap.a /usr/lib64/libseccomp.a /usr/lib64/libyajl_s.a /usr/lib64/libc.a"

RUN	make -j $(nproc)

RUN	strip crun


FROM	scratch

COPY	--from=crun /crun/crun /usr/bin/crun
