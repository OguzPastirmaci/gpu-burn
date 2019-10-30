# gpu-burn
Docker image for the Multi-GPU CUDA stress test from http://wili.cc/blog/gpu-burn.html

## USAGE

Below commands assume that you have the appropriate version of the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) installed.

Default test duration is 10 seconds. If needed, change <test duration> to a different value.

### Docker 19.03 and later
`docker run --gpus all --rm oguzpastirmaci/gpu-burn <test duration>`

### Previous versions of Docker

`nvidia-docker run --rm oguzpastirmaci/gpu-burn <test duration>`