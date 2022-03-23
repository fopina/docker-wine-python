#!/usr/bin/env python
"""
github action helper to expand matrix options
"""
import sys

DOCKER_IMAGE = 'fopina/wine-python'

tags = sys.argv[1]
suffix = sys.argv[2]

full_tags = [
    '%s:%s%s' % (DOCKER_IMAGE, tag, suffix)
    for tag in tags.split(',')
]

print("::set-output name=full_tags::%s" % ','.join(full_tags))
