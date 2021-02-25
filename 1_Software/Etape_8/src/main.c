#include <stdio.h>
#include "stdlib.h"
#include "math.h"
#include <assert.h>

#define NUMBER_TEST 65536

int PGCD(int A, int B);
int PGCD_modulo(int A, int B);
int random_ret(void);

int main (int argc, char * argv []){

	FILE * f_a;
	f_a = fopen("ref_A.txt", "r+");
	if (f_a == NULL) {
		printf("Erreur?\n");
		return 0;
	}
	FILE * f_b = fopen("ref_B.txt", "r");
	if (f_b == NULL) {
		printf("Erreur?\n");
		return 0;
	}
	FILE * f_c = fopen("resu_c.txt", "w");
	if (f_c == NULL) {
		printf("Erreur?\n");
		return 0;
	}
	
	int value_a = 0;
	int value_b = 0;
	int value_c = 0;
	int i = 0;

	for (i = 0; i < 65536; i++) {
		fscanf(f_a, "%d", &value_a);
		fscanf(f_b, "%d", &value_b);
		value_c = PGCD(value_a, value_b);
		fprintf(f_c, "%d\r\n", value_c);
	}
	fclose(f_a);
	fclose(f_b);
	fclose(f_c);
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

