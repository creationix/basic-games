#include <stdio.h>
#define D_IN_W 7
main()
{
int day,week,left;
printf("How many days have you had a computer?\n");
scanf("%d",&day);
week = day / D_IN_W;
left = day % D_IN_W;
printf("So you have had it %d weeks and %d days",week,left);
}
