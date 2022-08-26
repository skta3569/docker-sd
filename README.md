# docker-sd
Stable Diffusionを動かすDockerImage

# 起動用コマンド

```shell
docker run -it --rm -v miniconda:/opt/conda/envs -v 出力先ディレクトリ:/output -v cache:/root/.cache -v cache:/root/.huggingface --gpus all dockersd:latest '画像出力用文字列' huggingfaceのトークン
```
