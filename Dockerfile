FROM arm64v8/ubuntu:18.04 
MAINTAINER firefly "service@t-firefly.com" 
ENV DEBIAN_FRONTEND=noninteractive
#COPY ./qemu-aarch64-static /usr/bin
RUN cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
RUN sed -i 's@http://.*ubuntu.com@http://repo.huaweicloud.com@g' /etc/apt/sources.list && apt update
RUN apt install -y build-essential \
	bash-completion vim sudo locales time rsync bc python
RUN apt install -y repo git libssl-dev liblz4-tool \
	expect-dev patchelf chrpath gawk texinfo diffstat binfmt-support \
	live-build bison flex fakeroot cmake \
	unzip device-tree-compiler python-pip ncurses-dev python-pyelftools \
	subversion asciidoc w3m dblatex graphviz python-matplotlib cpio \
	libparse-yapp-perl default-jre patchutils swig u-boot-tools
RUN apt update && apt install -y -f
# language support
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
# switch to a no-root user
RUN useradd -c 'firefly user' -m -d /home/firefly -s /bin/bash firefly
RUN sed -i -e '/\%sudo/ c \%sudo ALL=(ALL) NOPASSWD: ALL' /etc/sudoers
RUN usermod -a -G sudo firefly
USER firefly
WORKDIR /home/firefly
