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
