unit RequisitionClass;

interface

uses
  SysUtils, IOUtils, Dialogs, Windows, ZipMstr19, XMLDoc, Utils, XMLIntf, Variants,
  AdvOutlookList, Classes, VirtualTrees, MyTypes, StdCtrls, AdvDateTimePicker,
  AdvControlDropDown, RzSpnEdt, Clients, AdvMultiColumnDropDown, IdHash, IdHTTP,
  IdHashMessageDigest, Controls, IdFTP, MyConst, ComObj, OutlookGroupedList, Exchange;

type
  Tovar = record
    Code        : integer;
    Count       : integer;
    Coast1      : Double;
    Coast2      : Double;
    Discount    : Double;
    Notes       : string;
    Shipped     : integer;

    Name        : string;

    Status      : boolean;
    //Count     : integer;
  end;

  TArTovar = Array of Tovar;

type
  Request = record
    UID         : String;
    DCreate     : TDateTime;
    DDelivery   : string;
    UNN         : string;
    Note        : string;

    Status      : integer;
    Discount    : Double;
    IDPoint     : integer;

    FullSum     : Double;

    TypeSal     : Integer;

    TovarsArray : Array of Tovar;

    function Add(xUID           : String;
                  xDCreate      : TDateTime;
                  xDDelivery    : string;
                  xUNN          : string;
                  xStatus       : integer;
                  xNote         : string;
                  xDiscount     : Double;
                  xIDPoint      : integer;
                  xTypeSal      : Integer) : integer;

    function AddTovar(xCode     : integer;
                      xCount    : integer;
                      xCoast1   : Double;
                      xCoast2   : Double;
                      xDiscount : Double;
                      xNotes    : string;
                      xShipped  : integer) : integer;

    function DeleteTovar(indx   : integer) : integer;
    function GetFullSum : Double;
  end;

  TArReq = Array of Request;

////////////////////////////////////////////////////////////////////////////////
///
///  TRequests
///
////////////////////////////////////////////////////////////////////////////////
type
  TRLSelEvent = procedure(Status : integer) of object;

  TRequests = class(TObject)

  Constructor Create(FileName           : string;
                      xLisrReq          : TAdvOutlookList;
                      xClList           : ClientSR;
                      xNotesM           : TMemo;
                      xDateTimePicker   : TAdvDateTimePicker;
                      xDiscountSpinEdit : TRzSpinEdit;
                      xTovarsList       : TAdvOutlookList;
                      xTypeDropDown     : TAdvMultiColumnDropDown;
                      xidHTTPClient     : TIdHttp);

  private
    //XMLDocument         : TXMLDocument;
    FileNameXML         : string;
    RequestsArray       : Array of Request;
    TpSal               : Array of TTypeSal;
    reqolg              : TOutlookGroup;
    reqsl               : TStrings;

    FOnRlSelect         : TRLSelEvent;

    function InAddRequest(CrReq : Request; LoadL : bool) : integer;

    procedure ClSelect(N : integer; Name : String; UNN : String);
    procedure PointSelect(N : integer; PID : integer);
    procedure NotesMSelect(Sender : TObject);
    procedure DateTimePickerSelect(Sender : TObject);
    procedure DiscountSpinEditSelect(Sender : TObject);
    procedure TovarsListKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TovSelect(sender : TObject);
    procedure ReqSelect(sender : TObject);
    procedure LisrReqKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    function  CreateReqXml(Req : Request; RootStock : IXMLNode) : bool;
    procedure TypeDropDownSelect(Sender: TObject);
    procedure LisrReqKeyPress(Sender: TObject; var Key: Char);
    function GetAtmReqFromXML(RtChildNode : IXMLNode; var TmpReq : Request) : BOOL;
    procedure ListReqItemClick(Sender: TObject; Item: POGLItem; Column: Integer);
    function GetListIndx(AdvOl : TAdvOutlookList; Indx : integer) : integer;
  public
    SelectedItem              : integer;
    TovSelected               : integer;
    LisrReq                   : TAdvOutlookList;
    TovarsList                : TAdvOutlookList;
    VST                       : TVirtualStringTree;
    NotesM                    : TMemo;
    DateTimePicker            : TAdvDateTimePicker;
    TypeDropDown              : TAdvMultiColumnDropDown;
    DiscountSpinEdit          : TRzSpinEdit;
    ClList                    : ClientSR;
    ClientsDropDown           : TAdvMultiColumnDropDown;
    PointDropDown             : TAdvMultiColumnDropDown;
    Settings                  : TProgrammSettings;
    idHTTPClient              : TIdHttp;

    function NewRequest : integer;
    function SaveXML : bool;
    function LoadRequests : bool;
    function LoadTypeSal(FileNameXMLSaleT : string) : bool;
    function FillTovars(indx : integer) : bool;
    function GetReqStatus(indx : integer) : integer;
    function GetTovarName(Code : integer) : string;
    function GetTovar(Code : integer) : Tovar;
    function AddTovarInSelReq(Code  : integer;
                              Count : integer;
                              Cost1 : Double;
                              Cost2 : Double;
                              Note  : String) : bool;

    property OnRlSelect : TRLSelEvent read FOnRlSelect write FOnRlSelect;
    function DeleteReq(indx : integer) : integer;
    function SendReq(indx : integer) : bool;
    function SendFile(PathFileName : string; DestFileName: string): bool;
    function GetTypeSale(Id : integer):string;
    function SaveAsExcelFile(ASheetName, AFileName: string): Boolean;
    function LoadFromExcelFile(ASheetName, AFileName: string): Boolean;
    procedure CheckAndDeleteTv;
    procedure CheckAndEditTv(Count : Integer);
    function ParseReq(XMLFile : TStream; var Req : Request) : BOOL;
    function RecFound(Id : String) : Bool;
    function UpdateReq(Req : Request) : BOOL;
    function GetSelTv : Tovar;
    function CloneReq(indx : integer; Sender: TObject) : bool;
  end;

implementation

Constructor TRequests.Create(FileName           : string;
                              xLisrReq          : TAdvOutlookList;
                              xClList           : ClientSR;
                              xNotesM           : TMemo;
                              xDateTimePicker   : TAdvDateTimePicker;
                              xDiscountSpinEdit : TRzSpinEdit;
                              xTovarsList       : TAdvOutlookList;
                              xTypeDropDown     : TAdvMultiColumnDropDown;
                              xidHTTPClient     : TIdHttp);
