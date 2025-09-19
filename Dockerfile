# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ghcr.io/ucsd-ets/datascience-notebook:2025.2-stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN apt-get update && apt-get -y install openjdk-17-jre-headless curl tar
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz -o /tmp/apache-maven.tar.gz \
    && tar -xzf /tmp/apache-maven.tar.gz -C /opt \
    && rm /tmp/apache-maven.tar.gz

ENV MAVEN_HOME=/opt/apache-maven-3.9.6
ENV PATH=$MAVEN_HOME/bin:$PATH
# 3) install packages using notebook user
# USER vtaluja

# RUN conda install -y scikit-learn

# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt

# Override command to disable running jupyter notebook at launch
CMD ["/bin/bash"]
