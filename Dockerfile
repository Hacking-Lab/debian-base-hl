FROM debian:bookworm-slim
LABEL maintainer="Ivan Buetler <ivan.buetler@hacking-lab.com>"
ENV DEBIAN_FRONTEND=noninteractive

# Add s6-overlay
ENV S6_OVERLAY_VERSION=3.2.1.0

# Use BuildKit to help translate architecture names
ARG TARGETPLATFORM

RUN case "${TARGETPLATFORM}" in \
         "linux/amd64")  S6_ARCH=s6-overlay-x86_64.tar.xz ;; \
         "linux/arm64")  S6_ARCH=s6-overlay-aarch64.tar.xz ;; \
         *) exit 1 ;; \
    esac; \
    echo "${TARGETPLATFORM} -> ${S6_ARCH}" > /etc/hl-arch.txt && \ 
    apt update -y && \
    apt upgrade -y && \
    apt install -y \
    bash \
    tar \
    xz-utils \
    procps \
    net-tools openssl pwgen \
    cron \
    rsyslog \
    vim \
    curl && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -Jxpf - -C /  && \
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/${S6_ARCH} | tar -Jxpf - -C /  && \
    rm -rf /var/lib/apt/lists/* 

ADD root /

#RUN sed -i 's/^module(load="imklog")/# module(load="imklog")/' /etc/rsyslog.conf


WORKDIR /root

ENTRYPOINT ["/init"]


