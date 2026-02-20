unit InternalTimer;
//© 2006 Сергей Рощин (Специально для королевства Дэльфи)
//В этом модуле содержится таймер использующий
//функцию обратного вызова а не сообщение окна
//Данный модyль не предназначен для коммерческого использования.
//По поводу возможного сотрудничества Вы можете обратиться по
//элестронной почте roschinspb@mail.ru
//http://www.delphikingdom.com/asp/users.asp?ID=1271
//http://www.roschinspb.boom.ru
interface
uses Windows,Messages,SysUtils,Classes;

type
  //Этот таймер не создает своего окна для получения сообщений
  TInternalTimer=class (TComponent)
  private
    fInstanceProc:pointer;
    fHandle:THandle;
    fEvent:TNotifyEvent;
    fOne:boolean;
    fFirst:boolean;
    fExecuted:boolean;
    procedure TimerProc(var M: TMessage);
  public
    destructor Destroy; override;
    procedure ExecuteDelay(const Delay:integer; const Event:TNotifyEvent);
    procedure ExecuteInterval(const Interval:integer; const Event:TNotifyEvent);
    function Stop:boolean;                //Останавливает таймер. Если хот раз выполнилнилось событие, то возвращается True
    property First:boolean read fFirst;   //Этот флаг, сигнализирует о том, что событие произошло в первый раз
    property Handle:THandle read fHandle;
    property One:boolean read fOne;       //Этот флаг сигнализирует о том, что событие происходит только один раз
  end;

implementation
{$IFDEF VER130}
uses Forms;
{$ENDIF}

{ TInternalTimer }

destructor TInternalTimer.Destroy;
begin
  Stop;
  inherited;
end;

procedure TInternalTimer.ExecuteDelay(const Delay: integer; const Event: TNotifyEvent);
begin
  Stop;
  fExecuted:=false;
  If (Delay>0) and (@Event<>nil) then begin
   fOne:=true;
   fEvent:=Event;
   fInstanceProc:=MakeObjectInstance(TimerProc);
   fFirst:=true;
   fHandle:=SetTimer(0,Cardinal(Self),Delay,fInstanceProc);
  end else begin
   fOne:=false;
   fEvent:=nil;
   fFirst:=false;
  end;
end;

procedure TInternalTimer.ExecuteInterval(const Interval: integer; const Event: TNotifyEvent);
begin
  Stop;
  fExecuted:=false;
  fOne:=false;
  If (Interval>0) and (@Event<>nil) then begin
   fEvent:=Event;
   fInstanceProc:=MakeObjectInstance(TimerProc);
   fFirst:=true;
   fHandle:=SetTimer(0,Cardinal(Self),Interval,fInstanceProc);
  end else begin
   fEvent:=nil;
   fFirst:=false;
  end;
end;

function TInternalTimer.Stop: boolean;
begin
  result:=false;
  If self=nil then exit;
  result:=fExecuted;
  if fHandle<>0 then begin
   if Windows.KillTimer(0,fHandle) then fHandle:=0
                                   else
     {$IFDEF VER130}
        RaiseLastWin32Error
     {$ELSE}
        RaiseLastOSError
     {$ENDIF}
  end;
  if fInstanceProc<>nil then begin
   FreeObjectInstance(fInstanceProc);
   fInstanceProc:=nil;
  end;
end;

procedure TInternalTimer.TimerProc(var M: TMessage);
begin
  If fOne then Stop;
  try
   If @fEvent<>nil then fEvent(self);
   If self<>nil then fExecuted:=true;
  finally
   If self<>nil then fFirst:=false;
  end;
end;

end.

