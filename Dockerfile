FROM continuumio/miniconda3:4.5.4
MAINTAINER Shixiang Wang <w_shixiang@163.com>

LABEL \
    description="Image for GISTIC 2.0" \
    version="0.2.0"

RUN apt-get update && apt-get install -y \
    gcc \
    build-essential \
    gawk

COPY install_GISTIC2.sh /opt/.

WORKDIR /opt/
RUN wget -c ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz
RUN chmod u+x install_GISTIC2.sh && ./install_GISTIC2.sh GISTIC_2_0_23.tar.gz /opt/GISTIC
