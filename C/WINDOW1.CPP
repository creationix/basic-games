#include <owl\applicat.h>
#include <owl\dc.h>
#include <owl\framewin.h>
#include <owl\window.h>
#include <owl\window.rh
#include <stdio.h>

const MAX_LINES = 30;

class TMyWindow : public TWindow
{
    public:
        TMyWindow(TWindow* parent = 0);

    protected:
        bool CanClose();

        void CmExit();
        
        void EvLButtonDown(UINT, TPoint &);
        
        void Paint(TDC &, bool, TRect &);

        DECLARE_RESPONSE_TABLE(TMyWindow);
};

DEFINE_RESPONSE_TABLE1(TMyWindow, TWindow)
    EV_WM_LBUTTONDOWN,
    EV_COMMAND(CM_EXIT, CmExit),
END_RESPONSE_TABLE;

class TMyApp : public TApplication
{
public:
    TMyApp() : TApplication() {}
    void InitMainWindow()
        {
        SetMainWindow(new TFrameWindow( 0,
                    "A Simple Read-Only Text Window",
                    new TMyWindow ));
        GetMainWindow()->AssignMenu("EXITMENU");
        }
};

TMyWindow::TMyWindow(TWindow* parent)
{
    Init(parent, 0, 0);
}

bool TMyWindow::CanClose()
{
    return IDYES == MessageBox("Want to close this application?",
                               "Query",
                               MB_YESNO | MB_ICONQUESTION );
}

void TMyWindow::CmExit()
{
    SendMessage(WM_CLOSE);
}

void TMyWindow::EvLButtonDown(UINT, TPoint &)
{
    MessageBox( "You clicked the left button!",
                "Mouse Click Event", MB_OK );
}

void TMyWindow::Paint(TD& dc, bool /*erase*/, TRect& /*rect*/)
{
    char s[81];
    bool ok = true;
    int y = 0;

    for (int i = 0; i < MAX_LINES && ok; ++i)
        {
        sprintf(s, "This is line number %d", i);
        ok = dc.TextOut(0, y, s);
        y += dc.GetTextExtent(s, lstrlen(s)).cy;
        }
}

int OwlMain(int, char *[])
{
    return TMyApp().Run();
}


