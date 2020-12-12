FROM	ubuntu:18.04
LABEL	maintainer="paikwiki@gmail.com"

ENV		DEBIAN_FRONTEND=noninteractive \
		APACHE_CONF_DIR=/etc/apache2 \
		PHP_CONF_DIR=/etc/php/7.2/apache2 \
		PHP_DATA_DIR=/var/lib/php

COPY	srcs/init.sh ./
COPY	srcs/indexhibit.tar ./
RUN		apt-get update && apt-get install -y \
		curl apache2 mariadb-server php  php-fpm  php-cli  php-mysql vim
RUN		rm ${APACHE_CONF_DIR}/sites-enabled/000-default.conf \
		${APACHE_CONF_DIR}/sites-available/000-default.conf \
		&& a2enmod rewrite php7.2
RUN		apt-get autoremove -y \
		&& rm -rf /var/lib/apt/lists/*

COPY	./srcs/localhost.conf ${APACHE_CONF_DIR}/sites-enabled/localhost.conf

EXPOSE	80

CMD [ "/bin/bash", "init.sh" ]
