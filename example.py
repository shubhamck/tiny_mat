import nm
import numpy as np
from time import process_time

ROWS = 16
COLS = 16

m = nm.Matrix(ROWS, COLS)
n = nm.Matrix(ROWS, COLS)

print("Shape : ", m.shape())

m.set_all(5)
n.set_all(6)

t1 = process_time()
m.mat_add(n)
print("Elaspsed time : ", process_time() - t1)
print(m)
