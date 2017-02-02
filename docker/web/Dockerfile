# Pull base image
FROM nginx:alpine

MAINTAINER Visay Keo  <keo@visay.info>

ENV NEOS_DEV_HOST neos.dev
ENV FLOW_DEV_HOST flow.dev
ENV NEOS_BASE_HOST neos.base
ENV FLOW_BASE_HOST flow.base

# Install usermod command for alpine - Should be included by default from alpine
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow

# Create webserver user and group
RUN addgroup -g 1000 -S neos
RUN adduser -G neos -S -D -H -u 1000 neos

# Copy configuration files for nginx
COPY nginx.conf /etc/nginx/nginx.conf

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/neos-dev.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${NEOS_DEV_HOST}~g" /etc/nginx/conf.d/neos-dev.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/neos-dev/Web/~g" /etc/nginx/conf.d/neos-dev.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/flow-dev.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${FLOW_DEV_HOST}~g" /etc/nginx/conf.d/flow-dev.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/flow-dev/Web/~g" /etc/nginx/conf.d/flow-dev.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/neos-base.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${NEOS_BASE_HOST}~g" /etc/nginx/conf.d/neos-base.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/neos-base/Web/~g" /etc/nginx/conf.d/neos-base.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/flow-base.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${FLOW_BASE_HOST}~g" /etc/nginx/conf.d/flow-base.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/flow-base/Web/~g" /etc/nginx/conf.d/flow-base.conf

# Set entrypoint to fix volume mount permission
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /etc/nginx/conf.d

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
