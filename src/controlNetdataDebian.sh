#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

CNAME=netdata-debian.service

if [ "$1" == "start" ]; then
    echo "Starting - $CNAME"
    if [ "$(docker ps -qa -f name=$CNAME)" ]; then
      echo "Found container - $CNAME"
      if [ "$(docker ps -q -f name=$CNAME)" ]; then
        echo "Container is already running - $CNAME"
        sudo docker stop $CNAME;
        sudo docker wait $CNAME;
        sudo docker start $CNAME;
        sudo docker wait $CNAME;
      else
        sudo docker start $CNAME;
        sudo docker wait $CNAME;
      fi
    else
      sudo docker load -i /opt/netdataDockerImage.tar

      sudo docker run -d --name=netdata-debian.service \
      -p 19999:19999 \
      -v /etc/passwd:/host/etc/passwd:ro \
      -v /etc/group:/host/etc/group:ro \
      -v /proc:/host/proc:ro \
      -v /sys:/host/sys:ro \
      -v /var/run/docker.sock:/var/run/docker.sock:ro \
      --cap-add SYS_PTRACE \
      --security-opt apparmor=unconfined \
      netdata/netdata

      sudo docker wait $CNAME;  

      rm -rf /opt/netdataDockerImage.tar
    fi
elif [ "$1" == "stop" ]; then
    echo "Stopping netdata-debian systemd service"
    if [ "$(docker ps -qa -f name=$CNAME)" ]; then
      echo "Found container - $CNAME"
      if [ "$(docker ps -q -f name=$CNAME)" ]; then
        echo "Stopping - $CNAME"
        sudo docker stop $CNAME;
        sudo docker wait $CNAME;
        exit 0
      fi
    else
      echo "Couldnt find container"
    fi
else
  echo "Paramater is missing"
fi

sleep infinity