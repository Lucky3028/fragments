FROM ubuntu:22.04 AS prepare
RUN apt-get update \
    && apt-get install -y g++ git make curl sudo file xz-utils mecab libmecab-dev mecab-ipadic-utf8
RUN cd /var \
    && git clone https://github.com/neologd/mecab-ipadic-neologd.git --depth=1 \
    && cd mecab-ipadic-neologd \
    && ./bin/install-mecab-ipadic-neologd -y -n -a
RUN sudo find / | grep libmecab
FROM clux/muslrust:1.64.0-nightly-2022-08-06 AS chef
WORKDIR /app
COPY --from=prepare /usr/lib/x86_64-linux-gnu/mecab /usr/lib/x86_64-linux-gnu/mecab
COPY --from=prepare /usr/bin/mecab /usr/bin/

ENTRYPOINT ["/bin/bash", "-c"]
