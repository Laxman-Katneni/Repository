#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <signal.h>
#include <sys/wait.h>
#include <unistd.h>

#define COMMAND_SIZE 80 // Maximum size for each command
#define HISTORY_SIZE 10 // Maximum number of commands stored in history

// Static arrays to store command history and the previous command executed
static char commandHist[HISTORY_SIZE][COMMAND_SIZE];
static int cmdNum = 0;  // Current number of commands executed
static int front = 0;   // Front index for the circular command history buffer
static char previousCommand[COMMAND_SIZE];

/* Method to run a command */
void runCommand(char *args[]) {
    
    pid_t pid;

    // Create a child process
    pid = fork();

    // Child process
    if (pid == 0) {
        // Execute the command
        if (execvp(args[0], args) == -1) {
            printf("Invalid Command!\n");
            exit(EXIT_FAILURE);
        }
    }
    else if (pid < 0) { // Forking error
        printf("Error while fork!\n");
    }// Parent process
    else {
        waitpid(pid, &exec, 0); // Wait for child process to finish
    }
    
    // If a command was provided, add it to history
    if (args[0]) {
        // Check if there's still space in history
        if (cmdNum < HISTORY_SIZE) {
            strcpy(commandHist[cmdNum], args[0]);
            cmdNum++;
        } else {
            // Use buffer logic for command history
            strcpy(commandHist[front], args[0]);
            front++;
            front %= HISTORY_SIZE;
        }

        // Store the command as the previous command
        strcpy(previousCommand, args[0]);
    }
}

/* Method to present the latest commands */
void printPreviousCommands() {
    int j = cmdNum - HISTORY_SIZE >= 0 ? cmdNum - HISTORY_SIZE : 0;

    printf("Previous Commands:\n");
    int i = j;
    while (i < cmdNum) {
        printf("%d:\t%s\n", i + 1, commandHist[i % HISTORY_SIZE]);
        i++;
    }
}

/* Handler for SIGINT */
void ctrlCHandler(int signalNum) {
    if (signalNum == SIGINT) {
        printf("\nCtrl+C is detected- Showing previous commands:\n");
        printPreviousCommands();
        fflush(stdout);
        
        char *recentArgs[(COMMAND_SIZE / 2) + 1];
        recentArgs[0] = previousCommand;
        recentArgs[1] = NULL;
        runCommand(recentArgs);// Executing the most recent command
    }
}

int main() {
    
    char *inputs[(COMMAND_SIZE / 2) + 1];
    char commandBuffer[COMMAND_SIZE];
    
    
    // Set up the signal handler for SIGINT
    struct sigaction action;
    action.sa_handler = ctrlCHandler;
    sigaction(SIGINT, &action, NULL);

    // Main loop to get user input and execute commands
    while (1) {
        printf("INPUT_COMMAND>");
        fflush(stdout);
        fgets(commandBuffer, COMMAND_SIZE, stdin);

        // Remove newline character from command
        size_t len = strlen(commandBuffer);
        if (commandBuffer[len - 1] == '\n' && len > 0) {
            commandBuffer[len - 1] = '\0';
        }

        char *split = strtok(commandBuffer, " ");           // Splitting the input
        int i = 0;
        while (split) {
            inputs[i] = split;
            split = strtok(NULL, " ");
            i++;
        }
        inputs[i] = NULL;
        // If a command was provided
        if (inputs[0]) {
            // Check if the command is 'r' to re-execute previous commands
            if (strcmp(inputs[0], "r") == 0) {
                if (i > 1) {
                    int command_idx;
                    if (sscanf(inputs[1], "%d", &command_idx) == 1) {
                        if (command_idx > 0 && command_idx <= cmdNum) {
                            char *commandToRun = commandHist[(command_idx - 1) % HISTORY_SIZE];
                            char *recentArgs[(COMMAND_SIZE / 2) + 1];
                            recentArgs[0] = commandToRun;
                            recentArgs[1] = NULL;
                            runCommand(recentArgs);
                        } else {
                            printf("History Index is Not Valid\n");
                        }
                    } else {
                        printf("Invalid 'r' command format\n");
                    }
                } else {
                    
                    if (cmdNum> 0)  // Executing the most recent commands in history
                    {
                        char *commandToRun = commandHist[(cmdNum - 1) % HISTORY_SIZE];
                        char *recentArgs[(COMMAND_SIZE / 2) + 1];
                        recentArgs[0] = commandToRun;
                        recentArgs[1] = NULL;
                        runCommand(recentArgs);
                    }
                }
            } else {
                // Execute the provided command
                runCommand(inputs);
            }
        }
    }

}
