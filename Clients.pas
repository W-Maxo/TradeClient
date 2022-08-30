unit Clients;

interface

uses
  Windows, Utils, SysUtils, XMLIntf, Variants, MyTypes, IOUtils, VirtualTrees,
  XMLDoc, Dialogs, AdvMultiColumnDropDown, AdvOutlookList, Classes, IdGlobalProtocols;

type
  TClSelectEvent = procedure(N : integer; Name : String; UNN : String) of object;
  TPointSelectEvent = procedure(N : integer; PID : integer) of object;

  ClPoint = record
    Address       : String;
    Name          : String;
    ID            : integer;
  end;

  ClClient = record
    Name          : string;
    UNN           : string;
    Address       : string;

    Points        : Array of ClPoint;
  end;

type
  ClientSR = Class(TObject)
    ListClients    : Array of ClClient;

    private
      FOnClSelect         : TClSelectEvent;
      FOnPointSelect      : TPointSelectEvent;

      procedure ClientsDropDownSelect(Sender: TObject);
      procedure PointDropDownSelect(Sender: TObject);
      function SaveMngXML(Dir : string) : bool;
    public
      ClientsDropDown         : TAdvMultiColumnDropDown;
      PointDropDown           : TAdvMultiColumnDropDown;
      TypeDropDown            : TAdvMultiColumnDropDown;
      AdvOutlookList          : TAdvOutlookList;

      ManagerName   : string;
      ManagerTel    : string;
      ManagerDesc   : string;

      ClOtLst                 : TOtGr;

      property OnClSelect     : TClSelectEvent read FOnClSelect write FOnClSelect;
      property OnPointSelect  : TPointSelectEvent read FOnPointSelect write FOnPointSelect;

      function LoadClients(FileName : string) : bool;
      function GetNameClientFromUNN(UNN : string; ID : integer) : ClInfo;

      Constructor Create(xClientsDropDown : TAdvMultiColumnDropDown;
                          xPointDropDown  : TAdvMultiColumnDropDown;
                          xTypeDropDown   : TAdvMultiColumnDropDown;
                          xAdvOutlookList : TAdvOutlookList);
  end;


implementation

Constructor ClientSR.Create(xClientsDropDown    : TAdvMultiColumnDropDown;
                            xPointDropDown      : TAdvMultiColumnDropDown;
                            xTypeDropDown       : TAdvMultiColumnDropDown;
                            xAdvOutlookList     : TAdvOutlookList);
begin
  ClientsDropDown :=xClientsDropDown;
  PointDropDown   :=xPointDropDown;
  TypeDropDown    :=xTypeDropDown;
  AdvOutlookList  :=xAdvOutlookList;

  ClientsDropDown.OnSelect  :=ClientsDropDownSelect;
  PointDropDown.OnSelect    :=PointDropDownSelect;
end;

function ClientSR.GetNameClientFromUNN(UNN : string; ID : integer) : ClInfo;
var
  i, k  : integer;
  Tmp   : ClInfo;
begin
  for i := 0 to Length(ListClients) - 1 do
      begin
        if ListClients[i].UNN = UNN then
            begin
              Tmp.Name:=ListClients[i].Name;
              if (ID > -1) and (Length(ListClients[i].Points) > 0) then
                  begin
                    for k := 0 to Length(ListClients[i].Points) do
                      begin
                        if ListClients[i].Points[k].ID = ID then
                            begin
                              Tmp.PointMame:=ListClients[i].Points[k].Name;
                              break;
                            end;
                        Tmp.PointMame:='<???>';
                      end;

                  end
                else
                  begin
                    Tmp.PointMame:='';
                  end;
              Result:=Tmp;
              exit;
            end;
      end;

  Tmp.Name:='<???>';
  Tmp.PointMame:='<???>';
  Result:=Tmp;
end;

procedure ClientSR.ClientsDropDownSelect(Sender: TObject);
var
  DDItem  : TDropDownItem;
  i       : integer;
begin
  if not ClientsDropDown.ItemIndex > -1 then exit;

  PointDropDown.Clear;
  PointDropDown.Items.Clear;

  for i := 0 to Length(ListClients[ClientsDropDown.ItemIndex].Points) - 1 do
    begin
      DDItem := PointDropDown.Items.Add;

      DDItem.Text.Add(ListClients[ClientsDropDown.ItemIndex].Points[i].Name);
      DDItem.Text.Add(ListClients[ClientsDropDown.ItemIndex].Points[i].Address);
    end;

  if Assigned(OnClSelect) then
      OnClSelect(ClientsDropDown.ItemIndex, ListClients[ClientsDropDown.ItemIndex].Name, ListClients[ClientsDropDown.ItemIndex].UNN);
end;

procedure ClientSR.PointDropDownSelect(Sender: TObject);
begin
  if not PointDropDown.ItemIndex > -1 then exit;

  if Assigned(OnPointSelect) then
      OnPointSelect(ClientsDropDown.ItemIndex, ListClients[ClientsDropDown.ItemIndex].Points[PointDropDown.ItemIndex].ID);
end;

