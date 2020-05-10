# Container-to-Systemd
This application creates a systemd service based container from a docker image and debianizes it by creatig a DEBIAN package for DEBIAN based Linux distribuitons like Debian GNU/Linux, Ubuntu, Armbian etc. 

It creates a debian package from docker image mentioned in the script then it creates a docker container and it converts this docker container to a systemd service and enables start, stop and restart of Docker container via systemd service. Also as a systemd service, docker container will be automatically started during boot phase. 

For current usage, I selected Netdata docker image to convert. Netdata is Real-time performance monitoring tool for Linux systems. 

Docker Hub: https://hub.docker.com/r/netdata/netdata

Github: https://github.com/netdata/netdata

<a href="http://fatihcr.com"><img src="https://user-images.githubusercontent.com/1153921/70638670-85dd5080-1bf6-11ea-893e-94400f445574.gif" title="FVCproductions" alt="FVCproductions"></a>


General Features of Application: 
- This application automatically pulls the requested docker image from docker hub, for this purpose you need to have a valid 
  docker hub membership.
- After pulling the docker image from docker hub, it creates a .tar file from this image by saving it to locate it in debian package. 
- After loading debian package to any Debian based LINUX distrubition, systemd service loads the docker image and creates a docker 
  container with predefined configuration in contol script. 
- Container Systemd service is able to start, stop, restart, enable and disable the container via systemctl command. 


[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger)  [![Coverage Status](http://img.shields.io/coveralls/badges/badgerbadgerbadger.svg?style=flat-square)](https://coveralls.io/r/badges/badgerbadgerbadger)  [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org) 

## Prerequisites
- For creating the debian package you need to have below packages installed on your Linux environment.
 ```
 sudo apt install build-essential devscripts debhelper
  ```
 ```
sudo apt-get install dh-systemd autotools-dev
 ```
 - For getting docker image from docker hub, you need a docker hub account. 
 
 ### Clone

- Clone this repo to your local machine using `https://github.com/fatihcirakoglu/webdirectory.git`
 
## Build
- Just clone the repo on your Linux environment and run below command in the folder.
 ```
bash build.sh
  ```
- Sample build output

```
vm@vm-VirtualBox:~/container-to-systemd$ bash build.sh 
Build starting...
Using default tag: latest
latest: Pulling from netdata/netdata
85673147e907: Pull complete 
0baab060f326: Pull complete 
3e39ce7d3677: Pull complete 
2d942020f5c2: Pull complete 
11e4cff69cae: Pull complete 
e1e95c360cd8: Pull complete 
df948ae6e4a3: Pull complete 
bbb7667aeca8: Pull complete 
835f42e14888: Pull complete 
Digest: sha256:80123d5b3d67e25f5178a8522f00d121d329dac354f62416d7d50fef6b20d7ce
Status: Downloaded newer image for netdata/netdata:latest
 dpkg-buildpackage -rfakeroot -us -uc -ui -b
dpkg-buildpackage: info: source package netdata-debian
dpkg-buildpackage: info: source version 1.0.0
dpkg-buildpackage: info: source distribution unstable
dpkg-buildpackage: info: source changed by Fatih Cirakoglu  <fatihcirak@gmail.com>
 dpkg-source --before-build src
dpkg-buildpackage: info: host architecture amd64
 fakeroot debian/rules clean
dh clean
   dh_clean
 debian/rules build
dh build
   dh_update_autotools_config
 fakeroot debian/rules binary
dh binary
   dh_testroot
   dh_prep
   dh_installdirs
   dh_install
   dh_installdocs
   dh_installchangelogs
   dh_perl
   dh_link
   debian/rules override_dh_strip_nondeterminism
make[1]: Entering directory '/home/vm/Desktop/GitHub/container-to-systemd/src'
true
make[1]: Leaving directory '/home/vm/Desktop/GitHub/container-to-systemd/src'
   dh_compress
   dh_fixperms
   dh_missing
   dh_strip
   dh_makeshlibs
   dh_shlibdeps
   dh_installdeb
   dh_gencontrol
dpkg-gencontrol: warning: Depends field of package netdata-debian: unknown substitution variable ${shlibs:Depends}
   dh_md5sums
   dh_builddeb
dpkg-deb: building package 'netdata-debian' in '../netdata-debian_1.0.0_amd64.deb'.
 dpkg-genbuildinfo --build=binary
 dpkg-genchanges --build=binary >../netdata-debian_1.0.0_amd64.changes
dpkg-genchanges: info: binary-only upload (no source code included)
 dpkg-source --after-build src
dpkg-buildpackage: info: binary-only upload (no source included)
Now running lintian netdata-debian_1.0.0_amd64.changes ...
command failed with error code 2 at /usr/share/lintian/collection/unpacked line 217.
warning: collect info unpacked about package netdata-debian failed
warning: skipping check of binary package netdata-debian
E: netdata-debian changes: bad-distribution-in-changes-file unstable
Finished running lintian.

```
- After build ends, a DEBIAN package will be created under output folder.

```
vm@vm-VirtualBox:~/container-to-systemd$ ls output/

netdata-debian_1.0.0_amd64.deb

```

## Installation

- All the `code` required to get started
```
dpkg -i  netdata-debian_1.0.0_amd64.deb

```

### Setup

1. After installing DEBIAN package in your LINUX platform, go to web browser and go to link: 

   http://localhost:19999/
   
   You will see the NETDATA frontend page that shows all funny resource usages in your system
   
2. You can stop, start and restart Netdata application with below commands: 
   ```
   systemctl status netdata-debian
   ```
   ```
   systemctl stop netdata-debian
   ```
   ```
   systemctl start netdata-debian
   ```
   ```
   systemctl restart netdata-debian
   ```  
   
3. For completely removing "netdata-debian" package, use below command
   ```
   dpkg -P netdata-debian
   ```  
   By removing "netdata-debian" systemd service, docker image and container will be deleted. Also other files will be removed 
   
## FAQ

- **How can I use this application for a different Dcoker image ?**
    - In this application, for sample usage I selected NETDATA docker image, you can change control script and build script to create a 
    different Docker systemd service for your specific Docker image. 

---

## Support

Reach out to me at one of the following places!

---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[GNU General Public License v3.0](https://opensource.org/licenses/gpl-license)**
- Copyright 2020 © 
