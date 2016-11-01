FROM vcarreira/php7:latest

MAINTAINER "Vitor Carreira" <vitor.carreira@gmail.com>

WORKDIR /tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
    nginx \
    php7.0-fpm \
    supervisor && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx /var/run/php /var/log/supervisor

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-supervisor.conf /etc/supervisor/conf.d/nginx.conf
COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf

VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

EXPOSE 80 9000

CMD ["/usr/bin/supervisord"]
