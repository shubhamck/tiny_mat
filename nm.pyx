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
        self._c_matrix = cnm.mat_add(self._c_matrix, m_ptr)
        # self._c_matrix = cnm.mat_add_threaded(self._c_matrix, m_ptr)


        
