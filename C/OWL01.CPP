// Tim Caswell
// 10 - 5 - 98
// This program shows basic OWL programming

#include <owl\framewin.h>
#include <owl\applicat.h>
#include <owl\dc.h>
#include <mem.h>

#pragma hdrstop

#include "real.rh"

const int maxLines = 25;
const int maxWidth = 80;
const int maxData = maxLines * (maxWidth + 1);

class BaseWindow : public TWindow
{
   protected:
      int currentLine;          // Line being typed in now
      int lineLen[maxLines];    // length of each line
      char *linePtrs[maxLines]; // string for each line
      BOOL isMinimized;         // TRUE is the window is an icon
      TSize windowSize          // Structure with size in pixels

      void Evhar(UINT key, UINT repeatCount, UINT flags);
      void Paint(TDC& dc, BOOL, TRect&);
      void EvSize(UINT sizeType, TSize& size);

      void CmAbout();          // The about menu item
      void CmClear();          // The Clear menu item

      // Menu choice, end the program
      void CmFileExit() { PostQuitMessage(0); }

   public:
      BaseWindow(TWindow *parent = 0);
      ~BaseWindow() {}
      DECLARE_RESPONSE_TABLE(BaseWindow); // Says there will be a response
};                                        // table

DEFINE_RESPONSE_TABLE1(BaseWindow, TWindow)
   EV_WM_CHAR,
   EV_WM_SIZE,
   EV_COMMAND( CM_ABOUT,    CmAbout),
   EV_COMMAND( CM_FILEEXIT, CmFileExit),
   EV_COMMAND( CM_CLEAR,    Cmclear),
END_RESPONSE_TABLE;

class MyApp : public TApplication
{
   public:
      MyApp() : TApplication() {}

      void InitMainWindow();
};

BaseWindow::BaseWindow(TWindow *parent)
{
   int lineNum;

   Init(parent, 0, 0);
   linePtrs[0] = new char[maxData];  //Allocate Edit buffer
   lineLen[0] = currentLine = 0;

   // Apportion the buffer out to the line pointer array
   for (lineNum = 1; lineNum < maxLines ; ++lineNum)
   {
      linePtrs[lineNum] = linePtrs[lineNum - 1] + maxWidth;
      lineLen[lineNum] = 0;
   }
}

// Menu choice, display an about box, use a message box to do it
void BaseWindow::CmAbout()
{
   MessageBox("OWL10.cpp By Tim Caswell", "About this program");
}

// Menu choice, clear the display
void BaseWindow::Cmlear()
{
   for(int lineNum = 0; lineNum < maxLines; ++lineNum)
      lineLen[lineNum] = 0;      // Empty all lines

   currentLine = 0;              // move back to the top line
   Invalidate();                 // window is invalid, repaint
}

void BaseWindow::EvSize(UINT sizeType, TSize& size)
{
   if (sizeType == SIZE_MINIMIZED) // if shrunk to icon
      isMinimized = TRUE;
   else
   {
      windowSize = size;           // save window size
      isMinimized = FALSE;
   }
}

// called when time to update (paint) the screen
void BaseWindow::Paint(TDC& dc, BOOL, TRect&)
{
   int lineNum;         // line number to write to
   int yPos;            // vertical position on the screen
   int displayedLines   // number of linePtrs in this window
   TSize textSize;      // used to get hieght in pixels

   if (isMinimized)     // don't write to an icon
      return;

   // get char sizes so that the height is saved
   textSize = dc.GetTextExtent("W", 1);
   displayedLines = maxLines;

   for (lineNum = yPos = 0; lineNum < displayedLines; ++lineNum)
   {
      if (lineLen[lineNum] > 0) // if there is text on that line
         dc.TextOut(0, yPos, linePtrs[lineNum], lineLen[lineNum]);

      yPos += textSize.cy; //adjust screen line position
   }
}

// called when a normal key is pressed
void BaseWindow::EvChar(UINT key, UINT repeatcount, UINT)
{
   BOOL invalidDisplay = FALSE;
   BOOL eraseBackground = FALSE;

   while (repeatount--)
   {
      if((key >= ' ') && (key <= '~'))    //if a printable key
      {
         if (currentLine >= maxLines)     //if buffer is full
         {
            MessageBeep(-1);              //complain
            break;
         }
         else                             // else
         {                                // add char
            linePtrs[currentLine][lineLen[currentLine]] = (char)key;

            if (++lineLen[currentLine] >= maxWidth)
               ++currentLine;

            invalidDinplay = TRUE;
         }
      }
      else if (key == '\b')               //rubout or delete key
      {
         if(currentLine >= maxLines)
            break;
         else if (lineLen[currentLine == 0)
         {
            if  (currentLine > 0)
               --currentLine;
         }
         else
            --lineLen[currentLine];

         invalidDisplay = eraseBackground = TRUE;
      }
      else if (key == '\r')               // carrige return or enter
         ++currentLine;
      else
         MessageBeep(-1);
         MessageBox("That is an invalid Key!", "Stop!");
   }
   if (currentLine >= maxLines)
      currentLine = maxLines - 1;

   if (invalidDisplay)               // if buffer has changed
      Invalidate(eraseBackground);   // force windoe repaint
}

void MyApp::InitMainWindow()
{
   SetMainWindow(new TFrameWindow(0, "OWL01.CPP - a text editor", new BaseWindow()));
   getMainWindow()->AssignMenu("MENU_1");
}

int OwlMain(int, char **)
{
   return MyApp().run();
}
















































