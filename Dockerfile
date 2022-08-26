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

ADD Miniconda3-latest-Linux-x86_64.sh miniconda.sh

RUN set -xe \
    \
    && ./miniconda.sh -b -p /opt/conda \
    && conda init bash

ADD stable-diffusion-main.tar.gz /
ADD generate.py /
ADD entry.sh /

ENTRYPOINT [ "/entry.sh" ]
