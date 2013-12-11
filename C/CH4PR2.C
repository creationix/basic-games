#include <stdio.h>
main()
{
char name[20];
printf("Please enter your first name:\n");
scanf("%s",name);
printf("Here are some ways to show your name...\n");
printf("\"%s\"\n",name);
printf("\"%20s\"\n",name);
printf("\"%-20s\"\n",name);
printf("\"%s   \"\n",name);
}