function ClientSR.SaveMngXML(Dir : string) : bool;
var
  i                     : integer;
  RootStock             : IXMLNode;
  ChildStock            : IXMLNode;
  XMLDocument           : IXMLDocument;
  CompletePath          : string;
begin
  XMLDocument           :=TXMLDocument.Create(nil);
  XMLDocument.Active    := true;

  XMLDocument.Encoding  :='UTF-8';

  XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

  RootStock             :=XMLDocument.AddChild('m');
  RootStock             :=RootStock.AddChild('manager');

  ChildStock            :=RootStock.AddChild('name');
  ChildStock.NodeValue  :=ManagerName;

  ChildStock            :=RootStock.AddChild('tel');
  ChildStock.NodeValue  :=ManagerTel;

  ChildStock            :=RootStock.AddChild('desc');
  ChildStock.NodeValue  :=ManagerDesc;

  CompletePath:=Dir + '\data' + '.xml';

  XMLDocument.SaveToFile(CompletePath);

  if CheckAccessDir(Dir + '\Info\') then
  CopyFileTo(CompletePath, Dir + '\Info\' + 'data' + '.xml');

  Result:=True;
end;

function ClientSR.LoadClients(FileName : string) : bool;
var
  i, k, l, ln,
  indx, inindx  : integer;

  Tmp           : string;

  XMLDocument   : TXMLDocument;

  DDItem        : TDropDownItem;

  olg           : TOutlookGroup;
  sl            : TStrings;

  ClIXMLNode    : IXMLNode;
  PnIXMLNode    : IXMLNode;

  Cnt           : Integer;
begin
  if GetXMLDoc(XMLDocument, FileName) then
      begin
        //AdvOutlookList.BeginUpdate;
        //AdvOutlookList.ClearGroups;

        SetLength(ClOtLst, 0);
        SetLength(ListClients, 0);

        try
          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Clients' then
                      begin
                        ManagerName:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['ManagerName']);
                        ManagerTel:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['ManagerTel']);
                        ManagerDesc:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['ManagerDesc']);

                        SaveMngXML(ExtractFileDir(FileName));

                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Client' then
                                begin
                                  ClIXMLNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                  indx:=Length(ListClients);
                                  SetLength(ListClients, indx + 1);

                                  ListClients[indx].Name:=VarToStr(ClIXMLNode.Attributes['Name']);
                                  ListClients[indx].UNN:=VarToStr(ClIXMLNode.Attributes['UNN']);
                                  ListClients[indx].Address:=VarToStr(ClIXMLNode.Attributes['Address']);

                                  Tmp:=ListClients[indx].Name + ' (УНН ' + ListClients[indx].UNN + ') ' + ListClients[indx].Address;

                                  Ln:=Length(ClOtLst);
                                  SetLength(ClOtLst, Ln + 1);

                                  ClOtLst[Ln].Caption:=Tmp;

                                  //olg := advoutlooklist.AddGroup(Tmp);

                                    for l := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes.Count - 1 do
                                      begin
                                        if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes[l].NodeName = 'Point' then
                                            begin
                                              PnIXMLNode:= ClIXMLNode.ChildNodes[l];

                                              Cnt := Length(ClOtLst[Ln].Items);
                                              SetLength(ClOtLst[Ln].Items, Cnt + 1);

                                              ClOtLst[Ln].Items[Cnt]:=TStringList.Create;

                                              inindx:=Length(ListClients[indx].Points);
                                              SetLength(ListClients[indx].Points, inindx + 1);

                                              ListClients[indx].Points[inindx].Name:=VarToStr(PnIXMLNode.Attributes['Name']);
                                              ListClients[indx].Points[inindx].Address:=VarToStr(PnIXMLNode.Attributes['Address']);
                                              ListClients[indx].Points[inindx].ID:=StrToInt(VarToStr(PnIXMLNode.Attributes['ID']));

                                              //sl := AdvOutlookList.AddItem(olg);

                                              ClOtLst[Ln].Items[Cnt].Add(ListClients[indx].Points[inindx].Name);
                                              ClOtLst[Ln].Items[Cnt].Add(ListClients[indx].Points[inindx].Address);
                                            end;
                                      end;
                                end;
                          end;
                      end;
                  end;
            end;

            //AdvOutlookList.CollapseAll;

            //AdvOutlookList.EndUpdate;

            FillDocEx(AdvOutlookList, ClOtLst);

            ClientsDropDown.Clear;
            ClientsDropDown.Items.Clear;

            //ShowMessage(IntToStr(Length(ListClients)));

            for i := 0 to Length(ListClients) - 1 do
              begin
                DDItem := ClientsDropDown.Items.Add;

                DDItem.Text.Add(ListClients[i].Name);
                DDItem.Text.Add(ListClients[i].UNN);
              end;

            if ClientsDropDown.Items.Count = 1 then
                ClientsDropDown.ItemIndex:=0;

            Result:=True;
        except on E : Exception do
          begin
            MessageDlg('Ошибка открытия файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
            Result:=False;
          end;
        end;

        XMLDocument.Free;
      end
    else
      begin
        Result:=False;
      end;
end;

end.
