unit DM_Messages;

interface
uses
  Messages;

const
{ Window Messages }
  WM_User=Messages.WM_User;
  WM_Command=Messages.WM_Command;
  WM_SetText=Messages.WM_SetText;
  WM_LButtonDown=Messages.WM_LButtonDown;
  WM_LButtonUp=Messages.WM_LButtonUp;
  WM_LBUTTONDBLCLK=Messages.WM_LBUTTONDBLCLK;
  WM_KeyDown=Messages.WM_KeyDown;

{ Combo Box messages }
  CB_GETDROPPEDCONTROLRECT = Messages.CB_GETDROPPEDCONTROLRECT;
  CB_GETITEMHEIGHT = Messages.CB_GETITEMHEIGHT;
  CB_GETTOPINDEX = Messages.CB_GETTOPINDEX;
  CB_SETTOPINDEX = Messages.CB_SETTOPINDEX;
  CB_SHOWDROPDOWN = Messages.CB_SHOWDROPDOWN;

{ Edit Control Messages }
  EM_GETSEL = Messages.EM_GETSEL;
  EM_SETSEL = Messages.EM_SETSEL;
  EM_UNDO = Messages.EM_UNDO;

type
  TMessage=Messages.TMessage;

implementation

end.
