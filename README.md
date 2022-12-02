# gpu-burn
Docker image for the Multi-GPU CUDA stress test from http://wili.cc/blog/gpu-burn.html

## Usage

Below commands assume that you have the appropriate version of the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) installed.

Default test duration is 60 seconds. If needed, change <test duration> to a different value.

#### Docker 19.03 and later
```zsh
docker run --gpus all --rm oguzpastirmaci/gpu-burn <test duration in seconds>
```

#### Previous versions of Docker

```zsh
nvidia-docker run --rm oguzpastirmaci/gpu-burn <test duration in seconds>
```
