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
    Matrix* mat_add_threaded(Matrix* m1, Matrix* m2)

