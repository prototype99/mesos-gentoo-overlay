# drcrallen-overlay
This overlay contains a WORK IN PROGRESS for some items I've been missing in the gentoo portage upstream.

## Installation - CoreOS
Follow the instructions on [Modifying CoreOS](https://coreos.com/os/docs/latest/sdk-modifying-coreos.html) to create your basic `chroot` evironment. Once you have your basic build system functioning to where you could build an image, you now need to use this overlay to install packages. 

## `sys-cluster/mesos`
Mesos is a fantastic cluster resource 2-stage scheduler. It operates on resource offers rather than from a centralized scheduling mechanism.

## NOTE
There are a lot of patches under https://github.com/apache/mesos/tree/master/3rdparty which this overlay does **NOT** take into account. At the time of this writing most of the patches for 3rd party libraries in Mesos are for better WIN32 support. But caveat-emptor because this is still very much a work in progress.