begin
  SelectedItem:=-1;
  FileNameXML:=FileName;

  LisrReq:=xLisrReq;
  LisrReq.ClearGroups;
  LisrReq.OnSelectionChange:=ReqSelect;
  LisrReq.OnKeyUp       :=LisrReqKeyUp;
  LisrReq.OnKeyPress    :=LisrReqKeyPress;
  LisrReq.OnItemClick   :=ListReqItemClick;

  reqolg := LisrReq.AddGroup('');

  ClList                := xClList;
  ClList.OnClSelect     := ClSelect;
  ClList.OnPointSelect  := PointSelect;

  NotesM:=xNotesM;
  NotesM.OnChange:=NotesMSelect;

  DateTimePicker:=xDateTimePicker;
  DateTimePicker.OnChange:=DateTimePickerSelect;

  DiscountSpinEdit:=xDiscountSpinEdit;
  DiscountSpinEdit.OnChange:=DiscountSpinEditSelect;

  TovarsList:=xTovarsList;
  TovarsList.AddGroup('');
  TovarsList.OnSelectionChange:=TovSelect;
  TovarsList.OnKeyUp:=TovarsListKeyUp;

  TypeDropDown:=xTypeDropDown;
  TypeDropDown.OnSelect:=TypeDropDownSelect;

  idHTTPClient:=xidHTTPClient;
end;

function TRequests.RecFound(Id : String) : Bool;
var
  i : Integer;
begin
  Result := False;

  for i := 0 to Length(RequestsArray) - 1 do
    begin
      if RequestsArray[i].UID = Id then
          begin
            Result := True;
            Break;
          end;
    end;
end;

function TRequests.UpdateReq(Req : Request) : BOOL;
var
  i : Integer;
begin
  Result := False;

  for i := 0 to Length(RequestsArray) - 1 do
    begin
      if RequestsArray[i].UID = Req.UID then
          begin
            RequestsArray[i]:=Req;
            Break;
          end;
    end;
  SaveXML;

  LoadRequests;
  ReqSelect(Self);

  Result:=True;
end;

function TRequests.ParseReq(XMLFile : TStream; var Req : Request) : BOOL;
var
  XMLDocument   : IXMLDocument;
  i, k          : integer;
  RtChildNode   : IXMLNode;
  //ItChildNode   : IXMLNode;
begin
  Result:=False;

  try
    XMLDocument:=TXMLDocument.Create(nil);

    XMLDocument.Active := true;

    XMLDocument.Encoding  :='UTF-8';

    XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

    XMLDocument.LoadFromStream(XMLFile);

     //ShowMessage(XMLDocument.XML.Text);

    for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Requests' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Request' then
                                begin
                                  RtChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];
                                    if GetAtmReqFromXML(RtChildNode, Req) then
                                        begin
                                          Result:=True;
                                        end;
                                end;
                          end;
                      end;
                  end;
            end;
  except on E: Exception do
    begin
      //MessageDlg('Ошибка загрузки файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
      Result:=False;
    end;
  end;
end;

function RefToCell(ARow, ACol: Integer): string;
begin
  Result := Chr(Ord('A') + ACol - 1) + IntToStr(ARow);
end;

function TRequests.SaveAsExcelFile(ASheetName, AFileName: string): Boolean;
const
  xlWBATWorksheet = -4167;
var
  //Row, Col            : Integer;
  //GridPrevFile        : string;
  XLApp, Sheet, Data  : OLEVariant;
  i, cn, Mr           : Integer;

  ci                  : ClInfo;

  Tmp                 : string;
begin
  // Prepare Data
  Data := VarArrayCreate([1, 100, 1, 7], varVariant);
  //for i := 0 to 5 - 1 do
    //for j := 0 to 100 - 1 do
      //Data[j + 1, i + 1] := Random(100);//AGrid.Cells[i, j];

  DateTimeToString(Tmp, 'dd.mm.yyyy', RequestsArray[SelectedItem].DCreate);

  Data[2, 2]:='Дата создания : ' + Tmp;
  Data[3, 2]:='Дата доставки : ' + RequestsArray[SelectedItem].DDelivery;
  Data[5, 2]:='УНН : ' + RequestsArray[SelectedItem].UNN;
  ci:=ClList.GetNameClientFromUNN(RequestsArray[SelectedItem].UNN, RequestsArray[SelectedItem].IDPoint);
  Data[6, 2]:='Клиент : ' + ci.Name;
  Data[7, 2]:='Скидка : ' + FloatToStr(RequestsArray[SelectedItem].Discount);

  Data[9, 2]:='Агент : ' + Settings.Name + ' ' + Settings.LName;

  Mr:=11;

  Data[11, 2]:='№';
  Data[11, 3]:='Код товара';
  Data[11, 4]:='Товар';
  Data[11, 5]:='Кол-во';
  Data[11, 6]:='Цена';
  Data[11, 7]:='Сумма';

  inc(Mr);

  cn:=Length(RequestsArray[SelectedItem].TovarsArray);

  for i := 0 to cn - 1 do
    begin
      Data[Mr + i, 2]:=i + 1;
      Data[Mr + i, 3]:=RequestsArray[SelectedItem].TovarsArray[i].Code;
      //Data[11 + i, 3].WrapText:=True;
      Data[Mr + i, 4]:=RequestsArray[SelectedItem].TovarsArray[i].Name;
      Data[Mr + i, 5]:=RequestsArray[SelectedItem].TovarsArray[i].Count;
      Data[Mr + i, 6]:=RequestsArray[SelectedItem].TovarsArray[i].Coast2;
      Data[Mr + i, 7]:='=' + RefToCell(Mr + i, 5) + '*' + RefToCell(Mr + i, 6) ;
    end;

  Result := False;
  XLApp := CreateOleObject('Excel.Application');
  try
    XLApp.Visible := True;

    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := ASheetName;

    // Fill up the sheet
    Sheet.Range[RefToCell(1, 1), RefToCell(100, 7)].Value := Data;

      //Sheet.range['a2', 'a2'].font.size := 20;
      //Sheet.range['a2', 'a2'].font.fontstyle := 'bold';
      //Sheet.range['a2', 'a2'].font.color := rgb(223, 123, 123);
      //Sheet.range['a2', 'a2'].font.name := 'arial';

      //Sheet.range[RefToCell(12, 4), RefToCell(12 + Length(RequestsArray[SelectedItem].TovarsArray) - 1, 4)].WrapText:=True;
      Sheet.range[RefToCell(Mr, 2), RefToCell(Mr + cn - 1, 7)].Borders.LineStyle:=1;

      sheet.Columns[1].ColumnWidth:=1;
      sheet.Columns[2].ColumnWidth:=5;
      sheet.Columns[3].ColumnWidth:=10;
      sheet.Columns[4].ColumnWidth:=35;
      sheet.Columns[5].ColumnWidth:=10;
      sheet.Columns[6].ColumnWidth:=10;

      sheet.cells(Mr + cn, 7):= '=SUM(' + RefToCell(Mr, 7) + ':' + RefToCell(Mr + cn - 1, 7) + ')';

      //Sheet.range['b2', 'c6'].interior.color := rgb(223, 123, 123);
      //Sheet.range['b1, b10'].interior.color := rgb(100, 100, 200);

    // Save Excel Worksheet
    try
      //XLApp.Workbooks[1].SaveAs(AFileName);

      Result := True;
    except
      // Error ?
    end;
  finally
    // Quit Excel
    if not VarIsEmpty(XLApp) then
    begin
      //XLApp.DisplayAlerts := False;
      //XLApp.Quit;

      XLAPP := Unassigned;
      Sheet := Unassigned;
    end;
  end;
