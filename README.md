# tiny_mat - Tiny Matrix Library using Cython

This is my attempt to write matrix manipulation python library with C-backend.

## Why am I writing this library ?
* Learn Cython to create fast! ( in C )  backend for python functions
* Learn to use threads in C
* Just for fun

## Why C?
* Its fast
* More Control
* I hate myself

Goal is to support common 2D numpy array ( or matrix ) operations like :
- [ ] Addtion, Multiplication
- [ ] Matrix inverses
- [ ] Determinants
- [ ] Gauss Elimination

And multithreaded variations of the above operations!!

## Steps to Use
1. Build the nm C library
```shell 
gcc -shared -o libnm_cimpl.so -fPIC nm_impl.c
```
2. Build the python module
```shell 
python3 setup.py build_ext --inplace
```
3. Now export the library path to your ```LD_LIBRARY_PATH```
``` shell
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/path/to/libnm_cimpl.so
```
4. Run the example
```shell
python3 example.py
```