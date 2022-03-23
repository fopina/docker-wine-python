#!/bin/bash

set -ex

PYTHON_VERSION="$1"
PYTHON_SUFFIX="$2"

# download python
curl -sO https://www.python.org/ftp/python/${PYTHON_VERSION}/python-${PYTHON_VERSION}${PYTHON_SUFFIX}

# emulate win10
xvfb-run wine reg add 'HKLM\Software\Microsoft\Windows NT\CurrentVersion' /v CurrentVersion /d 10.0 /f

# install python
if [[ "${PYTHON_SUFFIX}" == *.msi ]]; then
    # ... with msi installer
    xvfb-run wine msiexec ADDLOCAL="all" ALLUSERS=1 /i \
                          python-${PYTHON_VERSION}${PYTHON_SUFFIX} /qn
else
    # ... with exe installer
    xvfb-run wine python-${PYTHON_VERSION}${PYTHON_SUFFIX} \
                  /quiet Include_doc=0 InstallAllUsers=1 PrependPath=1
fi

# kill wineserver nicely to not corrupt wineprefix
wineserver -w

# cleanup
rm python-${PYTHON_VERSION}${PYTHON_SUFFIX}
