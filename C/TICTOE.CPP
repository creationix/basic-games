// Tim Caswell
// 11-2-98
// Tic-Tac-Toe game using OWL for Win 3.1

#include <owl\framewin.h>
#include <owl\applicat.h>
#include <owl\dc.h>
#include <mem.h>

#pragma hdrstop

#include "real.rh"

class BaseWindow : public TWindow
{
   protected:
      void EvChar(UINT key, UINT repeatcount, UINT flags);
      void Paint(TD& dc, BOOL TRect&);
      void EvSize(UINT sizetype, TSize& size);

      // Menu choice to show about box
      void CmAbout() { MessageBox("Tic-Tac-Toe by Tim Caswell", "About"); }

      void CmNewGame();
      void CmHelp();

      // Menu Choice to end the program
      void CmExitGame() { PostQuitMessage(0); }

   public:
      BaseWindow(TWinow *parent = 0);
      ~BaseWindow() { ; }
      DECLARE_RESPONSE_TABLE(BaseWindow);  // Declare the response table
};

DEFINE_RESPONSE_TABLE1(BaseWindow, TWindow)
   EV_WM_CHAR,
   EV_WM_SIZE,
   EV_COMMAND( CM_ABOUT,   CmAbout),
   EV_COMMAND( CM_NEWGAME, CmNewGame),
   EV_COMMAND( CM_HELP,    CmHelp),
   EV_COMMAND( CM_EXITGAME,CmExitGame),
END_RESPONSE_TABLE;

class MyApp : public TApplication
{
   public:
      MyApp() : TApplication() {}
      void InitMainWindow();
};

BaseWindow::BaseWindow(TWindow *parent)
{
   // insert code for basewindow here
}

void BaseWindow::CmNewGame()
{
   // insert New Game code here
   Invalidate();
}

void BaseWindow::EvSize(UINT sizeType, TSize& size)
{
   if (sizeType == SIZE_MINIMIZED) // If shrunk to Icon
      isMinimized = TRUE;
   else
      {
      WindowSize = size;
      inMinimized = FALSE;
      }
}

// called when time to update the display
void BaseWindow::Paint(TDC& dc, BOOL, TRect&)
{
   // insert data here

   if (isMinimized)
      return;
   // insert paint code here
}

// called when normal key is pressed
void BaseWindow::EvChar(UINT key, UINT repeatCount, UINT)
{
   // insert code here
}

void MyApp::InitMainWindow()
{
   SetMainWindow(new TFrameWindow(0, "Tic-Tac-Toe", new BaseWindow()));
   GetMainWindow()->AssignMenu("MENU_1");
}

int OwlMain(int, char **)
{
   return MyApp().Run();
}



