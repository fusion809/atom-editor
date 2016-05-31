# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .rpm file

# Base docker image
FROM fedora:23

ADD atom /atom

ADD fedora.sh /atom/fedora.sh

ADD atom.desktop.in /atom/resources/linux/atom.desktop.in

# Install dependencies
RUN /bin/bash -c "./atom/fedora.sh"

COPY "./atom/out/rpm/atom*.rpm" .
