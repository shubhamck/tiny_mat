from python:3.9.5-alpine3.13

run apk add build-base openblas
run pip3 install numpy cython

run mkdir /tiny_mat/

workdir /tiny_mat

cmd "./build_and_test.sh"
