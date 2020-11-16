FROM ubuntu:18.04

MAINTAINER jmonlong@ucsc.edu

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ARG THREADS=4

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
        wget \
        curl \
        nano \
        less \
        python3 \
        python3-pip \
        python3-setuptools \
        python3-dev \
        gcc \ 
        bcftools \
        samtools \
        tabix \
        tzdata \
        make \
        pigz \
        gawk \
        bzip2 \
        git \
        sudo \
        pkg-config \
        singularity-container \
        libxml2-dev libssl-dev libmariadbclient-dev libcurl4-openssl-dev \ 
        apt-transport-https software-properties-common dirmngr gpg-agent \ 
        && rm -rf /var/lib/apt/lists/*

ENV TZ=America/Los_Angeles

WORKDIR /build

## GNU time
RUN wget https://ftp.gnu.org/gnu/time/time-1.9.tar.gz && \
        tar -xzvf time-1.9.tar.gz && \
        cd time-1.9 && \
        ./configure && \
        make && \
        make install

## AWS cli and modules for Snakemake
RUN pip3 install --upgrade pip

RUN pip3 install --no-cache-dir requests awscli snakemake boto3 pandas numpy

WORKDIR /home
ADD run.sh /home
