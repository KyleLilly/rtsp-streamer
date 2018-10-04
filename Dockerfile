FROM node:8-alpine

RUN apk upgrade -U \
	&& apk add --no-cache ca-certificates ffmpeg libva-intel-driver libc6-compat \
 	&& rm -rf /var/cache/*

COPY stream.sh /

ENTRYPOINT ["/stream.sh"]