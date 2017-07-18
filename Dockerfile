FROM alpine:3.3

LABEL maintainer="HSIEH, Li-Yi"

RUN apk update
RUN apk add php-fpm php-zlib php-mysqli php-xml php-openssl php-gd php-iconv php-gmp php-ftp php-curl php-json php-exif

RUN deluser xfs
RUN addgroup -g 33 www-data
RUN adduser -D -u 33 -G www-data -s /bin/sh -h /var/www www-data

RUN sed -i -e "s/;daemonize = yes/daemonize = no/" /etc/php/php-fpm.conf
RUN sed -i -e "s/listen = 127.0.0.1:9000/listen = [::]:9000/" /etc/php/php-fpm.conf
RUN sed -i -e "s/user = nobody/user = www-data/" /etc/php/php-fpm.conf
RUN sed -i -e "s/group = nobody/group = www-data/" /etc/php/php-fpm.conf                                                          
CMD ["php-fpm", "--force-stderr"]
