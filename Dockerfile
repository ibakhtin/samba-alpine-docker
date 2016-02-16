FROM alpine:latest
MAINTAINER Peter Winter <peter@pwntr.com>
LABEL Description="Simple and lightweight Samba docker container, based on Alpine Linux." Version="0.1"

# update the base system
RUN apk update && apk upgrade

# install samba
RUN apk add samba samba-common-tools

# create a dir for the config and the share
RUN mkdir /config /shared

# copy init files from project folder to get a default config 
COPY smb.conf /config/smb.conf

# volume mappings
VOLUME /config /shared

# exposes samba's default port 445 and the NetBIOS ports 137-139
EXPOSE 445 137 138 139

# set some defaults and start samba in interactive server mode, forked (-F) and logging to stdout, using our config
ENTRYPOINT ["smbd", "-i", "-F", "-s", "/config/smb.conf"]
