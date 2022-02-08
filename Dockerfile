FROM python:3.9-slim
FROM jupyter/all-spark-notebook:17aba6048f44

# install the notebook package
RUN pip install --no-cache --upgrade pip
#RUN pip install --no-cache notebook jupyterlab
#RUN pip install --no-cache-dir notebook
#RUN pip install --no-cache-dir jupyterhub

RUN pip install --no-cache-dir vdom==0.5

# create user with a home directory
ARG NB_USER=kanakpc
ARG NB_UID=1000
ENV USER ${NB_USER}
ENV NB_UID ${NB_UID}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

WORKDIR ${HOME}

RUN apt-get update
RUN apt-get install default-jdk -y

# pip install -r binder/requirements.txt
RUN pip install numpy
RUN pip install pandas
RUN pip install pyspark
