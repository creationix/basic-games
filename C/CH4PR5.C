#include <stdio.h>
main()
{
char first[10];
char last[20];
int firstl;
int lastl;
printf("What is your first name?\n");
scanf("%s",first);
printf("What is your last name?\n");
scanf("%s",last);
firstl = strlen(first);
lastl = strlen(last);
printf("%s %s\n",first,last);
printf("%*d %*d\n",firstl,firstl,lastl,lastl);
printf("%s %s\n",first,last);
printf("%-*d %-*d\n",firstl,firstl,lastl,lastl);
}

