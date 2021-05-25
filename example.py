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


m.set(5, 6, 10.0)
print(m)

print("Hey  : ", m[5, 6])
s = m[4:, 6:9]
print("S : ", s)
# m[5:6]
# m[5:, 6:7]
# m[5:10, 6:7]
