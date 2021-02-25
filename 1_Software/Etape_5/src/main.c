#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include <assert.h>

#define NUMBER_TEST 65536

int PGCD(int A, int B);
int PGCD_modulo(int A, int B);
int random_ret(void);

int main (int argc, char * argv []){
	//int a = 0, b = 0;

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
	PGCD(a,b);
	printf("PGCD(65535,55534), expected : ???, result : %d \n", PGCD(a,b));

	a = 65536;
	b = 2;
	PGCD(a,b);
	printf("PGCD(65536,2), expected : ???, result : %d \n", PGCD(a,b));

	printf("PGCD Ok\n");

  return 0;
}

// Etape 3
int PGCD_modulo(int A, int B) {
	if (A == 0)
		return B;
	else if (B == 0)
		return A;
	
	int tempo = 0;
	while (B != 0) {
		tempo = A % B;
		A = B;
		B = tempo;
	}

	return A;
}

// Etape 2
int random_ret(void) {
	int ret = rand() % 65536; // between 1 et randmax, modulo 65535 
	srand(ret); // Set a new seed for better random
	return ret;
}

// Etape 1 et 2
int PGCD(int A, int B) {
	assert(A >= 0);
	assert(B >= 0);
	if (A == 0)
		return B;
	else if (B == 0)
		return A;
	assert(A <= 65535);
	assert(B <= 65535);

	while (A != B) {
		if (A > B)
			A = A - B;
		else
			B = B - A;
	}

	return A;
}

