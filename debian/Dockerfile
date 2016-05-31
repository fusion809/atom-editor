# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .deb file

# Base docker image
FROM debian:latest

ADD ../atom /atom

ADD debian.sh /atom/fedora.sh

ADD ../resources/atom.desktop.in /atom/resources/linux/atom.desktop.in

# Install dependencies
RUN /bin/bash -c "./atom/debian.sh"

COPY "./atom/out/atom-1.7.4-amd64.deb" .
