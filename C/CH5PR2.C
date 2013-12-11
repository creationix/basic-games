#include <stdio.h>
main()
{
int num, a;
printf("Please enter an integer.\n");
scanf("%d",&num);
printf("The integers from %d to %d are...\n",num,num+10);
for (a=num;a<=num+10;a++)
    printf("%d\n",a);
}
