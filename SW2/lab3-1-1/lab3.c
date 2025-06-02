#include <stdio.h>
#include "lab3.h"

/*Author: Lucky Katneni */
/* BY SUBMITTING THIS FILE TO CARMEN, I CERTIFY THAT I HAVE PERFORMED ALL OF THE
** WORK TO CREATE THIS FILE AND/OR DETERMINE THE ANSWERS FOUND WITHIN THIS
** FILE MYSELF WITH NO ASSISTANCE FROM ANY PERSON (OTHER THAN THE INSTRUCTOR
** OR GRADERS OF THIS COURSE) AND I HAVE STRICTLY ADHERED TO THE TENURES OF THE
** OHIO STATE UNIVERSITY’S ACADEMIC INTEGRITY POLICY.
     */

int main(void) 
{
	int numBooks = 0;  /* Number of books*/
	int input = 0;	/* User input to save file or not*/
	int i = 0;		/* iterator*/
	int numFavs = 0;	/* Number of favorite books*/

	printf("How many library book titles do you plan to enter?:\n");	
	scanf("%i", &numBooks);
	
	printf(" \n");

	/* while (numBooks < 1)			check to make sure the user enters correct numbers
	{
		printf("Please re-enter a valid number:\n");
		scanf("%i", &numBooks);
	}
	*/
	
	char** books = (char**) malloc (numBooks * sizeof(char *));	/* Pointer of all names of books */

	popTitles(numBooks, books);		/* Populating titles of books read by the user*/
	
	printf(" \n");

	printf("Of those %i books, how many do you plan to put on your favorites list?\n", 	numBooks);
	scanf("%i", &numFavs);	

	char** favBooks = popFavs(books, numBooks, numFavs);	/* Populating favorite book titles */

	printf(" \n");

	printf("Do you want to save them (1=yes, 2=no):\n");
	scanf("%i", &input);	

	if (input == 1)
	{
		toFile (books, numBooks, favBooks, numFavs);	/* Saving data in a file*/
	}
	


}

void popTitles (int numBooks, char** books)
{
	int i = 0;	
	char inputChar = getchar();		/* input character & to get rid of empty line in file */

	printf("Enter the %i book titles one to a line:\n", numBooks);	

	for (i; i < numBooks; i++)		
	{
		int j = 0;
		char* arr =  (char*) malloc (61 * sizeof(char));

		inputChar = getchar();

		while (inputChar != '\n')	/* To get an entire line*/
		{
			arr[j] = inputChar;
			j++;
			inputChar = getchar();
		} 
		
		*(books + i)= arr;		/* Noting it in books*/
		printf("%i. %s\n", i + 1, *(books + i));		
		
	}
}

char** popFavs (char** books, int numBooks, int numFavs) 
{

	int i = 0;
	int j = 0;

	int* favBookNums = (int*) malloc(numFavs * sizeof(int));	/* array of fav book indexes in the list shown */
	char** favBooks = (char**) malloc (numFavs * sizeof(char *));
	

	printf("Enter the number next to each book title you want on your favorites list: \n");
	
	for (i; i < numFavs; i++)
	{
		scanf("%i", &*(favBookNums + i));
		*(favBooks + i) = *(books + (*(favBookNums + i) - 1));

	}
	
	printf(" \n");

	printf("The books on your favorites list are:\n");

	for (j; j < numFavs; j++)		/* printing fav books*/
	{
		printf("%i. %s\n", j + 1, *(favBooks + j));
	}

	return favBooks;
	

}

void toFile (char** books, int numBooks, char** favBooks, int numFavs)
{
		char* fileName = (char*) malloc(251 * sizeof(char));
		char* file = (char*) malloc(256 * sizeof(char));
		char* extension = ".txt";
		char inputChar = getchar();	/* getting rid of extra line*/

		int i = 0;
		int j = 0;
		int k = 0;



		printf("What file name do you want to use?\n");	

		inputChar = getchar();

		while (inputChar != '\n')
		{
			*(fileName + j) = inputChar;
			j++;
			inputChar = getchar();
		} 

		sprintf(file, "%s%s", fileName, extension);	/*Concatanating */

		FILE* out = fopen(file, "w");


		fprintf(out, "Books I've Read:\n");
		for (i; i < numBooks; i++)
		{
			fprintf(out, "%s\n", *(books + i));
		}

		fprintf(out, " \n");

		fprintf(out, "My Favorites are:\n");
		for (k; k < numFavs; k++)
		{
			fprintf(out, "%s\n", *(favBooks + k)) ;
		}

		fclose(out);

		printf("Your booklist and favorites have been saved to the file %s.\n", fileName);
		

		
}

