#!/bin/bash

set -x

sudo apt update


sudo file -s /dev/xvdh
sudo mkfs -t xfs /dev/xvdh
sudo mkdir /myebsvol
sudo mount /dev/xvdh /myebsvol

sudo apt install docker.io -y
sudo chown $USER /var/run/docker.sock
 docker login -u bvvinay -p Bvv@22188
docker run -p 80:80 bvvinay/prime
#aws ec2 modify-volume --volume-id vol-0b165024fe370b2ed --size 50

