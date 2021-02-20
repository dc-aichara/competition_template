
FROM nvidia/cuda:11.1-base
CMD nvidia-smi

FROM continuumio/miniconda3
LABEL author="Anaconda with Jupyter"

WORKDIR /app

RUN apt-get update && \
apt-get install -y --no-install-recommends \
ocl-icd-opencl-dev \ 
build-essential \
curl \
wget \
bzip2 \
ca-certificates \
libglib2.0-0 \
libxext6 \
libsm6 \
libxrender1 \
subversion \
git \
cmake \
libboost-all-dev \ 
gcc \
g++

# Create the environment:
COPY environment.yml .

RUN mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

SHELL ["/bin/bash", "-c"]

# Conda Setup 
RUN conda env update -n competition --file environment.yml
RUN echo "source activate competition" > ~/.bashrc
ENV PATH /opt/conda/envs/competition/bin:$PATH

## Uninstall Conda LightGBM
RUN pip uninstall -y lightgbm 

## LightGBM GPU - build from source
RUN cd /app & git clone --recursive https://github.com/microsoft/LightGBM
RUN cd /app/LightGBM && mkdir build && cd build && cmake -DUSE_GPU=1 -DOpenCL_LIBRARY=/usr/lib/x86_64-linux-gnu/libOpenCL.so -DOpenCL_INCLUDE_DIR=/usr/include .. 
RUN cd /app/LightGBM/build && make -j4
RUN cd /app/LightGBM/python-package && python setup.py install --precompile && source deactivate

## Reduce space
RUN apt-get autoremove -y && apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    conda clean -a -y


RUN pip install japanize-matplotlib
RUN pip install swifter