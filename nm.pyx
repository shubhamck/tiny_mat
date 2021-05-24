cimport cnm

def hey():
    cnm.hey()

def add(a, b):
    return cnm.add(a, b)

cdef class Matrix:
    cdef cnm.Matrix* _c_matrix;


    def __init__(self, rows, cols):
        self._c_matrix = cnm.create(rows, cols)
        if self._c_matrix is NULL:
            raise MemoryError("Failed to initialize Matrix")

    def __dealloc__(self):
        if self._c_matrix is not NULL:
            cnm.free_matrix(self._c_matrix)
    
    def shape(self):
        r = cnm.rows(self._c_matrix)
        c = cnm.cols(self._c_matrix)
        return [r, c]


    def __str__(self):
        sol = "["
        r, c = self.shape()
        for i in range(r):
            sol += "["
            for j in range(c):
                sol += str(cnm.get(self._c_matrix, i, j))
                sol += ","
            sol += "]\n"
        sol += "]\n"
        return sol

    def set(self , int row, int col, double val):
        cnm.set(self._c_matrix, row, col, val)
    def set_all(self , double val):
        r, c = self.shape()
        for i in range(r):
            for j in range(c):
                cnm.set(self._c_matrix, i,j , val)

    def mat_add(self, Matrix m):
        cdef cnm.Matrix* m_ptr = m._c_matrix
        if m_ptr is NULL:
            raise MemoryError("Are you passing an empty matrix?")
        cdef cnm.Matrix* result = cnm.mat_add(self._c_matrix, m_ptr)
        cnm.free_matrix(self._c_matrix)
        self._c_matrix = result
        # self._c_matrix = cnm.mat_add_threaded(self._c_matrix, m_ptr)


def add(Matrix a, Matrix b):
    r1, c1 = a.shape()
    r2, c2 = b.shape()

    cdef cnm.Matrix* res_mat;
    cdef cnm.Matrix* a_ptr = a._c_matrix
    cdef cnm.Matrix* b_ptr = b._c_matrix
    if c1 != r2:
        raise ValueError("Matrix dimension mismatch")
    else :
        res_mat = cnm.mat_add(a_ptr, b_ptr);

        res = Matrix(r1, c2)
        res._c_matrix = res_mat

        return res

def scale(Matrix a, double s):
    cdef cnm.Matrix* res;
    res = cnm.scale(a._c_matrix, s)
    r1, c1 = a.shape()
    r = Matrix(r1, c1)
    r._c_matrix = res
    return r



