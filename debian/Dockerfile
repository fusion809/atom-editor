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
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
       package.json \
    mkdir node_modules \
    wget -c https://github.com/fusion809/about/archive/v1.5.16.tar.gz \
    tar -xzf v1.5.16.tar.gz -C node_modules --transform="s/about-1.5.16/about-arch/" \
    cd node_modules/about-arch && curl -L https://git.io/vrFNY > about-debian.patch && patch -Np1 < about-debian.patch && cd - \
    cd /atom && until script/build; do :; done && script/grunt mkdeb

COPY "./atom/out/atom-1.7.4-amd64.deb" .
