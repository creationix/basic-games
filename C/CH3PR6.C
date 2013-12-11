#include <stdio.h>
main()
{
float quart=0.0;
float grams=0.0;
float mol=0.0;
printf("How many quarts of water do you have?\n");
scanf("%f",&quart);
printf("You have %g quarts of water\n",quart);
grams = quart * 950;
printf("You have %g grams of water\n",grams);
mol = grams *3.0e23;
printf("You have %g molecules water\n",mol);
}
