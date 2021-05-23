#include <pthread.h>
#include <stdio.h>
#include "nm.h"
void hey() { printf("Heyeye!!!!!\n"); }
int add(int a, int b) { return a + b; }
Matrix* init() {
	Matrix* m = (Matrix*)malloc(sizeof(Matrix));
	m->cols = 0;
	m->rows = 0;
	m->data = NULL;
	return m;
}
void free_matrix(Matrix* m) { free(m); }
Matrix* create(int rows, int cols) {
	Matrix* m = (Matrix*)malloc(sizeof(Matrix));
	m->cols = cols;
	m->rows = rows;
	m->data = (double*)malloc(rows * cols * sizeof(double));
	return m;
}
Matrix* zeros(int rows, int cols) {
	Matrix* m = create(rows, cols);
	int i = 0;
	for (i = 0; i < rows * cols; ++i) {
		m->data[i] = 0.0;
	}
	return m;
}
Matrix* ones(int rows, int cols) {
	Matrix* m = create(rows, cols);
	int i = 0;
	for (i = 0; i < rows * cols; ++i) {
		m->data[i] = 1.0;
	}
	return m;
}
int rows(Matrix* m) { return m->rows; }
int cols(Matrix* m) { return m->cols; }
double* data(Matrix* m) { return m->data; }
double get(Matrix* m, int row_id, int col_id) {
	double* a = m->data;
	return a[row_id * m->cols + col_id];
}
void set(Matrix* m, int row_id, int col_id, double value) {
	double* a = m->data;
	a[row_id * m->cols + col_id] = value;
}
Matrix* mat_mul(Matrix* m1, Matrix* m2) {
	// O(n^3) naive algorithm
	// we will implement the more optimal ( may be multi threaded ) algo
	// later
	int r1 = rows(m1);
	int r2 = rows(m2);
	int c1 = cols(m1);
	int c2 = cols(m2);

	if (c1 != r2) {
		return NULL;
	}
	return NULL;
}
void* add_func(void* args) {
	AddArgs* add_args = (AddArgs*)(args);
	int start_index = add_args->start_index;
	int end_index = add_args->end_index;
	int r = add_args->rows;
	int c = add_args->cols;
	double* a = add_args->m1_data;
	double* b = add_args->m2_data;
	int i = 0;
	int j = 0;
	for (i = start_index; i < end_index; ++i) {
		int row_elem = i * c;
		for (j = 0; j < c; ++j) {
			int elem = row_elem + j;
			double a1 = a[elem];
			double b1 = b[elem];
			add_args->o_data[elem] = a1 + b1;
		}
	}

	pthread_exit(NULL);
}
void set_add_args(AddArgs* args, int start_index, int end_index, int rows,
		  int cols, double* m1, double* m2, double* sum) {
	args->start_index = start_index;
	args->end_index = end_index;
	args->rows = rows;
	args->cols = cols;
	args->m1_data = m1;
	args->m2_data = m2;
	args->o_data = sum;
}
Matrix* mat_add_threaded(Matrix* m1, Matrix* m2) {
	int r1 = rows(m1);
	int r2 = rows(m2);
	int c1 = cols(m1);
	int c2 = cols(m2);
	if (r1 != r2 || c1 != c2) {
		return NULL;
	}
	Matrix* sum = create(r1, c1);
	int i = 0;
	int j = 0;
	int NUM_THREADS = 4;
	pthread_t* threads =
	    (pthread_t*)malloc(NUM_THREADS * sizeof(pthread_t));
	AddArgs* add_args = (AddArgs*)malloc(NUM_THREADS * sizeof(AddArgs));
	int rows_per_threads = r1 / NUM_THREADS;
	for (i = 0; i < NUM_THREADS; ++i) {
		set_add_args(&add_args[i], i * rows_per_threads,
			     (i + 1) * rows_per_threads, r1, c1, m1->data,
			     m2->data, sum->data);
		pthread_create(&threads[i], NULL, add_func, &add_args[i]);
	}

	for (i = 0; i < NUM_THREADS; ++i) {
		pthread_join(threads[i], NULL);
	}
	return sum;
}
Matrix* mat_add(Matrix* m1, Matrix* m2) {
	int r1 = rows(m1);
	int r2 = rows(m2);
	int c1 = cols(m1);
	int c2 = cols(m2);
	if (r1 != r2 || c1 != c2) {
		return NULL;
	}
	Matrix* sum = create(r1, c1);
	int i = 0;
	int j = 0;
	for (i = 0; i < r1; ++i) {
		for (j = 0; j < c1; ++j) {
			double a = get(m1, i, j);
			double b = get(m2, i, j);
			set(sum, i, j, a + b);
		}
	}
	return sum;
}
