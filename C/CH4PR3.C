#include <stdio.h>
main()
{
float num = 0.0;
printf("Please enter a floating point number:\n");
scanf("%f",&num);
printf("a. The input is %.1f or %.1e.\n",num,num);
printf("b. The input is %+.3f or %.3e.\n",num,num);
}
