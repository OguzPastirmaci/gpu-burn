# syntax=docker/dockerfile:1
ARG CUDA_VERSION=11.8.0
ARG IMAGE_DISTRO=ubi8

FROM nvidia/cuda:${CUDA_VERSION}-devel-${IMAGE_DISTRO} AS builder

# wilicc/gpu-burn commit to build.
ARG GPU_BURN_COMMIT=0d19c94dcb2e9b6858b7586a4c327674cd67113b

ADD https://github.com/wilicc/gpu-burn.git#${GPU_BURN_COMMIT} /build

WORKDIR /build

# SASS for every GPU this CUDA version supports, plus PTX for newer GPUs.
RUN make COMPUTE= NVCCFLAGS=-arch=all

FROM nvidia/cuda:${CUDA_VERSION}-runtime-${IMAGE_DISTRO}

COPY --from=builder /build/gpu_burn /build/compare.fatbin /app/

WORKDIR /app

ENTRYPOINT ["./gpu_burn"]

CMD ["60"]
