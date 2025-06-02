#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define BUFFER_SIZE 5

typedef int buffer_item;
buffer_item buffer[BUFFER_SIZE];

pthread_mutex_t buf_mutex;
sem_t buf_empty, buf_full;

int buf_head = 0; // Head of the circular buffer
int buf_tail = 0; // Tail of the circular buffer

int insert_item(buffer_item item) {
    

    // Getting the empty semaphore (decrement)
    if (sem_wait(&buf_empty) != 0) {
        perror("Not able to get empty semaphore");
        return -1;
    }
    
    // Getting the mutex lock
    if (pthread_mutex_lock(&buf_mutex) != 0) {
        perror("Not able to get mutex lock");
        return -1;
    }

    /* insert an item into buffer */
    buffer[buf_tail] = item;
    buf_tail++;
    buf_tail %= BUFFER_SIZE;

    // Releasing the mutex lock and signalling the full semaphore
    if (pthread_mutex_unlock(&buf_mutex) != 0) {
        perror("Unable to release mutex lock");
        return -1;
    }

    if (sem_post(&buf_full) != 0) {
        perror("Unable to signal full semaphore");
        return -1;
    }
    
    
    // success
    return 0;
}

int remove_item(buffer_item *item) {
    // Getting the full semaphore
    if (sem_wait(&buf_full) != 0) {
        perror("Unable to get full semaphore");
        return -1;
    }

    // Getting the mutex lock
    if (pthread_mutex_lock(&buf_mutex) != 0) {
        perror("Unable to get mutex lock");
        return -1;
    }

    // Removing the item from the buffer
    *item = buffer[buf_head];
    buf_head++;
    buf_head %= BUFFER_SIZE;

    // Releasing the mutex lock and signalling the empty semaphore
    if (pthread_mutex_unlock(&mutex) != 0) {
        perror("Unable to release mutex lock");
        return -1;
    }

    if (sem_post(&buf_empty) != 0) {
        perror("Unable to signal empty semaphore");
        return -1;
    }

    // Success
    return 0;
}

void *producer(void *param) {
    buffer_item item;
    while (1) {
        /* generate a random number */
        item = rand();

        // Insertting the item
        if (insert_item(item) != 0) {
            fprintf(stderr, "Error while inserting item.\n");
            
        } else {
            printf("Producer produced %d\n", item);
        }

        /* sleep for a random period of time */
        sleep(rand() % 5);
    }
}

void *consumer(void *param) {
    buffer_item item;
    while (1) {
        // Remove an item from the buffer
        if (remove_item(&item) != 0) {
            fprintf(stderr, "Error while removing item.\n");
        } else {
            printf("Consumer consumed %d\n", item);
        }

        /* sleep for a random period of time */
        sleep(rand() % 5);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <sleep_time> <producerCount> <consumerCount>\n", argv[0]);
        return 1;
    }

    int sleep = atoi(argv[1]);
    int producerCount = atoi(argv[2]);
    int consumerCount = atoi(argv[3]);
    
    if (sleep < 1 || sleep > 10)
    {
        fprintf(stderr, "Given arguments are not valid as Sleep time must be between 1 and 10")
    }
    
    if (producerCount < 1 || producerCount > 5)
    {
        fprintf(stderr, "Given arguments are not valid as producer count should be between 1 and 5\n");
    }

    if (consumerCount < 1 || consumerCount > 5) {
        fprintf(stderr, "Given arguments are not valid as consumer counts must be between 1 and 5\n");
        return 1;
    }

    pthread_t producers[producerCount];
    pthread_t consumers[consumerCount];

    // Initializing
    pthread_mutex_init(&buf_mutex, NULL);
    sem_init(&buf_empty, 0, BUFFER_SIZE);
    sem_init(&buf_full, 0, 0);

    // Creating producer threads
    int i = 0;
    for (i < producerCount) {
        if (pthread_create(&producers[i], NULL, producer, NULL) != 0) {
            perror("Unable to create producer thread");
            return 1;
        }
        i++;
    }

    // Creating consumer threads
    int j = 0;
    while (j < consumerCount) {
        if (pthread_create(&consumers[j], NULL, consumer, NULL) != 0) {
            perror("Unable to create consumer thread");
            return 1;
        }
        j++;
    }

    // Sleep
    sleep(sleep);

    // Cleaning resources
    pthread_mutex_destroy(&buf_mutex);
    sem_destroy(&buf_empty);
    sem_destroy(&buf_full);

    return 0;
}
