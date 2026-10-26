# gpu-burn

Docker image for [gpu-burn](https://github.com/wilicc/gpu-burn), the multi-GPU CUDA stress test.

The image builds gpu-burn from a pinned commit of the upstream repository. It contains code for every GPU that its CUDA version supports.

## Images

The images are on Docker Hub (`oguzpastirmaci/gpu-burn`) and GHCR (`ghcr.io/oguzpastirmaci/gpu-burn`).

| Tag | CUDA | Minimum NVIDIA driver | Platforms |
|---|---|---|---|
| `latest`, `cuda11.8.0` | 11.8.0 | 450 | `linux/amd64`, `linux/arm64` |
| `cuda12.9.2` | 12.9.2 | 525 | `linux/amd64`, `linux/arm64` |
| `cuda13.4.3` | 13.4.3 | 580 | `linux/amd64`, `linux/arm64` |
| `cuda11.1.1` | 11.1.1 | 450 | `linux/amd64` |

All images use the UBI 8 base image, the same as the upstream Dockerfile.

CUDA 11.8 has no native code for Blackwell GPUs (B200, GB200, GB300). Use `cuda12.9.2` or `cuda13.4.3` on Blackwell.

`cuda11.1.1` is the previous `latest` image. It is not updated.

## Usage

You need the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-container-toolkit) on the host.

Run the test on all GPUs for 60 seconds:

```bash
docker run --gpus all --rm oguzpastirmaci/gpu-burn
```

Run the test for a different time in seconds:

```bash
docker run --gpus all --rm oguzpastirmaci/gpu-burn 300
```

Add gpu-burn options before the time. This example uses Tensor Cores and 90% of GPU memory:

```bash
docker run --gpus all --rm oguzpastirmaci/gpu-burn -tc -m 90% 300
```

Show all options:

```bash
docker run --gpus all --rm oguzpastirmaci/gpu-burn -h
```

## Build

The Dockerfile gets the gpu-burn source from GitHub. You do not need a local copy of the source.

Build the default image (CUDA 11.8.0):

```bash
docker build -t gpu-burn .
```

Build with a different CUDA version:

```bash
docker build --build-arg CUDA_VERSION=13.4.3 -t gpu-burn:cuda13.4.3 .
```

Build a different gpu-burn commit:

```bash
docker build --build-arg GPU_BURN_COMMIT=<commit SHA> -t gpu-burn .
```

Build and push both platforms:

```bash
docker buildx build --platform linux/amd64,linux/arm64 -t <registry>/gpu-burn:cuda11.8.0 --push .
```

The `build` workflow builds all three CUDA versions for both platforms on each pull request. It pushes the images to GHCR on each push to `master`.
