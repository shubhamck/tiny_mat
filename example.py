import nm
import numpy as np
from time import process_time

# currently only use multiples of 4 for number of rows
ROWS = 16
COLS = 16

m = nm.Matrix(ROWS, COLS)
m.set_all(5)
n = nm.Matrix(ROWS, COLS)
n.set_all(4)

t = process_time()

m.mat_add(n)

print("Elapsed time : ", process_time() - t)

print(m)
