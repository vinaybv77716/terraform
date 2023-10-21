!# /bin/bash

set -x

sudo apt update

sudo apt install apache2 -y

cd ../../var/www/html

rm -r *

git clone https://gitlab.com/vinaybv77716/tiya.git -b master

cd tiya

mv * ..