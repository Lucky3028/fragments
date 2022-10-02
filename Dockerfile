FROM ubuntu:22.04 AS prepare
RUN apt-get update \
    && apt-get install -y g++ git make curl sudo file xz-utils mecab libmecab-dev mecab-ipadic-utf8
FROM clux/muslrust:1.64.0-nightly-2022-08-06 AS chef
WORKDIR /app
COPY --from=prepare /usr/lib/x86_64-linux-gnu/lmecab* /usr/lib/x86_64-linux-gnu/
# COPY --from=prepare /usr/lib/x86_64-linux-gnu/mecab /usr/lib/x86_64-linux-gnu/
COPY --from=prepare /usr/bin/mecab /usr/bin/

RUN sudo find / | grep libmecab

ENTRYPOINT ["/bin/bash", "-c"]
