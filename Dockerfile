FROM nvidia/cuda:11.7.1-base-ubuntu22.04

ENV DEBIAN_FRONTEND noninteractive
ENV PATH /opt/conda/bin:$PATH

RUN set -xe \
    \
    && sed -i.bak -r 's!http://(security|archive).ubuntu.com/ubuntu!http://ftp.riken.jp/Linux/ubuntu!' /etc/apt/sources.list \
    && apt update && apt install -y \
    git \
    git-lfs \
    libopencv-dev \
    libsm-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* 

ADD stable-diffusion-main.tar.gz /

ADD Miniconda3-latest-Linux-x86_64.sh /miniconda.sh
RUN set -xe \
    \
    && chmod 700 /miniconda.sh \
    && /bin/bash /miniconda.sh -b -p /opt/conda

ADD entry.sh /
ADD generate.py /
RUN set -xe \
    \
    && chmod 700 /generate.py \
    && chmod 700 /entry.sh 

ENTRYPOINT [ "/entry.sh" ]
