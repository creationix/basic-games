// Tim Caswell
// 10-4-98

#include <iostream.h>

class box
{
   private:
      double width;      //data members
      double height;
   public:
      box();      //Default constructor
      box(double w, double h) // assigment constructor
         { width = w; height = h; }
      box(const box& b);  // copy constructor
      double getWidth() { return width; }
      double getHeight() { return height; }
      double getArea() { return (width * height); }
};

void main()
{
   box Ba;            //Uses default constructor
   box Bb(1.3, 4.3);  //Uses assigment constructor
   box Bc(Bb);        //Uses copy onstructor
   cout << "\nBox A has width " << Ba.getWidth() << ", Height " << Ba.getHeight;
   cout << "\nBox B has width " << Bb.getWidth() << ", Height " << Bb.getHeight;
   cout << "\nBox C has width " << Bc.getWidth() << ", Height " << Bc.getHeight;
   cout << "\nBox C has area " << Bc.getArea();
   return;
}


