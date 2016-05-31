# VERSION:        0.1
# DESCRIPTION:    Image to build Atom and create a .rpm file

# Base docker image
FROM fedora:23

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
    nano

RUN curl -L https://github.com/atom/atom/archive/v1.7.4.tar.gz | tar -xz
RUN npm install -g npm@1.4.28 --loglevel error
RUN cd atom-1.7.4
RUN sed -i -e "/exception-reporting/d" \
         -e "/metrics/d" \
         -e "s/\"language-gfm\": \".*\",/\"language-gfm2\": \"0.90.3\",\n    \"language-liquid\": \"0.5.1\",/g" \
         -e "s/\"language-shellscript\": \".*\",/\"language-shellscript\": \"0.22.3\",/g" \
         -e "s/\"about\": \".*\"/\"about-arch\": \"1.5.16\"/g" \
         package.json

RUN mkdir node_modules
RUN curl -L https://github.com/fusion809/about/v1.5.16.tar.gz | tar xz -C node_modules
RUN mv node_modules/about-1.5.16 node_modules/about-arch
RUN cd node_modules/about-arch
RUN curl -L https://git.io/vrFrU > about-fedora.patch
RUN patch -Np1 < about-fedora.patch
