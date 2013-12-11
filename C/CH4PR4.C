#include <stdio.h>
main()
{
char name[10];
float feet;
float inches;
printf("What is your name?\n");
scanf("%s",name);
printf("How many inches tall are you?\n");
scanf("%f",&inches);
feet=inches/12;
printf("%s, you are %.3f feet tall.\n",name,feet);
}
