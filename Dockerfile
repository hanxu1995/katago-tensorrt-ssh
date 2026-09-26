ARG CUDA_VERSION="13.4.1"
ARG OS_VERSION="26.04"
ARG KATAGO_VERSION="v1.18.2"
ARG CMAKE_VERSION="4.4.3"
ARG SSH_PASSWORD="123"

# -----------------------------------------------------------------
FROM registry-1.docker.io/nvidia/cuda:${CUDA_VERSION}-cudnn-devel-ubuntu${OS_VERSION} AS builder
# -----------------------------------------------------------------

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt install -y \
  wget \
  git \
  zlib1g-dev \
  libzip-dev && \
  rm -rf /var/lib/apt/lists/*

ARG CMAKE_VERSION
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.sh -q -O /tmp/cmake-install.sh && \
  chmod u+x /tmp/cmake-install.sh && \
  /tmp/cmake-install.sh --skip-license --prefix=/usr/local && \
  rm /tmp/cmake-install.sh

ARG KATAGO_VERSION
RUN git clone -b ${KATAGO_VERSION} https://github.com/lightvector/KataGo.git

WORKDIR /KataGo/cpp
RUN cmake . -DUSE_BACKEND=CUDA
RUN make -j$(nproc)

# ---------------------------------------------------------------------------
FROM registry-1.docker.io/nvidia/cuda:${CUDA_VERSION}-cudnn-runtime-ubuntu${OS_VERSION} AS runner
# ---------------------------------------------------------------------------

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt install -y \
  openssh-server \
  libzip-dev && \
  rm -rf /var/lib/apt/lists/*

ARG SSH_PASSWORD
RUN echo "root:${SSH_PASSWORD}" | chpasswd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  echo "KexAlgorithms +diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config && \
  echo "Ciphers +aes128-ctr" >> /etc/ssh/sshd_config && \
  echo "MACs +hmac-sha1" >> /etc/ssh/sshd_config && \
  echo "HostKeyAlgorithms +ssh-rsa" >> /etc/ssh/sshd_config

COPY --from=builder /KataGo/cpp/katago /app/
RUN chmod +x /app/katago

RUN touch /app/start.sh && \
  echo "#!/bin/bash" >> /app/start.sh && \
  echo "service ssh start" >> /app/start.sh && \
  echo "/bin/bash" >> /app/start.sh && \
  chmod +x /app/start.sh

WORKDIR /app
CMD ["/app/start.sh"]
