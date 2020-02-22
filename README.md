# DenglerOS

A fun linux system based on containers and linuxkit tool :)

# Build kernel / modules / firmware images

default: Alpine 3.8 vanilla, because of missing `nf_conntrack` module with kernels >=4.19

```
./tools/build.sh kernel alpine -r <DOCKER_REPO> 
```

# Build init images

See `./packages/init/*`
```
./tools/build.sh  init
```


# Build services images

`.packages/services/*`
```
./tools/build.sh services
```

# onboot / onshutdown images

Same as above with replaced keyword...

# Linuxkit build system

```
./tools/linuxkit.sh -yml rustysd.yml
```

# Run with qemu

```
./tools/qemu.sh 
```

# Change to host namespace via ssh

Login to the sshd container and execute the following command to enter host namespace and rootfs
```
nsenter -t 1  -F chroot /host /bin/sh
```

Now you're able to use hosts crun:
```
crun list
```

Because of privileged and net/pid namesace of host also a chroot would work
```
chroot /host /bin/sh
crun list
```
