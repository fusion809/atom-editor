#!/bin/bash

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y /
  build-essential git libgnome-keyring-dev fakeroot nodejs

cd /atom
sed -i -e "/exception-reporting/d" \
       -e "/metrics/d" \
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
       package.json

mkdir node_modules

# Download about-arch and move to its final location
wget -cqO- https://github.com/fusion809/about/archive/v1.5.16.tar.gz | tar xz -C node_modules --transform="s/about-1.5.16/about-arch/"

# patch about-arch
cd node_modules/about-arch
curl -L https://git.io/vrFrU > about-fedora.patch
patch -Np1 < about-fedora.patch
cd -

# Build RPM
cd /atom
script/build
script/grunt mkrpm
