#!/bin/bash

# remove oldies
rm -rf build/ && rm -rf nm.cpython-36m-x86_64-linux-gnu.so

# build
python3 setup.py build_ext --inplace

# run test
python3 test_matrix.py
