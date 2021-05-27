from libc cimport bool
cdef extern from "nm.h":

    void hey()

    int add(int a, int b)

    ctypedef struct Matrix:
        pass

    Matrix* init()
    void free_matrix(Matrix* m)
    Matrix* create(int rows, int cols)
    # Matrix* zeros(int rows, int cols)
    # Matrix* ones(int rows, int cols)
    int rows(Matrix* m)
    int cols(Matrix* m)
    double* data(Matrix* m)
    double get(Matrix* m, int row_id, int col_id);
    void set(Matrix* m, int row_id, int col_id, double value);
    Matrix* mat_add(Matrix* m1, Matrix* m2)
    Matrix* mat_sub(Matrix* m1, Matrix* m2) 
    Matrix* mat_add_threaded(Matrix* m1, Matrix* m2)
    Matrix* scale(Matrix* m, double s)
    Matrix* get_slice(Matrix* m, int row_start, int row_end, int col_start, int col_end)
    bint is_equal(Matrix* m1, Matrix* m2)
    Matrix* eye(int dim)
    bint set_slice(Matrix* m, Matrix* input_slice, int row_start, int row_end,
	       int col_start, int col_end)

