FROM continuumio/miniconda3:4.5.4

LABEL \
    author="Shixiang Wang" \
    maintainer="Shixiang Wang" \
    email="w_shixiang@163.com" \
    description="Docker Image for GISTIC 2.0" \
    org.label-schema.license="Academic Free License v.3.0" \
    org.label-schema.vcs-url="https://github.com/ShixiangWang/install_GISTIC/"

COPY install_GISTIC2.sh /opt/
WORKDIR /opt/
RUN echo "Install system dependencies..." && \
    apt-get update && apt-get install -y build-essential zip libxt6 libxmu6 && \
    apt autoremove -y && apt clean -y && apt purge -y && rm -rf /tmp/* /var/tmp/*
RUN echo "Install GISTIC..." && \
    wget -c ftp://ftp.broadinstitute.org/pub/GISTIC2.0/GISTIC_2_0_23.tar.gz && \
    chmod u+x install_GISTIC2.sh && \
    ./install_GISTIC2.sh GISTIC_2_0_23.tar.gz /opt/GISTIC && \
    rm /opt/GISTIC_2_0_23.tar.gz

RUN echo "Deploy GISTIC" && \
    rm /opt/install_GISTIC2.sh && \
    unset DISPLAY && \
    #chmod u+x /opt/GISTIC/gistic2 && ln -s /opt/GISTIC/gistic2 /usr/bin/gistic2 && \
    chmod -R 777 /opt/GISTIC

## set up environment variables
ENV MCR_ROOT=/opt/GISTIC/MATLAB_Compiler_Runtime \
    MCR_VER=v83 \
    LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/runtime/glnxa64:$LD_LIBRARY_PATH \
    LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/bin/glnxa64:$LD_LIBRARY_PATH \
    LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/sys/os/glnxa64:$LD_LIBRARY_PATH \
    XAPPLRESDIR=$MCR_ROOT/$MCR_VER/MATLAB_Component_Runtime/v83/X11/app-defaults

WORKDIR /opt/GISTIC/
ENTRYPOINT [ "/opt/GISTIC/gp_gistic2_from_seg" ]
CMD [ "--help" ]