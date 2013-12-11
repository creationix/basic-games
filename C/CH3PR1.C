#include <stdio.h>
main()
{
short a = 32767;
printf("Integer overflow...\n");
printf("%d %d %d\n",a, a+1, a+2);
}
