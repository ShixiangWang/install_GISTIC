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
    rm /opt/GISTIC_2_0_23.tar.gz && \
    rm /opt/install_GISTIC2.sh && \
    chmod -R 777 /opt/GISTIC

COPY run_gistic.sh /opt/GISTIC
RUN echo "Deploy GISTIC" && \
    unset DISPLAY && \
    chmod a+x /opt/GISTIC/run_gistic.sh
    #chmod u+x /opt/GISTIC/gistic2 && ln -s /opt/GISTIC/gistic2 /usr/bin/gistic2 && \

WORKDIR /opt/GISTIC/
ENTRYPOINT [ "/opt/GISTIC/run_gistic.sh" ]
CMD [ "--help" ]