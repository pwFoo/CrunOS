#!/bin/sh

set -x

REPO="pwfoo"
TAG="latest"

BASE_IMAGE="--build-arg BASE_IMAGE=alpine:latest"

KERNEL_BASE="--build-arg KERNEL_BASE=alpine:3.8"            # needs nf_conntrack_ipv4.ko
KERNEL_BASE_PKG="--build-arg KERNEL_BASE_PKG=linux-vanilla"
KERNEL_PKGS="kernel_base kernel modules-all modules firmware"

PACKAGES=""
PUSH=""
PULL=""
BUILD_OPTS=""

TOOLS=$(dirname $0)
PKG_DIR="$TOOLS/../packages"
DOCKER=$(which docker)


########################


BUILD_PART=$1
shift


# source package path
if [ "$BUILD_PART" = "kernel" ]; then
	KERNEL_DISTRIBUTION=$1
	shift
	PKG_DIR=$PKG_DIR/$BUILD_PART/$KERNEL_DISTRIBUTION
else
	PKG_DIR=$PKG_DIR/$BUILD_PART
	PACKAGES=$(ls -1 $PKG_DIR)
fi


while [ "$1" != "" ]; do
        case $1 in
                -r|-repo)
                        shift
                        REPO=$1
                ;;
                -t|-tag)
                        shift
                        TAG=$1
                ;;
		-base)
			shift
			BASE_IMAGE="--build-arg BASE_IMAGE=$1"
		;;
		-kbase)
                        shift
                        KERNEL_BASE="--build-arg KERNEL_BASE=$1"
                ;;
		-kver|-kpkg)
			shift
			KERNEL_BASE_PKG="--build-arg KERNEL_BASE_PKG=$1"
		;;
                -push)
                        PUSH=1
                ;;
		-pull)
			PULL=1
		;;
                -pkg|-pkgs|-package|-packages)
                        shift
                        PACKAGES=$1
                ;;
		*)
			BUILD_OPTS="$BUILD_OPTS $1"
		;;
        esac
        shift
done


# prepare kernel builds
if [ "$BUILD_PART" = "kernel" ]; then
	IMAGE_PREFIX="os-$KERNEL_DISTRIBUTION-"
	BUILD_OPTS="$BUILD_OPTS $KERNEL_BASE $KERNEL_BASE_PKG --build-arg KERNEL_IMAGE=$REPO/${IMAGE_PREFIX}kernel_base:$TAG"
	PACKAGES=${PKGS:-$KERNEL_PKGS}
elif [ "$BUILD_PART" = "init" ]; then
	IMAGE_PREFIX="init-"
fi


# build packages
for PKG in $PACKAGES; do
	IMAGE=$REPO/$IMAGE_PREFIX$PKG:$TAG
	$DOCKER build -t $IMAGE $BUILD_OPTS $BASE_IMAGE $PKG_DIR/$PKG/

	if [ $? -gt 0 ]; then
		exit 1
	fi

	if [ ! -z "$PUSH" ]; then
		$DOCKER push $IMAGE
	fi
done || exit 1