end;

function TRequests.LoadFromExcelFile(ASheetName, AFileName: string): Boolean;
var
  Excel   : variant;
  i       : word;
  S       : string;
  TmpReqN : integer;
  cd      : Integer;
  TmpTv   : Tovar;
begin
  Result:=False;

  Excel := CreateOleObject('Excel.Application');
  Excel.Workbooks.Open(AFileName);
  Excel.Visible:=False;

  TmpReqN:= NewRequest();
  i:=1;

  repeat
  //for i := 1 to 300 do
    //begin
      S := Excel.Sheets[1].Cells[i, 2].Text;

      if S <> '' then
        begin
          cd:=StrToIntDef(S, 0);

          if cd > 0 then
            begin
              TmpTv:=GetTovar(cd);

              if TmpTv.Status then
                begin
                  RequestsArray[TmpReqN].AddTovar(TmpTv.Code, StrToIntDef(Excel.Sheets[1].Cells[i, 3].Text, 0), TmpTv.Coast1, TmpTv.Coast2, TmpTv.Discount, TmpTv.Notes, TmpTv.Shipped);
                  RequestsArray[TmpReqN].FullSum:=RequestsArray[TmpReqN].GetFullSum;
                end;
            end;
        end;
    //end;

    Inc(i);

  until S = '';

  LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[3]:=FloatToStr(RequestsArray[SelectedItem].FullSum);
  LisrReq.Repaint;

  SaveXML;
  FillTovars(SelectedItem);

  if not VarIsEmpty(Excel) then
    begin
      //XLApp.DisplayAlerts := False;
      Excel.Quit;

      Excel := Unassigned;
      //Sheet := Unassigned;
    end;

  ShowMessage('Импорт успешно завершен');

  Result:=True;
end;

procedure TRequests.TovarsListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then  CheckAndDeleteTv;
end;

procedure TRequests.CheckAndDeleteTv;
begin
  if RequestsArray[SelectedItem].Status = 0 then
      begin
        if (TovarsList.SelectedCount > 0) then
            begin
              if RequestsArray[SelectedItem].DeleteTovar(TovSelected) = 1 then
                  begin
                    RequestsArray[SelectedItem].FullSum:=RequestsArray[SelectedItem].GetFullSum;

                    LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[3]:=FloatToStr(RequestsArray[SelectedItem].FullSum);
                    LisrReq.Repaint;

                    SaveXML;
                    FillTovars(SelectedItem);

                    TovarsList.Sort;
                  end;
            end;
      end;
end;

procedure TRequests.CheckAndEditTv(Count : Integer);
begin
  if RequestsArray[SelectedItem].Status = 0 then
      begin
        if (TovarsList.SelectedCount > 0) then
            begin
              RequestsArray[SelectedItem].TovarsArray[TovSelected].Count:= Count;
              RequestsArray[SelectedItem].FullSum:=RequestsArray[SelectedItem].GetFullSum;

              LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[3]:=FloatToStr(RequestsArray[SelectedItem].FullSum);
              LisrReq.Repaint;

              SaveXML;

              //ReqSelect(Self);
              FillTovars(SelectedItem);

              TovarsList.Sort;

              {if RequestsArray[SelectedItem].DeleteTovar(TovSelected) = 1 then
                  begin
                    RequestsArray[SelectedItem].FullSum:=RequestsArray[SelectedItem].GetFullSum;

                    LisrReq.Groups[0].ChildItem[SelectedItem].Strings[2]:=FloatToStr(RequestsArray[SelectedItem].FullSum);
                    LisrReq.Repaint;

                    SaveXML;
                    FillTovars(SelectedItem);
                  end;}
            end;
      end;
end;

function TRequests.GetSelTv : Tovar;
var
  Temp: Tovar;
begin
  Temp.Code:= -1;
  Result:=Temp;

  if RequestsArray[SelectedItem].Status = 0 then
      begin
        if (TovarsList.SelectedCount > 0) then
            begin
              Result:=RequestsArray[SelectedItem].TovarsArray[TovSelected];
            end;
      end;
end;

procedure TRequests.LisrReqKeyPress(Sender: TObject; var Key: Char);
begin
  if (Ord(Key) = 13) then
      if (LisrReq.SelectedCount > 0) then
          begin
            SendReq(SelectedItem);
          end;
end;

procedure TRequests.LisrReqKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if(Key = VK_DELETE) and (LisrReq.SelectedCount > 0) then
      begin
        DeleteReq(SelectedItem);
      end;
end;

procedure TRequests.ListReqItemClick(Sender: TObject; Item: POGLItem;
  Column: Integer);
begin
  if RequestsArray[SelectedItem].Status = 0 then
      begin
         if Column = 6 then
            begin
              SendReq(SelectedItem);
            end;
      end;

      if Column = 7 then
        begin
          DeleteReq(SelectedItem);
        end;
end;

