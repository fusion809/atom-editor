# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .rpm file

# Base docker image
FROM fedora:23

ADD ../atom /atom

ADD fedora.sh /atom/fedora.sh

ADD ../resources/atom.desktop.in /atom/resources/linux/atom.desktop.in

# Install dependencies
RUN /bin/bash -c "./atom/fedora.sh"

COPY "./atom/out/rpm/atom-1.7.4-0.1.fc23.x86_64.rpm" .
