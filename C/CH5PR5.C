#include <stdio.h>
main()
{
int count, lim;
int sum;
printf("This program finds the sum of all the squares of the integers from 1 to any number\n");
printf("What is that number?\n");
scanf("%d",&lim);
count = 0;
sum = 0;
while (count++<lim)
    sum +=(count*count);
printf("I have added the squares of the numbers from 1 to %d and the sum is %d.\n",lim,sum);
}