procedure TRequests.TypeDropDownSelect(Sender: TObject);
begin
  if not TypeDropDown.ItemIndex > -1 then exit;

  if RequestsArray[SelectedItem].TypeSal <> TpSal[TypeDropDown.ItemIndex].ID then
    begin
      RequestsArray[SelectedItem].TypeSal:= TpSal[TypeDropDown.ItemIndex].ID;
      SaveXML;
    end;
end;

procedure TRequests.ClSelect(N : integer; Name : String; UNN : String);
var
  i : integer;
begin
  if RequestsArray[SelectedItem].UNN <> UNN then
    begin
      RequestsArray[SelectedItem].UNN:=UNN;

      for i := 0 to LisrReq.Groups[0].ChildCount - 1 do
        begin
          if integer(LisrReq.Groups[0].ChildOGLItem[i].ItemObject) = SelectedItem then
              begin
                LisrReq.Groups[0].ChildItem[i].Strings[2]:=Name;
                LisrReq.Invalidate;
              end;
        end;

      SaveXML;
    end;
end;

procedure TRequests.PointSelect(N : integer; PID : integer);
begin
  if RequestsArray[SelectedItem].IDPoint <> PID then
    begin
      RequestsArray[SelectedItem].IDPoint:=PID;
      SaveXML;
    end;
end;

procedure TRequests.TovSelect(sender : TObject);
begin
  if (TovarsList.Groups[0].ChildCount > 0) and (TovarsList.SelectedCount > 0) then
      TovSelected:=integer(TovarsList.FirstSelectedItem.ItemObject)
    else
      TovSelected:=-1;
end;

procedure TRequests.ReqSelect(sender : TObject);
begin
  if (LisrReq.Groups[0].ChildCount > 0) and (LisrReq.SelectedCount > 0) then
      begin
        SelectedItem:=integer(LisrReq.FirstSelectedItem.ItemObject);
        FillTovars(SelectedItem);
        if Assigned(OnRlSelect) then
        OnRlSelect(RequestsArray[SelectedItem].Status);
      end
    else
      begin
        SelectedItem:= -1;
        TovarsList.ClearGroups;
      end;
end;

function TRequests.GetListIndx(AdvOl : TAdvOutlookList; Indx : integer) : integer;
var
  i : Integer;
  d : Integer;
begin
  Result:=-1;

  for i := 0 to AdvOl.Groups[0].ChildCount - 1 do
    begin
      d:= integer(AdvOl.Groups[0].ChildOGLItem[i].ItemObject);

      if Indx=d then
          begin
            Result:=i;
            Break;
          end;
    end;
end;

procedure TRequests.NotesMSelect(Sender : TObject);
begin
  if RequestsArray[SelectedItem].Note <> NotesM.Text then
    begin
      RequestsArray[SelectedItem].Note:=NotesM.Text;
      SaveXML;
    end;
end;

procedure TRequests.DateTimePickerSelect(Sender : TObject);
begin
  if RequestsArray[SelectedItem].DDelivery <> DateToStr(DateTimePicker.Date) then
    begin
      RequestsArray[SelectedItem].DDelivery:=DateToStr(DateTimePicker.Date);
      SaveXML;
    end;
end;

procedure TRequests.DiscountSpinEditSelect(Sender : TObject);
begin
  if ABS(RequestsArray[SelectedItem].Discount - DiscountSpinEdit.Value) > 0.0001 then
    begin
      RequestsArray[SelectedItem].Discount:=DiscountSpinEdit.Value;
      SaveXML;
    end;
end;

function TRequests.NewRequest : integer;
var
  md5indy               : TIdHashMessageDigest;
  HEXhash, Base         : string;

  MyTimeDate            : string;

  TmpUnn                : string;

  TmpReq                : Request;
begin
  DateTimeToString(MyTimeDate, 'hh:mm:ss.zzz - dddd d of mmmm yyyy', Now);

  Base                  :=Settings.ID + MyTimeDate;
  md5indy               :=TIdHashMessageDigest5.Create;
  HEXhash               :=md5indy.HashStringAsHex(Base);

  DateTimeToString(MyTimeDate, 'dd.mm.yyyy', Now);

  if ClientsDropDown.Items.Count = 1 then
      begin
        TmpUnn := ClList.ListClients[ClientsDropDown.ItemIndex].UNN;
      end
  else
    begin
      TmpUnn := '-1';
    end;

  with  TmpReq do
    begin
      UID        :=HEXhash;
      DCreate    :=Now;
      DDelivery  :=MyTimeDate;
      UNN        :=TmpUnn;
      Status     :=0;
      Note       :='';
      Discount   :=0;
      IDPoint    :=-1;
      FullSum    :=0;
      TypeSal    :=0;
    end;

  Result:=InAddRequest(TmpReq, False);;
end;

function TRequests.SaveXML : bool;
var
  i                     : integer;
  XMLDocument           : TXMLDocument;
  RootStock             : IXMLNode;
begin
  Result:=False;
  XMLDocument           :=TXMLDocument.Create(nil);
  //try
  XMLDocument.Active    := true;

  XMLDocument.Encoding  :='UTF-8';
  RootStock             :=XMLDocument.AddChild('Requests');
  XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

  for i:=0 to Length(RequestsArray) -1 do
    begin
      CreateReqXml(RequestsArray[i], RootStock);
    end;

  XMLDocument.SaveToFile(FileNameXML);
  Result:=True;
  //finally
    //XMLDocument.Free;
  //end;
end;

function TRequests.AddTovarInSelReq(Code : integer; Count : integer; Cost1 : Double; Cost2: Double; Note : String) : bool;
begin
  try
    RequestsArray[SelectedItem].AddTovar(Code, Count, Cost1, Cost2, 0, Note, 0);
    RequestsArray[SelectedItem].FullSum:=RequestsArray[SelectedItem].GetFullSum;

    LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[3]:=FloatToStr(RequestsArray[SelectedItem].FullSum);
    LisrReq.Repaint;

    SaveXML;
    FillTovars(SelectedItem);

    Result:=True;
  except
    Result:=False;
  end;
end;

function TRequests.GetTovarName(Code : integer) : string;
var
  Data    : PTreeData;
  StrCode : string;
  XNode   : PVirtualNode;
