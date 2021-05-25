cimport cnm

def hey():
    cnm.hey()

def add(a, b):
    return cnm.add(a, b)

cdef class Matrix:
    cdef cnm.Matrix* _c_matrix;


    def __cinit__(self, rows, cols):
        self._c_matrix = cnm.create(rows, cols)
        if self._c_matrix is NULL:
            raise MemoryError("Failed to initialize Matrix")

    def __dealloc__(self):
        print("Calling dealloc")
        if self._c_matrix is not NULL:
            cnm.free_matrix(self._c_matrix)
            print("Done dealloc")
    
    def shape(self):
        r = cnm.rows(self._c_matrix)
        c = cnm.cols(self._c_matrix)
        return [r, c]

    cdef set_ptr(self, cnm.Matrix* m):
        # first free the earlier memory
        cnm.free_matrix(self._c_matrix)
        # then assign the new pointer
        self._c_matrix = m

    def __getitem__(self, some_slice):
        print(some_slice)
        r , c = self.shape()

        if isinstance(some_slice, tuple):
            if isinstance(some_slice[0], slice):
                row_slice = some_slice[0]
                col_slice = some_slice[1]
                m = Matrix(0, 0)
                row_start = row_slice.start if row_slice.start != None else 0
                row_end = row_slice.stop if row_slice.stop != None else r
                col_start = col_slice.start if col_slice.start != None else 0
                col_end = col_slice.stop if col_slice.stop != None else c
                # m._c_matrix = cnm.get_slice(self._c_matrix, row_start, row_end, col_start, col_end)
                m.set_ptr(cnm.get_slice(self._c_matrix, row_start, row_end, col_start, col_end))
                return m
            else:
                return cnm.get(self._c_matrix, some_slice[0], some_slice[1])

        if isinstance(some_slice, slice):
            print("Slice : ", some_slice.start, some_slice.stop, some_slice.step)
        return 0


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
        # cdef cnm.Matrix* result = cnm.mat_add(self._c_matrix, m_ptr)
        cdef cnm.Matrix* result= cnm.mat_add_threaded(self._c_matrix, m_ptr)
        cnm.free_matrix(self._c_matrix)
        self._c_matrix = result

    def scale(self, double s):
        cdef cnm.Matrix* res = cnm.scale(self._c_matrix, s)
        cnm.free_matrix(self._c_matrix)
        self._c_matrix = res


    def __add__(Matrix self, Matrix other):
        if isinstance(other, Matrix):
            if other.shape() != self.shape():
                ValueError("Dimension mismatch")
            else:
                res = Matrix(0,0)
                res.set_ptr(cnm.mat_add(self._c_matrix, other._c_matrix))
                return res
        else:
            TypeError("Argument should be a matrix")


    def __eq__(Matrix self, Matrix other):
        if isinstance(other, Matrix):
            return cnm.is_equal(self._c_matrix, other._c_matrix)
        else:
            TypeError("Argument should be a matrix")


    @staticmethod
    def zeros( shape):
        if isinstance(shape, tuple):
            r, c = shape[0], shape[1]
            m = Matrix(r, c)
            m.set_all(0.0)
            return m
        else:
            m = Matrix(shape, 1)
            m.set_all(0.0)
            return m

    @staticmethod
    def ones( shape):
        if isinstance(shape, tuple):
            r, c = shape[0], shape[1]
            m = Matrix(r, c)
            m.set_all(1.0)
            return m
        else:
            m = Matrix(shape, 1)
            m.set_all(1.0)
            return m


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



