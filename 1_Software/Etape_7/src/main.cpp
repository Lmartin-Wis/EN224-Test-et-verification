#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include "pgcd.hpp"


#define NUMBER_TEST 65536
#define CATCH_CONFIG_MAIN
#include "catch.hpp"

TEST_CASE( "Normal value", "[PGCD]") {
	int a = 0, b = 0;
 
	SECTION( "A > B") {
		a = 6;
		b = 4;
		REQUIRE(PGCD(a,b) == 2);

		a = 13;
		b = 2;
		REQUIRE(PGCD(a,b) == 1);
	}
	SECTION( "A < B") {
		b = 6;
		a = 4;
		REQUIRE(PGCD(a,b) == 2);

		b = 13;
		a = 2;
		REQUIRE(PGCD(a,b) == 1);
	}
	SECTION( "A = B") {
		b = 4;
		a = 4;
		REQUIRE(PGCD(a,b) == 4);

		b = 13;
		a = 13;
		REQUIRE(PGCD(a,b) == 13);
	}
}

TEST_CASE("Particular value", "[PGCD]") {
	int a = 0, b = 0;
 
	SECTION( "A > B") {
		a = 6;
		REQUIRE(PGCD(a,b) == a);
	}
	SECTION( "A < B") {
		b = 6;
		REQUIRE(PGCD(a,b) == b);
	}
	SECTION( "A = B") {
		REQUIRE(PGCD(a,b) == 0);
	}
}

int PGCD_modulo(int A, int B);
int random_ret(void);


/*
int main (int argc, char * argv []){
	//int a = 0, b = 0;

	// Classic case
	int a = 9;
	int b = 6;
	assert(PGCD(a,b) == 3);

	// Prime number
	a = 13;
	b = 6;
	assert(PGCD(a,b) == 1);

	// Case A = B
	a = 6;
	b = 6;
	assert(PGCD(a,b) == 6);

	// Case B>A
	a = 6;
	b = 9;
	assert(PGCD(a,b) == 3);

	// Big value
	a = 65535;
	b = 65534;
	assert(PGCD(a,b) == 1);

	a = 65535;
	b = 0;
	assert(PGCD(a,b) == a);

	a = 0;
	b = 65535;
	assert(PGCD(a,b) == b);

	a = 0;
	b = 0;
	assert(PGCD(a,b) == 0);

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
}*/

// Etape 2
int random_ret(void) {
	int ret = rand() % 65536; // between 1 et randmax, modulo 65535 
	srand(ret); // Set a new seed for better random
	return ret;
}


