FROM debian:bookworm-slim AS base
RUN apt update && \
	apt install -y clang

FROM base AS kuin-builder
WORKDIR /tmp/
RUN apt install -y wget unzip && \
	wget "https://kuina.ch/download/kuin_2021_08_17_src_ja.zip" && \
	unzip ./kuin_2021_08_17_src_ja.zip && \
	clang++ -o ./kuin_2021_08_17_src_ja/kuin ./kuin_2021_08_17_src_ja/kuin.cpp

FROM base
WORKDIR /app/
RUN apt install -y make && \
	mkdir -p /usr/local/lib/kuin
COPY --from=kuin-builder /tmp/kuin_2021_08_17_src_ja/kuin /usr/local/lib/kuin/
COPY --from=kuin-builder /tmp/kuin_2021_08_17_src_ja/sys/ /usr/local/lib/kuin/sys/
COPY . .
RUN ln -s /usr/local/lib/kuin/kuin /usr/local/bin/kuin && \
	update-alternatives --install /usr/bin/llc llc /usr/bin/llc-14 100
ENV KUIN_SYS_PATH=/usr/local/lib/kuin/sys/

# ビルドと実行
# この Dockerfile と同じディレクトリにいる状態で
# $ docker build -t wreck1-dev .
# $ docker run -it wreck1-dev /bin/bash
# お好みで --rm などをつけるとよいです