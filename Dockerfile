FROM debian:jessie-slim
LABEL maintainer="muzea <mr.muzea@gmail.com>"

RUN set -ex \
    && apt update \
    && apt install \
               git \
               gcc \
               g++ \
               make \
               libmysqlclient-dev \
               libmysql++-dev -y \
    && mkdir /home/judge \
    && cd / && git clone https://github.com/zhblue/hustoj.git \
    && mkdir /home/judge/etc \
    && mkdir /home/judge/data \
    && mkdir /home/judge/log \
    && mkdir /home/judge/run0 \
    && useradd -m -u 1536 judge \
    && chown -R judge /home/judge \
    && chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run?

