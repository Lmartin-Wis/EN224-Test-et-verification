#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#define NUMBER_TEST 2000

int PGCD(int A, int B);
int random_ret(void);

int main (int argc, char * argv []){
	printf("Starting PGCD program\n\n");
	int a = 0, b = 0;

	for (int i = 0; i < NUMBER_TEST; i++) {
		a = random_ret();
		b = random_ret();
		printf("PGCD(%d,%d); result : %d\n", a, b, PGCD(a,b));
	}

  return 0;
}


int random_ret(void) {
	int ret = rand() % 65536; // between 1 et randmax, modulo 65535 
	srand(ret); // Set a new seed for better random
	return ret;
}

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
