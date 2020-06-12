FROM norberttech/md-link-linter:base
MAINTAINER Norbert Orzechowicz <contact@norbert.tech>

ENV MD_LINK_LINTER_VERSION dev-master

RUN composer clear-cache && composer global require norberttech/md-link-linter dev-master --prefer-dist && composer global show | grep md-link-linter