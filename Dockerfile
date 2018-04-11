FROM phusion/baseimage
MAINTAINER charlie137

ARG USER_ID
ARG GROUP_ID

ENV HOME /axe

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} axe
RUN useradd -u ${USER_ID} -g axe -s /bin/bash -m -d /axe axe

RUN chown axe:axe -R /axe

ENV AXE_DOWNLOAD_URL  github.com/AXErunners/axe/releases/download/v1.1.2/axecore-1.1.3-linux64.tar.gz
RUN cd /tmp \
 && curl -sSL "$AXE_DOWNLOAD_URL" -o axe.tgz "$AXE_DOWNLOAD_URL.asc" -o axe.tgz.asc \
 && tar xzf axe.tgz --no-anchored axed axe-cli --transform='s/.*\///' \
 && mv axed axe-cli /usr/bin/ \
 && rm -rf axe* \
 && echo "#""!/bin/bash\n/usr/bin/axed -datadir=/axe \"\$@\"" > /usr/local/bin/axed \
 && echo "#""!/bin/bash\n/usr/bin/axe-cli -datadir=/axe \"\$@\"" > /usr/local/bin/axe-cli \
 && chmod a+x /usr/local/bin/axed /usr/local/bin/axe-cli /usr/bin/axed /usr/bin/axe-cli

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

# For some reason, docker.io (0.9.1~dfsg1-2) pkg in Ubuntu 14.04 has permission
# denied issues when executing /bin/bash from trusted builds.  Building locally
# works fine (strange).  Using the upstream docker (0.11.1) pkg from
# http://get.docker.io/ubuntu works fine also and seems simpler.
USER axe

VOLUME ["/axe"]

EXPOSE 9337 9937 19999

WORKDIR /axe

CMD ["axe_oneshot"]
