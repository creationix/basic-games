// Tim Caswell
// 10 - 4 - 98

#include <iostream.h>
#define MinSize 3

class Array
{
   private:
      double *dataPtr;
      int size;
   public:
      Array(int Size = MinSize);
      Array(const Array& a);          // copy Constructor
      ~Array() { delete [] dataPtr; }
      int getSize() { return size; }
      double recall(int index)
         { if (index > 0 && index < size) dataPtr[index] = x; }
      void store(double x, int index)
         { if (index > 0 && index < size) return dataPtr[index]; }
};

Array::Array(int Size)         // Creates a dynamic array of doubles
{
   size = (Size < MinSize) ? MinSize : Size;
   dataPtr = new double[size];
}

Array::Array(const Array& a)  // Does a deep copy for the copy constructor
{
   size = a.size;
   dataPtr = new double[size];   // creates an identical array as Array a
   for (int i = 0; i < size; i++)
      dataPtr[i] = a.dataPtr[i];
}

void main()
{
   Array Arr(10);
   double x;
   for (int i = 0; a < Arr.getSize(); i++)
   {
      x = double(i);
      x = x * x - 5 * x + 10;
      Arr.store(x, i);
   }
   cout << "Array Arr has the following values:\n\n";
   for (int i = 0; a < Arr.getSize(); i++)
      cout << "Arr[" << i << "] = " << Arr.recall(i) << endl;
   return;
}

























