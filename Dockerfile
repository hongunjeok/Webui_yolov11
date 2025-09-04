# Use Ultralytics official image instead of Nvidia CUDA
FROM ultralytics/ultralytics:latest

# Set timezone and locale
ENV TZ=Asia/Seoul
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG DEBIAN_FRONTEND=noninteractive

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    MKL_THREADING_LAYER=GNU \
    OMP_NUM_THREADS=1 

# Install additional dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc git zip unzip wget curl htop libgl1 libglib2.0-0 libpython3-dev gnupg g++ libusb-1.0-0 libsm6 \
    && rm -rf /var/lib/apt/lists/*

# Security updates
RUN apt upgrade --no-install-recommends -y openssl tar

# Create working directory
WORKDIR /ultralytics

# Copy project files
COPY . .

# Download required model file
ADD https://github.com/ultralytics/assets/releases/download/v8.3.0/yolo11n.pt .

# Install additional Python dependencies
RUN pip install uv
RUN uv pip install --system -e ".[export]" tensorrt-cu12 "albumentations>=1.4.6" comet pycocotools

# Export model to different formats
RUN yolo export model=tmp/yolo11n.pt format=edgetpu imgsz=32 || yolo export model=tmp/yolo11n.pt format=edgetpu imgsz=32
RUN yolo export model=tmp/yolo11n.pt format=ncnn imgsz=32

# Install additional machine learning libraries
RUN uv pip install --system "paddlepaddle>=2.6.0" x2paddle
RUN uv pip install --system numpy==1.23.5

# Cleanup unnecessary files
RUN rm -rf tmp /root/.config/Ultralytics/persistent_cache.json

# Expose necessary ports
EXPOSE 8000
EXPOSE 8888
EXPOSE 22

# Default command
CMD ["/bin/bash"]
