#include "pgcd.hpp"

int PGCD(int A, int B) {
	assert(A >= 0);
	assert(B >= 0);
	assert(A <= 65535);
	assert(B <= 65535);
	
    int tempo_a = A;
    int tempo_b = B;

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
	
	assert(A > 0);
	assert(A == B);
	assert((tempo_a % A) == 0);
	assert((tempo_b % A) == 0);
	return A;
}