#!/bin/sh
# This script is used to build document on Docker.
# You needs to run this at taku-y.github.io/scripts.
export PROJROOT=$(pwd)/../sphinx
# docker run --rm -v $PROJROOT:/tmp taku-y-gio-build_doc "ls tmp; cd tmp; make html"
docker run --rm -v $PROJROOT:/home/jovyan/work taku-y-gio-build_doc make html
