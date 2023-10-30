FROM ubuntu:latest

# 安装所需的软件包
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    wget \
    && rm -rf /var/lib/apt/lists/*

# 安装Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
    bash Anaconda3-2021.05-Linux-x86_64.sh -b && \
    rm Anaconda3-2021.05-Linux-x86_64.sh

# 设置环境变量
ENV PATH /root/anaconda3/bin:$PATH

# 安装PyTorch
RUN conda install -y pytorch=1.11.0 torchvision=0.12.0 torchaudio=0.11.0 cudatoolkit=11.3 -c pytorch \
    pip install timm==0.5.4 fvcore==0.1.5.post20211023 numpy==1.20.3 opencv_python==4.4.0.46 termcolor==1.1.0 timm==0.5.4 yacs==0.1.8 tensorboard

# 设置工作目录
WORKDIR /app

# 复制当前目录下的所有文件到工作目录    
COPY . /app

EXPOSE 8888 8080

ENTRYPOINT ["/bin/sh"]
CMD ["./start.sh"]