begin
  StrCode:=IntToStr(Code);

  if VST.GetFirst = nil then Result:='<???>';

  XNode:=nil;
  repeat
    if XNode = nil then XNode:=VST.GetFirst else XNode:=VST.GetNext(XNode);
    Data:=VST.GetNodeData(XNode);
    if (Data^.Code = StrCode) then
        begin
          Result:=Data^.Name;
          exit;
        end;
  until XNode = VST.GetLast();

  Result:='<???>';
end;

function TRequests.GetTovar(Code : integer) : Tovar;
var
  Data    : PTreeData;
  StrCode : string;
  XNode   : PVirtualNode;

  TmpTv   : Tovar;
begin
  StrCode:=IntToStr(Code);

  TmpTv.Code:=0;
  TmpTv.Name:='<???>';

  if VST.GetFirst = nil then Result:=TmpTv;

  XNode:=nil;
  repeat
    if XNode = nil then XNode:=VST.GetFirst else XNode:=VST.GetNext(XNode);
    Data:=VST.GetNodeData(XNode);
    if (Data^.Code = StrCode) then
        begin
          TmpTv.Code      :=Code;
          TmpTv.Count     :=0;
          TmpTv.Coast1    :=Data^.Cost1Dbl;
          TmpTv.Coast2    :=Data^.Cost2Dbl;
          TmpTv.Discount  :=0;
          TmpTv.Notes     :='';
          TmpTv.Shipped   :=0;
          TmpTv.Name      :=Data^.Disc;
          TmpTv.Status    :=Data^.Status;

          Result:=TmpTv;
          exit;
        end;
  until XNode = VST.GetLast();

  Result:=TmpTv;
end;

function TRequests.GetReqStatus(indx : integer) : integer;
begin
  Result:=RequestsArray[indx].Status;
end;

function TRequests.GetTypeSale(Id : integer):string;
var
  i : Integer;
begin
  if Length(TpSal) > 0 then
    for i := 0 to Length(TpSal) do
      begin

        if TpSal[i].ID = Id then
            begin
              Result:=TpSal[i].Tp;
              Exit;
            end;
      end;

  Result:='<???>';
end;

function TRequests.FillTovars(indx : integer) : bool;
var
  i           : integer;
  olg         : TOutlookGroup;
  sl          : TStrings;
  TmpClInf    : ClInfo;
begin
  SelectedItem:=indx;
  try
    NotesM.Text             :=RequestsArray[indx].Note;
    TmpClInf                :=ClList.GetNameClientFromUNN(RequestsArray[indx].UNN, RequestsArray[indx].IDPoint);
    ClientsDropDown.Text    :=TmpClInf.Name;
    PointDropDown.Text      :=TmpClInf.PointMame;
    DateTimePicker.Date     :=StrToDate(RequestsArray[indx].DDelivery);
    TypeDropDown.Text       :=GetTypeSale(RequestsArray[indx].TypeSal);
    DiscountSpinEdit.Value  :=RequestsArray[indx].Discount;
    //i:=Trunc(i/0);
  except on E : Exception do
    begin
      MessageDlg('Ошибка открытия заказа (Код: 1): ' + E.Message, mtError, [mbOK], 0);
      Result:=False;
    end;
  end;

  if RequestsArray[indx].Status <> 0 then
      begin
        ClientsDropDown.ReadOnly  :=True;
        PointDropDown.ReadOnly    :=True;
        TypeDropDown.ReadOnly     :=True;
        NotesM.ReadOnly           :=True;
        DateTimePicker.Enabled    :=False;
        DiscountSpinEdit.ReadOnly :=True;
      end
  else
      begin
        ClientsDropDown.ReadOnly  :=False;
        PointDropDown.ReadOnly    :=False;
        TypeDropDown.ReadOnly     :=False;
        NotesM.ReadOnly           :=False;
        DateTimePicker.Enabled    :=True;
        DiscountSpinEdit.ReadOnly :=False;
      end;

  ClientsDropDown.Refresh;
  PointDropDown.Refresh;

  TovarsList.BeginUpdate;
  try
    TovarsList.ClearGroups;

    olg := TovarsList.AddGroup('');

    for i := 0 to Length(RequestsArray[indx].TovarsArray) - 1 do
        begin
          sl := TovarsList.AddItem(olg);
          sl.Add(IntToStr(i + 1));
          sl.Add(IntToStr(RequestsArray[indx].TovarsArray[i].Code));
          RequestsArray[indx].TovarsArray[i].Name:=GetTovarName(RequestsArray[indx].TovarsArray[i].Code);
          sl.Add(RequestsArray[indx].TovarsArray[i].Name);
          sl.Add(FloatToStr(RequestsArray[indx].TovarsArray[i].Coast1));
          sl.Add(IntToStr(RequestsArray[indx].TovarsArray[i].Count));
          sl.Add(IntToStr(RequestsArray[indx].TovarsArray[i].Shipped));

          if RequestsArray[indx].TovarsArray[i].Count > 0 then
            sl.Add(IntToStr(Round(100 * (RequestsArray[indx].TovarsArray[i].Shipped / RequestsArray[indx].TovarsArray[i].Count))))
          else sl.Add('100');

          if RequestsArray[indx].Status = 0 then
              begin
                sl.Add('15');
                sl.Add('11');
              end
            else
              begin
                sl.Add('14');
                sl.Add('10');
              end;

          olg.ChildOGLItem[i].ItemObject := TObject(i);
          olg.ChildOGLItem[i].Tag:=i;
        end;
  finally
    TovarsList.EndUpdate;
  end;

  Result:=True;
end;

function TRequests.InAddRequest(CrReq : Request; LoadL : bool) : integer;
var
  indx        : integer;
  Tmp         : string;
begin
  indx := Length(RequestsArray);
  SetLength(RequestsArray, indx + 1);
  RequestsArray[indx]:=CrReq;


  {.Add(xUID,
                          xDCreate,
                          xDDelivery,
                          xUNN,
                          xStatus,
                          xNote,
                          xDiscount,
                          xIDPoint,
                          xTypeSal);}

  reqsl := LisrReq.AddItem(reqolg);

  DateTimeToString(Tmp, 'ddd dd.mm.yyyy hh:mm', RequestsArray[indx].DCreate);

  //reqsl.AddObject('DT', Pointer(RequestsArray[indx].DCreate));

  reqsl.Add(IntToStr(RequestsArray[indx].Status));
  reqsl.Add(Tmp);
  reqsl.Add(ClList.GetNameClientFromUNN(RequestsArray[indx].UNN, RequestsArray[indx].IDPoint).Name);
  RequestsArray[indx].FullSum:=RequestsArray[indx].FullSum;
  reqsl.Add(FloatToStr(RequestsArray[indx].FullSum));
  reqsl.Add('');

  if RequestsArray[indx].Status = 0 then
      begin
        reqsl.Add('13');
        //reqsl.Add('11');
      end
    else
      begin
        reqsl.Add('12');
        //reqsl.Add('11');
      end;

  reqsl.Add('11');

  reqolg.ChildOGLItem[indx].ItemObject := TObject(indx);
  reqolg.ChildOGLItem[indx].Tag:=indx;

  if not LoadL then
    begin
      LisrReq.SelectItem(reqolg.ChildOGLItem[indx]);
    end;

  LisrReq.Sort;
  Result:=indx;
