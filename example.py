import nm
import numpy as np
from time import process_time

# currently only use multiples of 4 for number of rows
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

output = nm.add(m, n)
print(output)

scaled_output = nm.scale(output, 3)
print(scaled_output)
