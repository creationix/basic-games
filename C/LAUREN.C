#include <stdio.h>
#include <graph.h>

main()
{
    int n;
    int a;
    _setvideomode(18);
    do
    scanf("Please enter the width of the bar %h", &n);

    for (a = 0; a < n; a++)
        line (a, 0, a, 20, 9);
    for (a = n; a < 600; a++)
        line (a, 0, a, 20, 12);
    while (n > 0);
    _setvideomode(3);
    _setvideomode(-1);
}


line (short x1, short y1, short x2, short y2, short color)
{
    _setcolor(color);
    _moveto(x1, y1);
    _lineto(x2, y2);
}


