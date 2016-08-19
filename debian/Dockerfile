# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .deb file

# Base docker image
FROM ubuntu:16.04

ADD atom /atom
ADD atom.desktop.in /atom/resources/linux/atom.desktop.in

# Install dependencies
RUN apt-get update && apt-get install -y build-essential git libgnome-keyring-dev fakeroot nodejs wget npm && npm install -g npm@1.4.28 \
    cd /atom \
    sed -i -e "/exception-reporting/d" \
       -e "/metrics/d" \
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.92.2\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-unix-shell\": \"0.37.7\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.6.2\"/g" \
       package.json \
    mkdir node_modules \
    wget -c https://github.com/fusion809/about/archive/v1.6.2.tar.gz \
    tar -xzf v1.6.2.tar.gz -C node_modules --transform="s/about-1.6.2/about-arch/" \
    cd node_modules/about-arch && curl -L https://git.io/vrFNY > about-debian.patch && patch -Np1 < about-debian.patch && cd - \
    cd /atom && until script/build; do :; done && script/grunt mkdeb

COPY "./atom/out/atom-1.9.9-amd64.deb" .
