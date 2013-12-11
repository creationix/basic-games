// Include file to use complex numbers in programs.
// By Tim Cawell
// E-Mail at cashorde@Juno.com
// for questions about programming

#define TRUE 1
#define FALSE 0

class complex
{
protected:
   double x;
   double y;
public:
   complex() { x = 0; y = 0; }
   complex(double X, double Y) { x = X; y = Y; }
   complex(const complex& c) { x = c.x; y = c.y; }
   ~complex();
   void assign(double X, double Y) { x = X; y = Y; }
   double real() { return x; }
   double imag() { return y; }
   friend int operator ==(const complex& c1, const complex& c2);
   friend int operator !=(const complex& c1, const complex& c2);
   complex& operator =(const complex& c);
   complex& operator +=(const complex& c);
   complex& operator -=(const complex& c);
   complex& operator *=(const complex& c);
   complex& operator /=(const complex& c);
   friend complex operator +(const complex& c1, const complex& c2);
   friend complex operator -(const complex& c1, const complex& c2);
   friend complex operator *(const complex& c1, const complex& c2);
   friend complex operator /(const complex& c1, const complex& c2);
   friend ostresm operator <<(const ostream& os, const complex& c);
};

int complex::operator !=(const complex& c1, const complex& c2);
{
   if ((c1.x!=c2.x) || (c1.y!=c2.y))
      return TRUE;
   else
      return FALSE;
}

int complex::operator ==(const complex& c1, const complex& c2);
{
   if ((c1.x==c2.x) && (c1.y==c2.y))
      return TRUE;
   else
      return FALSE;
}
complex& complex::operator =(const complex& c)
{
   x = (c.x);
   y = (c.y);
   return *this;
}

complex& complex::operator +=(const complex& c)
{
   x += (c.x);
   y += (c.y);
   return *this;
}

complex& complex::operator -=(const complex& c)
{
   x -= c.x;
   y -= c.y;
   return *this;
}

complex& complex::operator *=(const complex& c)
{
   double X, Y;
   X = (x*c.x - y*c.y);
   Y = (x*c.y + y*c.x);
   x = X;
   y = Y;
   return *this;
}

complex& complex::operator /=(const complex& c)
{
   double X, Y;
   X = ((x*c.x + y*c.y)/(c.x*c.x + c.y*c.y));
   Y = ((-x*c.y + y*c.x)/(c.x*c.x + c.y*c.y));
   x = X;
   y = Y;
   return *this;
}

complex complex::operator +(const complex& c1, const complex& c2)
{
   complex result;
   result.x = c1.x + c2.x;
   result.y = c1.y + c2.y;
   return result;
}

complex complex::operator -(const complex& c1, const complex& c2)
{
   complex result;
   result.x = c1.x - c2.x;
   result.y = c1.y - c2.y;
   return result;
}

complex complex::operator *(const complex& c1, const complex& c2)
{
   complex result;
   result.x = ((c1.x*c2.x)-(c1.y*c2.y));
   result.y = ((c1.x*c2.y)+(c1.y*c2.x));
   return result;
}

complex complex::operator /(const complex& c1, const complex& c2)
{
   complex result;
   result.x = ((c1.x*c2.x)+(c1.y*c2.y))/(c2.x*c2.x+c2.y*c2.y);
   result.y = (-(c1.x*c2.y)+(c1.y*c2.x))/(c2.x*c2.x+c2.y*c2.y);
   return result;
}

ostream complex::operator <<(const ostream& os, const complex& c)
{
   if (c.y != 0)
      os << "(";
   os << c.x;
   if (c.y != 0)
      os << " + " << c.y << "i)";
   return os;
}



