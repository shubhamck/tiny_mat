# importing libraries
from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [Extension("nm", ["nm.pyx"], libraries=["nm_cimpl"], library_dirs=["."])]

setup(
    name="nm extension module",
    cmdclass={"build_ext": build_ext},
    ext_modules=ext_modules,
)
