#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#define NUMBER_TEST 65536

int PGCD(int A, int B);
int PGCD_modulo(int A, int B);
int random_ret(void);

int main (int argc, char * argv []){
	int a = 0, b = 0;

	for (int i = 0; i < NUMBER_TEST; i++) {
		a = random_ret();
		b = random_ret();
		if (PGCD_modulo(a,b) == PGCD(a,b))
			printf("Ok \n");
		else {
			printf("Erreur: a = %d, b = %d\n", a, b);
			printf("PGCD_modulo : %d, PGCD : %d\n", PGCD_modulo(a,b), PGCD(a,b));
			return 0;
		}

	}

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
	if (A == 0)
		return B;
	else if (B == 0)
		return A;
	
	while (A != B) {
		if (A > B)
			A = A - B;
		else
			B = B - A;
	}

	return A;
}

