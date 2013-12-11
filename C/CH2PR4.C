#include <stdio.h>
main()
{
int a;
for (a=1; a<=3;a++)
    good();
deny();
}

good(void)
{
printf("For he's a jolly god fellow!\n");
}

deny(void)
{
printf("Which nobody can deny!\n");
}
