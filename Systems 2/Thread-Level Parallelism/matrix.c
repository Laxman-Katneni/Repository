#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <time.h>
#include <stdint.h>
#include <string.h>

#define N 1200           // Number of rows in matrix A
#define M 1000           // Number of columns in matrix A and rows in matrix B
#define P 500            // Number of columns in matrix B
#define MAX_THREADS 5    // Maximum number of threads

// Structure to pass data to threads
typedef struct {
    int start_row;      // Starting row of the matrix for this thread
    int end_row;        // Ending row of the matrix for this thread
} ThreadArgs;

double a[N][M], b[M][P], c1[N][P], c[N][P];

// Initialize matrices A and B
void initialize_matrices() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < M; j++)
            a[i][j] = i + j;
    for (int i = 0; i < M; i++)
        for (int j = 0; j < P; j++)
            b[i][j] = j;
}

// Matrix multiplication without multi-threading
void sequential_multiply() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < P; j++) {
            c1[i][j] = 0;
            for (int k = 0; k < M; k++)
                c1[i][j] += a[i][k] * b[k][j];
        }
}

// Matrix multiplication using multi-threading
void* thread_multiply(void* arg) {
    ThreadArgs* args = (ThreadArgs*) arg;
    int start_row = args->start_row;
    int end_row = args->end_row;

    for (int i = start_row; i < end_row; i++)
        for (int j = 0; j < P; j++) {
            c[i][j] = 0;
            for (int k = 0; k < M; k++)
                c[i][j] += a[i][k] * b[k][j];
        }
    return NULL;
}

// Compare the two result matrices to verify correctness
char* compare_matrices() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < P; j++)
            if (c[i][j] != c1[i][j])
                return "Errors found";
    return "No errors";
}

int main() {
    initialize_matrices();  // Initialize the matrices
    printf("Threads\tSeconds\tErrors\n");

    struct timespec start, end;
    double elapsed_time;

    // Compute matrix product sequentially
    clock_gettime(CLOCK_MONOTONIC, &start);
    sequential_multiply();
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_time = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("1\t%.2f\t%s\n", elapsed_time, "No errors");

    // Compute matrix product using multi-threading, from 2 to MAX_THREADS threads
    for (int num_threads = 2; num_threads <= MAX_THREADS; num_threads++) {
        pthread_t threads[num_threads];
        ThreadArgs thread_args[num_threads];
        int rows_per_thread = N / num_threads;

        clock_gettime(CLOCK_MONOTONIC, &start);
        for (int i = 0; i < num_threads; i++) {
            thread_args[i].start_row = i * rows_per_thread;
            thread_args[i].end_row = (i == num_threads - 1) ? N : (i + 1) * rows_per_thread; // Last thread may handle extra rows
            pthread_create(&threads[i], NULL, thread_multiply, &thread_args[i]);
        }
        for (int i = 0; i < num_threads; i++) {
            pthread_join(threads[i], NULL);
        }
        clock_gettime(CLOCK_MONOTONIC, &end);

        elapsed_time = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1e9;
        printf("%d\t%.2f\t%s\n", num_threads, elapsed_time, compare_matrices());
        memcpy(c, c1, sizeof(c)); // Reset matrix C for the next run
    }

    return 0;
}
