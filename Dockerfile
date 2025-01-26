ARG CUDA_VERSION="12.5.1"
ARG OS_VERSION="22.04"
ARG TRT_VERSION="10.2.0.19-1+cuda12.5"
ARG KATAGO_VERSION="v1.15.3"
ARG SSH_PASSWORD="123"

# -----------------------------------------------------------------
FROM registry-1.docker.io/nvidia/cuda:${CUDA_VERSION}-cudnn-devel-ubuntu${OS_VERSION} as builder
# -----------------------------------------------------------------

ENV DEBIAN_FRONTEND noninteractive

ARG TRT_VERSION
RUN version=${TRT_VERSION} && \
  apt update && \
  apt install -y \
  libnvinfer-dev=${version} \
  libnvonnxparsers-dev=${version} \
  libnvinfer-plugin-dev=${version} \
  libnvinfer-headers-dev=${version} \
  libnvinfer10=${version} \
  libnvinfer-headers-plugin-dev=${version} \
  libnvinfer-plugin10=${version} \
  libnvonnxparsers10=${version} \
  wget \
  git \
  zlib1g-dev \
  libzip-dev \
  unzip && \
  rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/Kitware/CMake/releases/download/v3.29.2/cmake-3.29.2-linux-x86_64.sh -q -O /tmp/cmake-install.sh && \
  chmod u+x /tmp/cmake-install.sh && \
  /tmp/cmake-install.sh --skip-license --prefix=/usr/local && \
  rm /tmp/cmake-install.sh

ARG KATAGO_VERSION
RUN git clone -b ${KATAGO_VERSION} https://github.com/lightvector/KataGo.git && mkdir -p /KataGo/cpp/build

WORKDIR /KataGo/cpp/build
RUN cmake .. -DUSE_BACKEND=TENSORRT
RUN make -j$(nproc)

# ---------------------------------------------------------------------------
FROM registry-1.docker.io/nvidia/cuda:${CUDA_VERSION}-cudnn-runtime-ubuntu${OS_VERSION} as tensorrt-runner
# ---------------------------------------------------------------------------

ENV DEBIAN_FRONTEND noninteractive

ARG TRT_VERSION
RUN version=${TRT_VERSION} && \
  apt update && \
  apt install -y \
  openssh-server \
  libnvinfer10=${version} \
  libnvonnxparsers10=${version} \
  libnvinfer-plugin10=${version} \
  libzip-dev && \
  rm -rf /var/lib/apt/lists/*

ARG SSH_PASSWORD
RUN echo "root:${SSH_PASSWORD}" | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  echo "KexAlgorithms +diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config && \
  echo "Ciphers +aes128-ctr" >> /etc/ssh/sshd_config && \
  echo "MACs +hmac-sha1" >> /etc/ssh/sshd_config && \
  echo "HostKeyAlgorithms +ssh-rsa" >> /etc/ssh/sshd_config

COPY --from=builder /KataGo/cpp/build/katago /app/
RUN chmod +x /app/katago

RUN touch /app/start.sh && \
  echo "#!/bin/bash" >> /app/start.sh && \
  echo "service ssh start" >> /app/start.sh && \
  echo "/bin/bash" >> /app/start.sh && \
  chmod +x /app/start.sh

WORKDIR /app
CMD ["/app/start.sh"]
