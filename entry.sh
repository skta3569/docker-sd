#!/bin/bash

if [ $# -ne 2 ]; then
  echo "実行するには2個の引数が必要です。" 1>&2
  echo "画像精製用の文字列 huggingfaceのトークン" 1>&2
  exit 1
fi

source /opt/conda/etc/profile.d/conda.sh

if [ `conda env list | grep ldm | wc -l` -eq 0 ]; then
    echo "conda環境のセットアップを行います"

    cd /stable-diffusion-main

    conda env create -f environment.yaml
    conda activate ldm
    pip install --upgrade diffusers transformers scipy
else
    conda activate ldm
fi

echo "prompt=> $1"
echo "token=> $2"
echo "画像の生成を開始します"

python /generate.py "$1" "$2"
