#!/usr/bin/env bash

DIR=$(dirname $(realpath "$0"))
cd $DIR
set -ex

watchexec --shell=none \
  --project-origin ./css \
  -w ./css \
  -r --exts styl -- ./build.coffee

