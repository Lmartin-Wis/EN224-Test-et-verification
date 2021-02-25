#include "stdio.h"
#include "stdlib.h"
#include "math.h"

int PGCD(int A, int B);

int main (int argc, char * argv []){
	printf("Starting PGCD program\n\n");
	
	// Classic case
	int a = 9;
	int b = 6;
	printf("PGCD(9,6), expected : 3, result : %d \n", PGCD(a,b));

	// Prime number
	a = 13;
	b = 6;
	printf("PGCD(13,6), expected : 1, result : %d \n", PGCD(a,b));

	// Case A = B
	a = 6;
	b = 6;
	printf("PGCD(6,6), expected : 6, result : %d \n", PGCD(a,b));

	// Case B>A
	a = 6;
	b = 9;
	printf("PGCD(6,9), expected : 3, result : %d \n", PGCD(a,b));

	// Big value
	a = 65535;
	b = 65534;
	printf("PGCD(65535,55534), expected : ???, result : %d \n", PGCD(a,b));


  return 0;
}


int PGCD(int A, int B) {
	/*if (A < 0 || B < 0)
		return 0;*/
	
	while (A != B) {
		if (A > B)
			A = A - B;
		else
			B = B - A;
	}

	return A;
}
