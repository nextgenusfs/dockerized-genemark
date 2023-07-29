FROM bitnami/minideb:bullseye

RUN install_packages python3 wget libyaml-perl libhash-merge-perl libparallel-forkmanager-perl libmce-perl libthread-queue-any-perl libmath-utils-perl

COPY ./gmes_linux_64.tar.gz /opt

COPY ./gm_key_64.gz /opt

WORKDIR /opt

RUN gunzip -c /opt/gm_key_64.gz > ~/.gm_key && rm /opt/gm_key_64.gz

RUN tar -xzf /opt/gmes_linux_64_4.tar.gz && rm /opt/gmes_linux_64_4.tar.gz

ENV PATH="${PATH}:/opt/gmes_linux_64_4"

SHELL ["/bin/bash", "-c"]

CMD gmes_petap.pl
