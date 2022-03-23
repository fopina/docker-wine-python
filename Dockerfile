ARG BASE_IMAGE=debian:buster-slim
FROM ${BASE_IMAGE}

ARG INSTALL_EXTRA="wine64"

RUN dpkg --add-architecture i386 \
 && apt  update \
 && apt install -y curl \
 && apt install --no-install-recommends -y xauth xvfb wine wine32 ${INSTALL_EXTRA} \
 && rm -rf /var/lib/apt/lists/*

ENV WINEDEBUG=fixme-all

ARG PYTHON_VERSION=2.7.18
ARG PYTHON_SUFFIX=.amd64.msi

RUN --mount=type=bind,src=/install_python.sh,target=/install_python.sh \
    /install_python.sh "${PYTHON_VERSION}" "${PYTHON_SUFFIX}"

COPY entrypoint.sh /usr/bin/entrypoint.sh
ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