end;

function TRequests.GetAtmReqFromXML(RtChildNode : IXMLNode; var TmpReq : Request) : BOOL;
var
  ItChildNode   : IXMLNode;
  l             : Integer;

  Code          : integer;
  Count         : integer;
  Coast1        : Double;
  Coast2        : Double;
  Discount      : Double;
  Notes         : string;
  Shipped       : integer;

  InTmpReq      : Request;
begin
  Result:=False;

  with InTmpReq do
    begin
      UID        := VarToStr(RtChildNode.Attributes['UID']);
      DCreate    := VarToDateTime(RtChildNode.Attributes['DCreate']);
      DDelivery  := VarToStr(RtChildNode.Attributes['DDelivery']);
      UNN        := VarToStr(RtChildNode.Attributes['UNN']);
      Status     := StrToInt(VarToStr(RtChildNode.Attributes['Status']));
      Note       := VarToStr(RtChildNode.Attributes['Note']);
      Discount   := StrToFloat(VarToStr(RtChildNode.Attributes['Discount']));
      IDPoint    := StrToInt(VarToStr(RtChildNode.Attributes['IDPoint']));
      FullSum    := StrToFloat(VarToStr(RtChildNode.Attributes['FullSum']));
      TypeSal    := StrToInt(VarToStr(RtChildNode.Attributes['TypeSal']));
    end;

    for l := 0 to RtChildNode.ChildNodes.Count - 1 do
      begin
        if RtChildNode.ChildNodes[l].NodeName = 'Item' then
          begin
            ItChildNode :=RtChildNode.ChildNodes[l];

            Code        := StrToInt(VarToStr(ItChildNode.Attributes['Code']));
            Count       := StrToInt(VarToStr(ItChildNode.Attributes['Count']));
            Coast1      := StrToFloat(VarToStr(ItChildNode.Attributes['Coast1']));
            Coast2      := StrToFloat(VarToStr(ItChildNode.Attributes['Coast2']));
            Discount    := StrToFloat(VarToStr(ItChildNode.Attributes['Discount']));
            Notes       := VarToStr(ItChildNode.Attributes['Notes']);
            Shipped     := StrToInt(VarToStr(ItChildNode.Attributes['Shipped']));

            InTmpReq.AddTovar(Code, Count, Coast1, Coast2, Discount, Notes, Shipped);
          end;
      end;


  TmpReq:=InTmpReq;
  Result:=True;
end;

function TRequests.LoadRequests : bool;
var
  //Tmp           : string;
  i, k          : integer;

  //indxL         : integer;

  RtChildNode   : IXMLNode;
  //ItChildNode   : IXMLNode;

  TmpReq        : Request;

  XMLDocument   : TXMLDocument;
begin
  try
    if GetXMLDoc(XMLDocument, FileNameXML) then
        begin
          LisrReq.ClearGroups;
          reqolg := LisrReq.AddGroup('');
          SetLength(RequestsArray, 0);

          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
              begin
                  if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                    begin
                       if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Requests' then
                        begin
                          for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                            begin
                              if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Request' then
                                  begin
                                    RtChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];
                                      if GetAtmReqFromXML(RtChildNode, TmpReq) then
                                          begin
                                            InAddRequest(TmpReq, True);
                                          end;
                                  end;
                            end;
                        end;
                    end;
              end;

          LisrReq.Sort;
          //TovarsList.EndUpdate;
          Result:=True;
        end
    else
      begin
        Result:=False;
      end;
  finally
    FreeAndNil(XMLDocument);
  end;
end;

function TRequests.LoadTypeSal(FileNameXMLSaleT : string) : bool;
var
  i, k, l     : integer;
  DDItem      : TDropDownItem;
  XMLDocument : TXMLDocument;
begin
  try
    if not GetXMLDoc(XMLDocument, FileNameXMLSaleT) then
        begin
          Result:=False;
          exit;
        end;

    SetLength(TpSal, 0);

    for i := 0 to XMLDocument.ChildNodes.Count - 1 do
        begin
            if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
              begin
                 if XMLDocument.ChildNodes.Nodes[i].NodeName = 'TypeSal' then
                  begin
                    for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                      begin
                        if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Type' then
                            begin
                              l:=Length(TpSal);

                              SetLength(TpSal, l + 1);

                              TpSal[l].ID := StrToInt(VarToStr(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].Attributes['ID']));
                              TpSal[l].Tp := VarToStr(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].Attributes['Name']);
                            end;
                      end;
                  end;
              end;
        end;

    TypeDropDown.Clear;
    TypeDropDown.Items.Clear;

    for i := 0 to Length(TpSal) - 1 do
      begin
        DDItem := TypeDropDown.Items.Add;

        DDItem.Text.Add(TpSal[i].Tp);
      end;

    Result:=True;
  finally
    FreeAndNil(XMLDocument);
  end;
end;

function Request.AddTovar(xCode : integer; xCount : integer;
                      xCoast1 : Double; xCoast2 : Double;
                      xDiscount : Double; xNotes : string;
                      xShipped : integer): integer;
begin
  SetLength(TovarsArray, Length(TovarsArray) + 1);
  with TovarsArray[Length(TovarsArray) - 1] do
    begin
      Code     := xCode;
      Count    := xCount;
      Coast1   := xCoast1;
      Coast2   := xCoast2;
      Discount := xDiscount;
      Notes    := xNotes;
      Shipped  := xShipped;
    end;

  Result:=1;
end;

procedure DeleteTv(var A: TArTovar; const Index: Cardinal);
var
  ALength: Cardinal;
  TailElements: Cardinal;
