FROM debian:10

LABEL maintainer="Dennis Y. Parygin <dyp2000@mail.ru>"
LABEL container="etcd benchmark"

RUN apt-get -y update && apt-get -y upgrade \
    && apt-get install -y apt-utils \
    && apt-get install -y ca-certificates locales locales-all \
    && apt-get install -y --no-install-recommends mc net-tools procps curl \
    && locale-gen ru_RU.UTF-8

RUN mkdir -p /opt/etcd-benchmark
ADD ./bin/benchmark-linux-amd64 /opt/etcd-benchmark/benchmark
RUN ln -s /opt/etcd-benchmark/benchmark /usr/local/bin/benchmark

ENV LANG="ru_RU.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="ru_RU.UTF-8" \
    ETCDCTL_API="3"

WORKDIR /opt/etcd-benchmark

CMD [ "benchmark", "--endpoints=10.5.0.10:2379,10.5.0.11:2379,10.5.0.12:2379,10.5.0.13:2379,10.5.0.14:2379", \
      "--conns=100", "--clients=1000", "put", "--key-size=8", "--sequential-keys", "--total=100000", "--val-size=256" ]
