ARG PHP_VERSION=8.1.16
ARG BASE_IMAGE_TAG_SUFFIX=cli-alpine
ARG BASE_IMAGE_TAG=${PHP_VERSION}-${BASE_IMAGE_TAG_SUFFIX}
ARG BASE_IMAGE=php:${BASE_IMAGE_TAG}

FROM ${BASE_IMAGE}

MAINTAINER Norbert Orzechowicz <contact@norbert.tech>

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH
ENV PHP_CONF_DIR=/usr/local/etc/php/conf.d

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ARG MD_LINK_LINT_VERSION=1.x@dev

RUN apk add --no-cache tini \
  && composer --version \
  && echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini \
  && composer clear-cache \
  && composer global require norberttech/md-link-linter:${MD_LINK_LINT_VERSION} --prefer-dist

ENTRYPOINT ["/sbin/tini", "--", "/composer/vendor/bin/mdlinklint"]

VOLUME ["/app"]
WORKDIR /app
