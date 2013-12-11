// Tim Caswell
// 10-5-98

#include <iostream.h>

class box
{
private:
   int width;
   int height;
public:
   box();
   void assign (int w, int h)
      { width = w; height = h; }
   int getWidth() { return width; }
   int getHeight() { return height; }
};

void main()
{
   box a;
   a.assign(2, 4);
   cout << "\nWidth: " << a.getWidth();
   cout << "\nHeight: " << a.getHeight();
   return;
}



















































































































































































































