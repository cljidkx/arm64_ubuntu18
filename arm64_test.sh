#!/bin/bash

docker run -it --name ubuntu18-arm --platform linux/arm64 \
	--device /dev/snd --ipc=host --privileged \
	-v $HOME:/home/firefly/user_data \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=unix$DISPLAY \
	-e XMODIFIERS=@im=fcitx \
	-e QT_IM_MODULE=fcitx \
	-e GTK_IM_MODULE=fcitx \
	-e AUDIO_GID=`getent group audio | cut -d: -f3` \
	-e GID=`id -g` \
	-e UID=`id -u` \
	-h firefly \
	arm64v8:1.0
