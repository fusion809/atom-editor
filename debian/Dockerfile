# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .deb file

# Base docker image
FROM ubuntu:16.04

ADD atom /atom

ADD atom.desktop.in /atom/resources/linux/atom.desktop.in

# Install dependencies
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y

RUN apt-get install -y curl

RUN apt-get install -y build-essential \
                       git \
                       libgnome-keyring-dev \
                       fakeroot \
                       nodejs \
                       wget \
                       npm

RUN npm install -g npm@1.4.28 --loglevel error

RUN cd /atom

RUN sed -i -e "/exception-reporting/d" \
       -e "/metrics/d" \
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
       package.json

RUN mkdir node_modules

# Download about-arch and move to its final location
RUN wget -c https://github.com/fusion809/about/archive/v1.5.16.tar.gz
RUN tar -xzf v1.5.16.tar.gz -C node_modules --transform="s/about-1.5.16/about-arch/"

# patch about-arch
RUN cd node_modules/about-arch
RUN curl -L https://git.io/vrFNY > about-debian.patch
RUN patch -Np1 < about-debian.patch
RUN cd -

# Build RPM
RUN cd /atom
RUN until ./atom/script/build; do :; done
RUN script/grunt mkdeb

COPY "./atom/out/atom-1.7.4-amd64.deb" .
