ARG BASE_IMAGE=debian:buster-slim
FROM ${BASE_IMAGE}

ENV WINEDEBUG=fixme-all

ARG PYTHON_VERSION=2.7.18

RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt install --no-install-recommends -y psmisc curl wine wine32 wine64 \
 && rm -rf /var/lib/apt/lists/*

RUN curl -kO https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}.amd64.msi \
 && wine64 msiexec ADDLOCAL="all" /i python-${PYTHON_VERSION}.amd64.msi /qn \
 # kill wineserver nicely to not corrupt wineprefix
 && killall wineserver64 \
 # and do allow it to stop
 && sleep 2 \
 && rm python-${PYTHON_VERSION}.amd64.msi

ENTRYPOINT [ "wine64", "python" ]
