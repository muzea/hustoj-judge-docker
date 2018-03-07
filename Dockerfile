FROM debian:jessie-slim
LABEL maintainer="muzea <mr.muzea@gmail.com>"

COPY judge_client.patch /

RUN set -ex \
    && apt update \
    && apt install -y \
               git \
               gcc \
               g++ \
               libmysqlclient-dev \
               libmysql++-dev \
               pypy \
    && mkdir /home/judge \
    && cd / && git clone https://github.com/zhblue/hustoj.git \
    && cd /hustoj/trunk/core/judged \
    && make \
    && chmod +x judged \
    && cp judged /usr/bin \
    && cd ../judge_client \
    && patch judge_client.cc /judge_client.patch \
    && make \
    && chmod +x judge_client \
    && cp judge_client /usr/bin \
    && mkdir /home/judge/etc \
    && mkdir /home/judge/data \
    && mkdir /home/judge/log \
    && mkdir /home/judge/run0 \
#    && adduser -D -u 1536 judge \
    && useradd -m -u 1536 judge \
    && chown -R judge /home/judge \
    && chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run? \
    && rm -rf /hustoj

WORKDIR /home/judge

CMD judged && tail -f /dev/null

