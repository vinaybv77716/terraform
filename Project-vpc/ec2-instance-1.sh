#! /bin/bash

set -x

sudo apt update

#sudo apt install apache2 -y

#cd ../../var/www/html

#rm -r *

#git clone https://gitlab.com/vinaybv77716/highway.git -b master

#cd highway

#mv * ..
sudo file -s /dev/xvdh
sudo mkfs -t xfs /dev/xvdh
sudo mkdir /myebsvol
sudo mount /dev/xvdh /myebsvol

sudo apt install docker.io -y
sudo chown $USER /var/run/docker.sock
 docker login -u bvvinay -p Bvv@22188
docker run -p 80:80 bvvinay/prime
#aws ec2 modify-volume --volume-id vol-0b165024fe370b2ed --size 50
