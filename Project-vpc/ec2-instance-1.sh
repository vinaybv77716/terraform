!# /bin/bash

set -x

sudo apt update

sudo apt install apache2 -y

cd ../../var/www/html

rm -r *

git clone https://gitlab.com/vinaybv77716/highway.git -b master

cd highway

mv * ..