begin
  ALength := Length(A);
  Assert(ALength > 0);
  Assert(Index < ALength);
  Finalize(A[Index]);
  TailElements := ALength - Index;

  if TailElements > 0 then
      Move(A[Index + 1], A[Index], SizeOf(Tovar) * TailElements);

  Initialize(A[ALength - 1]);
  SetLength(A, ALength - 1);
end;

procedure DeleteRq(var A: TArReq; const Index: Cardinal);
var
  ALength: Cardinal;
  TailElements: Cardinal;
begin
  ALength := Length(A);
  Assert(ALength > 0);
  Assert(Index < ALength);
  Finalize(A[Index]);
  TailElements := ALength - Index;

  if TailElements > 0 then
      Move(A[Index + 1], A[Index], SizeOf(Request) * TailElements);

  Initialize(A[ALength - 1]);
  SetLength(A, ALength - 1);
end;

function Request.DeleteTovar(indx : integer) : integer;
begin
  if MessageDlg('Удалить позицию: ' + TovarsArray[indx].Name , mtWarning, mbYesNo, 0) = mrYes  then
      begin
        DeleteTv(TArTovar(TovarsArray), indx);
        Result:=1;
      end
    else
      begin
        Result:=0;
      end;
end;

function TRequests.DeleteReq(indx : integer) : integer;
var
  Tmp : string;
begin
  //if RequestsArray[SelectedItem].Status = 0 then
      //begin
      DateTimeToString(Tmp, 'hh:mm dd.mm.yyyy', RequestsArray[indx].DCreate);

        if MessageDlg('Удалить заявку: от ' + Tmp + ' - ' +
                      ClList.GetNameClientFromUNN(RequestsArray[indx].UNN, RequestsArray[indx].IDPoint).Name, mtWarning, mbYesNo, 0) = mrYes  then
            begin
              DeleteRq(TArReq(RequestsArray), indx);

              SaveXML;

              LoadRequests;

              ReqSelect(Self);

              if Assigned(OnRlSelect) then
                  begin
                    if Length(RequestsArray) = 0 then
                        begin
                          OnRlSelect(-1);
                        end
                      else
                        begin
                          OnRlSelect(RequestsArray[SelectedItem].Status);
                        end;
                  end;

              Result:=1;
            end
          else
            begin
              Result:=0;
            end;
      //end
    //else
      //begin
        //Result:=0;
      //end;
end;

function TRequests.CreateReqXml(Req : Request; RootStock : IXMLNode) : bool;
var
  k                     : integer;

  NewStock              : IXMLNode;
  dStock                : IXMLNode;
begin
  try
    NewStock := RootStock.AddChild('Request');
    RootStock.Attributes['GUID']      :=Settings.ID;

    NewStock.Attributes['UID']        :=Req.UID;
    NewStock.Attributes['DCreate']    :=Req.DCreate;
    NewStock.Attributes['DDelivery']  :=Req.DDelivery;
    NewStock.Attributes['UNN']        :=Req.UNN;
    NewStock.Attributes['Status']     :=Req.Status;
    NewStock.Attributes['Note']       :=Req.Note;
    NewStock.Attributes['Discount']   :=Req.Discount;
    NewStock.Attributes['IDPoint']    :=Req.IDPoint;
    NewStock.Attributes['FullSum']    :=Req.FullSum;
    NewStock.Attributes['TypeSal']    :=Req.TypeSal;

    for k := 0 to Length(Req.TovarsArray) - 1 do
      begin
        DStock:=NewStock.AddChild('Item');

        DStock.Attributes['Code']     :=Req.TovarsArray[k].Code;
        DStock.Attributes['Count']    :=Req.TovarsArray[K].Count;
        DStock.Attributes['Shipped']  :=Req.TovarsArray[K].Shipped;
        DStock.Attributes['Coast1']   :=Req.TovarsArray[K].Coast1;
        DStock.Attributes['Coast2']   :=Req.TovarsArray[K].Coast2;
        DStock.Attributes['Discount'] :=Req.TovarsArray[K].Discount;
        DStock.Attributes['Notes']    :=Req.TovarsArray[K].Notes;
      end;

    Result :=True;
    except
      Result :=False;
    end;
end;

function TRequests.SendFile(PathFileName : string; DestFileName: string): bool;
var
  IdFTP       : TIdFTP;
begin
  Result := False;

  idFTP:=TIdFTP.Create(nil);

  with Settings do
    begin
      idFTP.Host     :=ftp;

      idFTP.Username :=SUSSName;
      idFTP.Passive  :=PM;
      idFTP.Port     :=Port;
      idFTP.Password :=SUSSPass;
    end;

    if idFTP.Connected then
        idFTP.Disconnect
      else
        try
          idFTP.Connect();
        except on E : Exception do
          begin
            MessageDlg(ErrorConection + E.Message, mtError, [mbOK], 0);
            Result:=False;
          end;
        end;

    if idFTP.Connected then
    begin
      try
        ////idftp.ChangeDir(Settings.Dir + 'REQ/');
        idftp.ChangeDir('/REQ/');
        idFTP.Put(PathFileName, DestFileName, False);

        Result:=True;
      except
        Result:=False;
      end;

      IdFTP.Disconnect;
      IdFTP.Free;
    end;
end;

function TRequests.SendReq(indx : integer) : bool;
var
  RootStock     : IXMLNode;
  Dir           : string;
  ReqXmlName    : string;
  CompletePath  : string;
  XMLDocument   : TXMLDocument;
  XmlText       : string;
  Tmp           : string;
