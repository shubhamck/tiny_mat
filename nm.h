#include <pthread.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
void hey();
int add(int a, int b);

// Struct ot hold matrix in row major
struct Matrix {
	int rows;
	int cols;
	double* data;
};
typedef struct Matrix Matrix;
Matrix* init();
void free_matrix(Matrix* m);
Matrix* create(int rows, int cols);
Matrix* zeros(int rows, int cols);
Matrix* ones(int rows, int cols);
int rows(Matrix* m);
int cols(Matrix* m);
double* data(Matrix* m);
double get(Matrix* m, int row_id, int col_id);
void set(Matrix* m, int row_id, int col_id, double value);
Matrix* mat_mul(Matrix* m1, Matrix* m2);
Matrix* mat_add(Matrix* m1, Matrix* m2);
Matrix* mat_sub(Matrix* m1, Matrix* m2);
Matrix* mat_add_threaded(Matrix* m1, Matrix* m2);
struct AddArgs {
	int start_index;
	int end_index;
	int rows;
	int cols;
	double* m1_data;
	double* m2_data;
	double* o_data;
};
typedef struct AddArgs AddArgs;
Matrix* scale(Matrix* m, double s);
Matrix* scale_threaded(Matrix* m, double s);
Matrix* get_slice(Matrix* m, int row_start, int row_end, int col_start,
		  int col_end);
bool set_slice(Matrix* m, Matrix* input_slice, int row_start, int row_end,
	       int col_start, int col_end);
bool is_equal(Matrix* m1, Matrix* m2);
Matrix* from_csv(FILE* file);
Matrix* eye(int dim);
