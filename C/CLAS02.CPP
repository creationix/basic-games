// Tim Caswell
// 10-5-98
// A class to show how to use friend operators and overide math operators


#include <iostream.h>

class complex
{
   protected:
      double real;
      double imag;
   public:
      complex()                  // Default constructor
         { real = 0; imag = 0; }
      complex(const complex& c)  // Copy constructor
         { real = c.real; imag = c.imag; }
      complex(double r, double i) // assignment constructor
         { real = r; imag = i; }
      void assign(double r, double i) // assigment function
         { real = r, imag = i; }
      double getReal()            // Get the real value
         { return real; }
      double getImag              // Get the Imag value
         { return imag; }
      complex& operator =(complex& c);  // overide the = operator
      complex& operator +=(complex& c); // overide the += operator
      complex& operator -=(complex& c); // overide the -= operator
      friend complex operator +(complex& c1, complex& c2); // overide +
      friend complex operator -(complex& c1, complex& c2); // overide -
      friend ostream operator <<(ostream& os, complex& c); // overide << with ostream
};

complex& operator =(complex& c);  // overide the = operator
{
   real = c.real;
   imag = c.imag;
   return *this;
}

complex& operator +=(complex& c); // overide the += operator
{
   real += c.real;
   imag += c.imag;
   return *this;
}

complex& operator -=(complex& c); // overide the -= operator
{
   real -= c.real;
   imag -= c.imag;
   return *this;
}

complex operator +(complex& c1, complex& c2); // overide +
{
   complex result(c1);
   result.real += c2.real;
   result.imag += c2.inag;
   return result;
}

complex operator -(complex& c1, complex& c2); // overide -
{
   complex result(c1);
   result.real -= c2.real;
   result.imag -= c2.inag;
   return result;
}

ostream operator <<(ostream& os, complex& c); // overide << with ostream
{
   os << "(" << c.real << " + i" << c.imag << ")";
   return os;
}

void main()
{
   complex num1(3, 5);
   complex num2(7, 5);
   complex num3, num4;
   complex num5(num4);

   num4.assign(2, 3);
   num3 = num1 + num2;

   cout << num1 << " + " << num2 << " = " << num3 << endl;
   cout << num3 << " + " << num4 << " = ";
   num3 += num4;
   cout << num3 << endl;
   return;
}






