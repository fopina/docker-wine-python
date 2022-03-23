#!/bin/sh

if [ "$1" = "sh" ]; then
    # quick access to shell
    shift
    exec bash "$@"
fi

# xvfb-run hangs if `exec` is used
xvfb-run wine python "$@"
