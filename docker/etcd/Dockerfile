FROM debian:10

LABEL maintainer="Dennis Y. Parygin <dyp2000@mail.ru>"

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get install -y ca-certificates apt-utils locales locales-all \
    && apt-get install -y --no-install-recommends mc net-tools procps curl \
    && locale-gen ru_RU.UTF-8

RUN cd /opt \
    && curl -L https://github.com/etcd-io/etcd/releases/download/v3.3.25/etcd-v3.3.25-linux-amd64.tar.gz -o ./etcd-v3.3.25-linux-amd64.tar.gz \
    && tar -xvf ./etcd-v3.3.25-linux-amd64.tar.gz && rm -rf /opt/etcd-v3.3.25-linux-amd64.tar.gz \
    && mv ./etcd-v3.3.25-linux-amd64 ./etcd \
    && ln -s /opt/etcd/etcd /usr/local/bin/etcd && ln -s /opt/etcd/etcdctl /usr/local/bin/etcdctl

RUN mkdir -p /var/etcd-data && chmod -R 700 /var/etcd-data

ENV LANG="ru_RU.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="ru_RU.UTF-8" \
    ETCDCTL_API="3" \
    ETCD_ADVERTISE_CLIENT_URLS="http://127.0.0.1:2379" \
    ETCD_DATA_DIR="/var/etcd-data/" \
    ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379"

EXPOSE 2379 2380 4001

WORKDIR /opt/etcd
CMD [ "etcd" ]
