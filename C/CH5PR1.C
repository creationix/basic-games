#include <stdio.h>
#define M_TO_H 60
main()
{
    int min, hour, left;
    printf("This progran converts minutes to hours and minutes.\n");
    while (min > 0) {
        printf("Please enter the number of minutes (0 to end)\n");
        scanf("%d",&min);
        if (min>0){
        hour = min / M_TO_H;
        left = min % M_TO_H;
        printf("%d minutes is %d:%02d\n",min,hour,left);
        }
    }
    printf("Bye!\n");
}
