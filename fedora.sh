#!/bin/bash

dnf install -y \
    make \
    gcc \
    gcc-c++ \
    glibc-devel \
    git-core \
    libgnome-keyring-devel \
    rpmdevtools \
    nodejs \
    npm \
    nano

npm install -g npm@1.4.28 --loglevel error
cd /atom
sed -i -e "/exception-reporting/d" \
       -e "/metrics/d" \
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
       package.json

mkdir node_modules

# Download about-arch and move to its final location
curl -L https://github.com/fusion809/about/v1.5.16.tar.gz | tar xz -C node_modules
mv node_modules/about-1.5.16 node_modules/about-arch

# patch about-arch
cd node_modules/about-arch
curl -L https://git.io/vrFrU > about-fedora.patch
patch -Np1 < about-fedora.patch
cd -

# Build RPM
script/build
script/grunt mkrpm
