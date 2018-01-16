FROM debian:stretch-slim
RUN apt-get -y update \
 && apt-get install -y --no-install-recommends tigervnc-standalone-server xterm xfonts-base x11-xserver-utils supervisor openbox firefox-esr wget bzip2 ca-certificates \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Configure environment
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH
ENV BG_USER bbguser
ENV BG_UID 1000
ENV BG_GROUP nlopezb_g
ENV BG_GID 1559
ENV SHELL /bin/bash
ENV HOME /home/$BG_USER
ENV USER $BG_USER

RUN addgroup --gid $BG_GID $BG_GROUP \
 && useradd -m -s /bin/bash -N -g $BG_GROUP -u $BG_UID $BG_USER

RUN mkdir -p $CONDA_DIR \
 && chown $BG_USER:$BG_GROUP /var/log/supervisor

COPY etc/supervisord.conf /etc/supervisor/supervisord.conf
COPY etc/menu.xml /etc/xdg/openbox/menu.xml

# Install conda (downgrade to 4.3.9 due to a bug that will be fixed at 4.3.12
# https://github.com/conda/conda/issues/4621
RUN cd /tmp && \
    mkdir -p $CONDA_DIR && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-4.3.11-Linux-x86_64.sh && \
    echo "b9fe70ce7b6fa8df05abfb56995959b897d0365299f5046063bc236843474fb8 *Miniconda3-4.3.11-Linux-x86_64.sh" | sha256sum -c - && \
    /bin/bash Miniconda3-4.3.11-Linux-x86_64.sh -f -b -p $CONDA_DIR && \
    rm Miniconda3-4.3.11-Linux-x86_64.sh && \
    $CONDA_DIR/bin/conda install --yes conda=4.3.9 && \
    $CONDA_DIR/bin/conda config --system --add channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --add channels defaults && \
    $CONDA_DIR/bin/conda config --system --add channels r && \
    $CONDA_DIR/bin/conda config --system --add channels bioconda && \
    $CONDA_DIR/bin/conda config --system --add channels bbglab && $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    $CONDA_DIR/bin/conda config --system --set allow_softlinks false && \
    $CONDA_DIR/bin/conda config --system --add create_default_packages ipykernel && \
    $CONDA_DIR/bin/conda config --system --set update_dependencies false && \
    conda clean -tipsy

RUN conda install --yes 'notebook=5.0.*' nb_conda_kernels jupyter_contrib_nbextensions jupyter_nbextensions_configurator \
 && conda clean -tipsy

USER $BG_USER
EXPOSE 5900
WORKDIR /home/$BG_USER

CMD ["/usr/bin/supervisord"]
