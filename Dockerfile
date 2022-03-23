ARG BASE_IMAGE=debian:buster-slim
FROM ${BASE_IMAGE}

ARG PYTHON_VERSION=2.7.18
ARG PYTHON_ARCH=.amd64
ARG INSTALL_EXTRA="wine64"

RUN dpkg --add-architecture i386 \
 && apt  update \
 && apt install -y curl \
 && apt install --no-install-recommends -y xauth xvfb wine wine32 ${INSTALL_EXTRA} \
 && rm -rf /var/lib/apt/lists/*

ENV WINEDEBUG=fixme-all
ENV DISPLAY=:0

RUN curl -sO https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}${PYTHON_ARCH}.msi \
 && xvfb-run wine msiexec ADDLOCAL="all" /i python-${PYTHON_VERSION}${PYTHON_ARCH}.msi /qn \
 # kill wineserver nicely to not corrupt wineprefix
 && wineserver -w \
 && rm python-${PYTHON_VERSION}${PYTHON_ARCH}.msi

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
