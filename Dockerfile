ARG PHP_VERSION=7.4.13
ARG BASE_IMAGE_TAG_SUFFIX=cli-alpine
ARG BASE_IMAGE_TAG=${PHP_VERSION}-${BASE_IMAGE_TAG_SUFFIX}
ARG BASE_IMAGE=php:${BASE_IMAGE_TAG}

FROM ${BASE_IMAGE} AS base

ARG COMPOSER_VERSION=2.0.8
ARG COMPOSER_HOME=/composer

ENV COMPOSER_HOME ${COMPOSER_HOME}
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_VERSION ${COMPOSER_VERSION}

ADD https://getcomposer.org/installer /tmp/composer-setup.php
ADD https://composer.github.io/installer.sig /tmp/composer-setup.sig

RUN apk add --no-cache perl-utils \
  && echo "$(cat /tmp/composer-setup.sig)  /tmp/composer-setup.php" | shasum -c -a 384 \
  && php /tmp/composer-setup.php --no-ansi --install-dir=/sbin --filename=composer --version=${COMPOSER_VERSION}

FROM ${BASE_IMAGE}
MAINTAINER Norbert Orzechowicz <contact@norbert.tech>

ARG COMPOSER_HOME=/composer
ARG MD_LINK_LINT_VERSION=1.x@dev

ENV COMPOSER_HOME ${COMPOSER_HOME}
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_VERSION ${COMPOSER_VERSION}

COPY --from=base ${COMPOSER_HOME}/ ${COMPOSER_HOME}
COPY --from=base /sbin/composer /sbin

RUN apk add --no-cache tini \
  && echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini \
  && composer clear-cache \
  && composer global require norberttech/md-link-linter:${MD_LINK_LINT_VERSION} --prefer-dist

ENTRYPOINT ["/sbin/tini", "--", "/composer/vendor/bin/mdlinklint"]

VOLUME ["/app"]
WORKDIR /app
