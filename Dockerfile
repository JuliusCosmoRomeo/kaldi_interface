FROM debian:8
#FROM chrstn_hntschl/cuda:cudnn5-devel
#FROM nvidia/cuda:8.0-devel-ubuntu16.04

#kaldi gstreamer related stuff starts here

RUN apt-get update && apt-get install -y  \
    screen \
    autoconf \
    automake \
    bzip2 \
    g++ \
    git \
    gstreamer1.0-plugins-good \
    gstreamer1.0-tools \
    gstreamer1.0-pulseaudio \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-ugly  \
    libatlas3-base \
    libgstreamer1.0-dev \
    libtool-bin \
    make \
	maven \
	openjdk-7-jdk \
    python2.7 \
	python3 \
    python-pip \
    python-yaml \
    python-simplejson \
    python-gi \
    subversion \
	unzip \
    wget \
    zlib1g-dev && \
    apt-get clean autoclean && \
    apt-get autoremove -y && \
    pip install ws4py==0.3.2 && \
    pip install tornado && \ 
    pip install bs4 && \
    ln -s /usr/bin/python2.7 /usr/bin/python ; ln -s -f bash /bin/sh

RUN cd /opt && \
    git clone https://github.com/kaldi-asr/kaldi && \
    cd /opt/kaldi/tools && \
    make -j 40 && \
    cd /opt/kaldi/src && ./configure --shared && \
    make depend -j 40 && make -j 40

#get mary and run it in the background

RUN cd /opt && \
    mkdir mary && \
	cd mary && \
	ls && \
    wget https://github.com/marytts/marytts/releases/download/v5.1.1/marytts-5.1.1.zip && \
    unzip marytts-5.1.1.zip -d marytts-5.1.1
#get interface

RUN cd / && \
    git clone https://github.com/JuliusCosmoRomeo/kaldi_interface.git

#set entrypoint
#set default command
	

RUN echo "PATH=$PATH:/usr/local/nvidia/bin:/usr/local/cuda/bin" >> /etc/environment
RUN echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/nvidia/lib:/usr/local/nvidia/lib64" >> /etc/environment

CMD ["/kaldi_interface/help.sh"]