begin
    Result:=False;
    if (RequestsArray[SelectedItem].Status = 0) then
        begin
          DateTimeToString(Tmp, 'hh:mm dd.mm.yyyy', RequestsArray[indx].DCreate);

          if MessageDlg('Опправить заявку? (' + Tmp + ' - ' +
                        ClList.GetNameClientFromUNN(RequestsArray[indx].UNN, RequestsArray[indx].IDPoint).Name + ')', mtConfirmation, mbYesNo, 0) = mrYes  then
              begin
                if Length(RequestsArray[indx].TovarsArray) = 0 then
                    begin
                      MessageDlg('В заявке отсутствуют товары. Не удалось отправить заявку.', mtInformation, [mbOK], 0);
                      Result:=False;
                      Exit;
                    end;

                if RequestsArray[indx].UNN = '0' then
                    begin
                      if MessageDlg('В заявке не указан клиент. Продолжить отправку?', mtInformation, [mbYes, mbNo], 0) <> mrYes then
                          begin
                            Result:=False;
                            Exit;
                          end;
                    end;

                if RequestsArray[indx].TypeSal = 0 then
                    begin
                      MessageDlg('В заявке не указан тип оплаты.', mtInformation, [mbYes], 0);

                      Result:=False;
                      Exit;
                    end;

                XMLDocument           :=TXMLDocument.Create(nil);
                try
                  XMLDocument.Active    := true;

                  XMLDocument.Encoding  :='UTF-8';
                  RootStock             := XMLDocument.AddChild('Requests');
                  XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

                  CreateReqXml(RequestsArray[indx], RootStock);

                  Dir:=ExtractFileDir(FileNameXML);
                  CheckAccessDir(Dir + '\Req\');

                  ReqXmlName:=RequestsArray[indx].UID;

                  ///////CompletePath:=Dir + '\Req\' + ReqXmlName + '.xml';

                  //////XMLDocument.SaveToFile(CompletePath);

                  XMLDocument.XML.DefaultEncoding:=TEncoding.UTF8;

                  XmlText:=XMLDocument.XML.Text;

                  if Copy(XmlText, 0, 21) = '<?xml version="1.0"?>' then
                    begin
                      Delete(XmlText, 1, 21);
                      XmlText:= '<?xml version="1.0" encoding="UTF-8"?>' + XmlText;
                    end;

                  //ShowMessage(XmlText);

                  if SendReqToServer(xKey, Settings.ID, Settings.Dir, XmlText, idHTTPClient) = 1 then //SendFile(CompletePath, ReqXmlName + '.xml')
                      begin
                        RequestsArray[indx].Status:=1;
                        LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[0]:=IntToStr(RequestsArray[indx].Status);

                        if RequestsArray[indx].Status > 0 then
                            begin
                              //LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[6]:='10';
                              LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[5]:='12';
                            end
                          else
                            begin
                              //LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[6]:='11';
                              LisrReq.Groups[0].ChildItem[GetListIndx(LisrReq, SelectedItem)].Strings[5]:='13';
                            end;

                        LisrReq.Repaint;

                        SaveXML;

                        if Assigned(OnRlSelect) then
                          OnRlSelect(RequestsArray[SelectedItem].Status);

                        ReqSelect(Self);

                        MessageDlg('Заявка отправлена', mtInformation, [mbOK], 0);
                        ////////SysUtils.DeleteFile(CompletePath);

                        Result:=True;
                      end
                  else
                      begin
                        MessageDlg('Не удалось отправить заявку', mtWarning, [mbOK], 0);
                        Result:=False;
                      end;
                finally
                  //XMLDocument.Free;
                end;
              end
            else
              begin
                Result:=False;
              end;
        end
      else
        begin
          Result:=False;
        end;
end;

function Request.Add(xUID         : String;
                      xDCreate    : TDateTime;
                      xDDelivery  : string;
                      xUNN        : string;
                      xStatus     : integer;
                      xNote       : string;
                      xDiscount   : Double;
                      xIDPoint    : integer;
                      xTypeSal    : Integer) : integer;
begin
  UID         := xUID;
  DCreate     := xDCreate;
  DDelivery   := xDDelivery;
  UNN         := xUNN;
  Status      := xStatus;
  Note        := xNote;
  Discount    := xDiscount;
  IDPoint     :=xIDPoint;
  TypeSal     :=xTypeSal;

  Result      :=1;
end;

function Request.GetFullSum : Double;
var
  i       : integer;
  TmpFSum : Double;
begin
  TmpFSum:=0;

  for i := 0 to Length(TovarsArray) - 1 do
      begin
        TmpFSum:=TmpFSum + (TovarsArray[i].Coast1 * TovarsArray[i].Count);
      end;

  Result:=TmpFSum;
end;

function TRequests.CloneReq(indx : integer; Sender: TObject) : bool;
var
  RootStock             : IXMLNode;
  Dir                   : string;
  ReqXmlName            : string;
  CompletePath          : string;

  md5indy               : TIdHashMessageDigest;
  HEXhash, Base         : string;

  MyTimeDate            : string;

  TmpUnn                : string;

  TmpReq                : Request;
  i                     : Integer;
  VData                 : PTreeData;
begin
  //NotesMSelectExit(Sender);

  DateTimeToString(MyTimeDate, 'hh:mm:ss.zzz - dddd d of mmmm yyyy', Now);

  Base                  :=Settings.ID + MyTimeDate;
  md5indy               :=TIdHashMessageDigest5.Create;
  HEXhash               :=md5indy.HashStringAsHex(Base);

  DateTimeToString(MyTimeDate, 'dd.mm.yyyy', Now);

  if ClientsDropDown.Items.Count = 1 then
      begin
        TmpUnn := ClList.ListClients[ClientsDropDown.ItemIndex].UNN;
      end
  else
    begin
      TmpUnn := '-1';
    end;

  with  TmpReq do
    begin
      UID        :=HEXhash;
      DCreate    :=Now;
      DDelivery  :=MyTimeDate;
      UNN        :=RequestsArray[indx].UNN;
      Status     :=0;
      Note       :=RequestsArray[indx].Note;
      Discount   :=RequestsArray[indx].Discount;
      IDPoint    :=RequestsArray[indx].IDPoint;
      FullSum    :=RequestsArray[indx].FullSum;
      TypeSal    :=RequestsArray[indx].TypeSal;
      //Cash       :=RequestsArray[indx].Cash;

      //TovarsArray:=RequestsArray[indx].TovarsArray;
    end;

  for i := 0 to Length(RequestsArray[indx].TovarsArray) - 1 do
    begin
       VData := GetTovarData(VST, IntToStr(RequestsArray[indx].TovarsArray[i].Code));

       if Assigned(VData) then
        begin
          if VData.Status then
            begin
              SetLength(TmpReq.TovarsArray, Length(TmpReq.TovarsArray) + 1);

              TmpReq.TovarsArray[Length(TmpReq.TovarsArray) - 1] := RequestsArray[indx].TovarsArray[i];
            end;
        end;
    end;

  InAddRequest(TmpReq, False);

  SaveXML;
  LoadRequests;

  Result:=True;
end;

end.
