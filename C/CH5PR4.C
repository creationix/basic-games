#include <stdio.h>
main()
{
int count, sum;
int lim;
printf("This program finds the sum of all the integers from 1 to any number\n");
printf("What is that number?\n");
scanf("%d",&lim);
count = 0;
sum = 0;
while (count++<lim)
    sum +=count;
printf("I have added the numbers from 1 to %d and the sum is %d.\n",lim,sum);
}
