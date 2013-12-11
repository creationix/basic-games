#include <graph.h>
#include <conio.h>
#include <ctype.h>

short rand(short);
void main(void)
{
    int ch;
    short a;
    short g;
    struct {
        short x;
        short y;
        short s;
    } s[100];
    short p[12];
    for (a = 0 ; a <= 13 ; a++)
        p[a]=(a/20)*100;
    _setvideomode (19);

    for (a = 1;a < 100; a++)
    {
        s[a].x=rand(200)-100;
        s[a].y=rand(200)-100;
        s[a].s=rand(12);
    }
    do 
    {
        for (g = 1;g<10;g++)
        {
            for (a = 1;a < 101; a++)
            {
            _setcolor (0);
            _setpixel(s[a].x+160,s[a].y+100);
            s[a].s=s[a].s+1;
            if (s[a].s > 12)
            {
            s[a].s=1;
            s[a].x=rand(200)-100;
            s[a].y=rand(200)-100;
            }
            s[a].x=s[a].x*(1+p[s[a].s]/100);
            s[a].y=s[a].y*(1+p[s[a].s]/100);
            _setcolor (s[a].s);
            _setpixel(s[a].x+160,s[a].y+100);
            
            }
        }
    }
    while  (isspace(getch()));
        
}

short rand(rg)
short rg;
{
    static short seed = 100;
    seed = (seed * 25173 + 13849) % 65536;
    return (((seed+32768)*rg)/2/32768);
}



