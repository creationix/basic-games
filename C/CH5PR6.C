#include <stdio.h>
main()
{
float num;
printf("Please enter a floating point number to be squared.\n");
scanf("%f",&num);
square (num);
}
square (float num)
{
float h=num * num;
printf("The number %f, when squared is %f",num,h);
}
