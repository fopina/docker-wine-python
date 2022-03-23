#!/usr/bin/env python
"""
github action helper to expand matrix options
"""
import sys

DOCKER_IMAGE = 'fopina/wine-python'

tags = sys.argv[1]
suffix = sys.argv[2]
py_suffix = sys.argv[3]
arch_suffix = sys.argv[4]

full_tags = [
    '%s:%s%s' % (DOCKER_IMAGE, tag, suffix)
    for tag in tags.split(',')
]

print("::set-output name=full_tags::%s" % ','.join(full_tags))

if not py_suffix:
    print('::error title=workflow::python.suffix is a required field')
    exit(2)

if arch_suffix:
    if py_suffix[-3:] == 'exe':
        # exe installer uses '-' for arch
        python_suffix = '-%s.%s' % (arch_suffix, py_suffix)
    else:
        # msi installer uses '.'...
        python_suffix = '.%s.%s' % (arch_suffix, py_suffix)
else:
    python_suffix = '.%s' % py_suffix

print("::set-output name=python_suffix::%s" % python_suffix)
