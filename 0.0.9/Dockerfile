FROM norberttech/md-link-linter:base
MAINTAINER Norbert Orzechowicz <contact@norbert.tech>

ENV MD_LINK_LINTER_VERSION 0.0.9

RUN composer global require norberttech/md-link-linter ^0.0.9 --prefer-dist && composer global show | grep md-link-linter