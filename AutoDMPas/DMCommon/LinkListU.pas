unit LinkListU;
interface
uses Classes;
type
  TLink=class;

  TLink=class
  private
    Fbody    :pointer;
    Fnext    :TLink;
    Fprevious:TLink;
  public
    property body     : pointer read Fbody write Fbody;
    property next     : TLink read Fnext write Fnext;
    property previous : TLink read Fprevious write Fprevious;
    constructor Create;
    destructor Destroy; override;
  end;

  TLinkList=class
  private
    Ffirst:TLink;
    Flast:TLink;
   public
    property first : TLink read Ffirst write Ffirst;
    property last  : TLink read Flast write Flast;
    constructor Create;
    destructor Destroy; override;
    procedure Add(Abody:pointer);
    procedure Delete(Abody:pointer);
    procedure Insert_after(Aprevious:TLink; Abody:pointer);
    procedure Cut_after(ALink:TLink);
    function TheLink(Abody:pointer):TLink;
  end;

implementation

{TLink}

    constructor TLink.Create;
    begin
      inherited Create;
      Fbody:=nil;
      Fnext:=nil;
      Fprevious:=nil;
    end;

    destructor TLink.Destroy;
    begin
      if Fprevious<>nil then
        Fprevious.next:=Fnext;
      if Fnext<>nil then
        Fnext.previous:=Fprevious;
      inherited Destroy;
    end;

{TLinkList}

    constructor TLinkList.Create;
    begin
      inherited Create;
      Ffirst:=nil;
      Flast:=nil;
    end;

    destructor TLinkList.Destroy;
    begin
      if first<>nil then begin
        Cut_after(first);
        first.Free;
      end;
      inherited Destroy;
    end;

    procedure TLinkList.Add(Abody:pointer);
    var new_Link:TLink;
    begin
      new_Link:=TLink.Create;
      new_Link.body:=Abody;
      if Ffirst=nil then
        Ffirst:=new_Link
      else
        Flast.next:=new_Link;
      new_Link.previous:=Flast;
      Flast:=new_Link;
    end;

    procedure TLinkList.Insert_after(Aprevious:TLink; Abody:pointer);
    var new_Link:TLink;
    begin
      new_Link:=TLink.Create;
      new_Link.body:=Abody;
      new_Link.previous:=Aprevious;
      if Aprevious<> nil then begin
        new_Link.next:=Aprevious.next;
        Aprevious.next:=new_Link;
      end else begin
        new_Link.next:=Ffirst;
        Ffirst:=new_Link;
      end;
      if Aprevious=Flast then
        Flast:=new_Link;
    end;

    procedure TLinkList.Delete(Abody:pointer);
    var ALink:TLink;
    begin
      ALink:=TheLink(Abody);
      if ALink<>nil then begin
        if ALink=Ffirst then
          Ffirst:=ALink.next;
        if ALink=Flast then
          Flast:=ALink.previous;
        ALink.Free
      end
    end;

    procedure TLinkList.Cut_after(ALink:TLink);
    begin
      if ALink<>nil then
        ALink.next.Free;
      Flast:=ALink;
    end;

    function TLinkList.TheLink(Abody:pointer):TLink;
    var Link: TLink;
    begin
      Link:=Ffirst;
      while (Link<>nil) and (Link.body<>Abody) do
        Link:=Link.next;
      Result:=Link;
    end;

end.
