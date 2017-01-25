# Pull base image
FROM nginx:alpine

MAINTAINER Visay Keo  <keo@visay.info>

ENV NEOS_HOST neos.dev
ENV FLOW_HOST flow.dev

# Install usermod command for alpine - Should be included by default from alpine
RUN echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories
RUN apk --no-cache add shadow

# Create webserver user and group
RUN addgroup -g 1000 -S neos
RUN adduser -G neos -S -D -H -u 1000 neos

# Copy configuration files for nginx
COPY nginx.conf /etc/nginx/nginx.conf

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/neos.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${NEOS_HOST}~g" /etc/nginx/conf.d/neos.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/neos/Web/~g" /etc/nginx/conf.d/neos.conf

COPY nginx_vhost.conf /etc/nginx/conf.d/flow.conf
RUN sed -i -e "s~###DEFAULT_NGINX_HOST###~${FLOW_HOST}~g" /etc/nginx/conf.d/flow.conf
RUN sed -i -e "s~###DEFAULT_NGINX_ROOT###~/var/www/flow/Web/~g" /etc/nginx/conf.d/flow.conf

# Set entrypoint to fix volume mount permission
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /etc/nginx/conf.d

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
