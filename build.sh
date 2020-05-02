#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

#-----------------------------------------------------------------------------------------------
# Definitions
#-----------------------------------------------------------------------------------------------
_abspath=$(readlink -f $0)	  # absolute path of this file
_absdir=$(dirname $_abspath)	# absolute path of this file's directory

DEB_DIR="${_absdir}/output"
SRC_DIR="${_absdir}/src/"


printf "Build starting...\n"

#Cleanup previous build
sudo rm -rf ${DEB_DIR}/*


cd ${SRC_DIR}

#-----------------------------------------------------------------------------------------------
# Pull Docker image
#-----------------------------------------------------------------------------------------------
sudo docker pull netdata/netdata

#-----------------------------------------------------------------------------------------------
# Package Docker image for debianizing 
#-----------------------------------------------------------------------------------------------
sudo docker save -o netdataDockerImage.tar netdata/netdata

sudo chown $USER:$USER netdataDockerImage.tar

debuild -b -us -uc

#-----------------------------------------------------------------------------------------------
# Copy .deb file to output folder
#-----------------------------------------------------------------------------------------------
mkdir -p ${DEB_DIR}
mv ../*.deb ${DEB_DIR}
