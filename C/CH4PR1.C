#include <stdio.h>
main()
{
char first[20];
char last[20];
printf("Please enter your first name:\n");
scanf("%s",first);
printf("Please enter your last name:\n");
scanf("%s",last);
printf("So %s you formal name is\n",first);
printf("%s, %s",last,first);
}
