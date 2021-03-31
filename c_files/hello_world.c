#include <stdlib.h>
#include <sys/alt_stdio.h>
#include <sys/alt_alarm.h>
#include <sys/times.h>
#include <alt_types.h>
#include <system.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>

#define ALT_CI_CORDIC_IT_0_N 0x0
#define ALT_CI_CORDIC_IT_0(A) __builtin_custom_fnf(ALT_CI_CORDIC_IT_0_N,(A))

// Test case 1
#define step 5
#define N 52


// Test case 2
//#define step 1/8.0
//#define N 2041


//Test case 3
//#define step 1/1024.0
//#define N 261121

//Test case 4
//#define N 2323
//#define RANDSEED 334

//void generateRandomVector(float x[n])
//{
//	int i;
//	srand(RANDSEED);
//	for (i=0; i<N; i++)
//	{
//		x[i] = ( (float) rand()/ (float) RAND_MAX) * 255;
//	}
//}


// Generates the vector x and stores it in the memory
void generateVector(float x[N])
{
	int i;
	x[0] = 0;
	for (i=1; i<N; i++){
		x[i] = x[i-1] + step;
	}
}



float sumVector(float x[], int M)
{
	float y = 0.0;
	for(int i=1; i<M; i++){
		y = y + ALT_CI_CORDIC_IT_0(x[i]);
	}
	return y;
}



int main()
{
	printf("\nTask 7");

	// Define input vector
	float x[N];

	// Returned result
	float y;

	generateVector(x);


	// The following is used for timing
	//char buf[50];
	clock_t exec_t1, exec_t2;

	exec_t1 = times(NULL); // get system time before starting the process

	// The code that you want to time goes here
	double t;

	int j;
	exec_t1 = times(NULL);
	for (j=0;j<10;j++){
		y = sumVector(x, N);
	}
	exec_t2 = times(NULL);

	t = exec_t2 - exec_t1;
	printf("\nTime: %d ", (int)t);

	printf("\nResult: %f", y);


	return 0;
}
