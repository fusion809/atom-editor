# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .rpm file

# Base docker image
FROM fedora:23

ADD atom /atom

ADD fedora.sh /atom/fedora.sh

ADD atom.desktop.in /atom/resources/linux/atom.desktop.in

RUN dnf update && dnf upgrade -y

# Install dependencies
RUN dnf install -y \
    make \
    gcc \
    gcc-c++ \
    glibc-devel \
    git-core \
    libgnome-keyring-devel \
    rpmdevtools \
    nodejs \
    npm \
    nano \
    wget

RUN npm install -g npm@1.4.28 --loglevel error

RUN cd /atom

RUN sed -i -e "/exception-reporting/d" \
       -e "/metrics/d" \
       -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
       -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
       -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
       /atom/package.json

RUN mkdir /atom/node_modules

RUN wget -cqO- https://github.com/fusion809/about/archive/v1.5.16.tar.gz | tar xz -C /atom/node_modules --transform="s/about-1.5.16/about-arch/"

RUN curl -L https://git.io/vrFrU > /atom/node_modules/about-arch/about-fedora.patch

RUN cd /atom/node_modules/about-arch && patch -Np1 < about-fedora.patch

RUN chmod +x /atom/script/{build,grunt,mkrpm}

RUN /atom/script/build

RUN /atom/script/grunt mkrpm

COPY "./atom/out/rpm/atom-1.7.4-0.1.fc23.x86_64.rpm" .
