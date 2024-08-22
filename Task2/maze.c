#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_ROWS 100
#define MAX_COLS 100
#define MAX_LINE_LENGTH 1000

char rooms[MAX_ROWS][MAX_COLS];
int row = 0;
int column = 0;

void read_file(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error opening file\n");
        exit(1);
    }
    fclose(file);
}

int short_distance(const char* file, int row, int column){
    
}


int main() {
    FILE* map= fopen("/Users/jacsty01/hackathon-aug-24/Task2/example_data.txt", "r");
    if (!map){
        perror("File opening failed!\n");
        return EXIT_FAILURE;
    }
    int rows = 0;
    int columns = 0;
    
    fscanf(map, "%d", &rows);
    fscanf(map, "%d", &columns);

    float matrix[rows][columns];
    // float sumOfRows[rows];

    for(int i = 0; i < rows; ++i){
        for(int j = 0; j < columns; ++j)
        {
            // float x = fscanf(map, "%f", &matrix[i][j]);
            // int x = fscanf(map, "%d", &rows);
            printf("%f", matrix[i][j]);
        } 
    }
    
}

//int goRight()