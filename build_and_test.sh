rm *.so

gcc -shared -o libnm_cimpl.so -fPIC nm_impl.c

python3 setup.py build_ext --inplace

LD_LIBRARY_PATH=$PWD:$LD_LIBRARY_PATH python3 ./example.py
