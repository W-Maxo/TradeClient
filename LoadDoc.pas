unit LoadDoc;

interface

uses
    Windows, Forms, Dialogs, VirtualTrees, XMLDoc, Utils, SysUtils, XMLIntf,
    Variants, MyTypes, IOUtils, IdGlobalProtocols, AdvOutlookList, Classes,
    RequisitionClass, Clients, Generics.Collections, Math;

  function LoadSDPDoc(var VSTree: TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
  function LoadSDPFile(var VSTree: TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
  function LoadTvDoc(var VSTree: TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
  function LoadTvFile(var VSTree: TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
  function LoadArrearageFile(var AdvOutlookList: TAdvOutlookList; var ArrOutlookList : TOtGr; const SourceFile: string; DestFile : string) : bool;
  //function LoadArrearageDoc(var AdvOutlookList: TAdvOutlookList; const FileName: string) : bool;
  function LoadSalesFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string) : bool;
  function LoadSalesDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string) : bool;
  function LoadClientsFile(var ClList : ClientSR; const SourceFile: string; DestFile : string) : bool;
  function GetVersions(FileName : string): TVersions;
  function SaveVersions(FileName : string; Ver : TVersions): bool;
  function CheckKey(FileName : string; Id : string): bool;
  function LoadTypeSalFile(var MainRequests : TRequests; const SourceFile: string; DestFile : string) : bool;
  function LoadArrearageDocEx(var AdvOutlookList: TOtGr; const FileName: string) : bool;
  function GetFileVersions(FileName : string): TFileVersions;
  function SaveFileVersions(FileName : string; Ver : TFileVersions): bool;
  function LoadRestDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
  function LoadRestFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
  function LoadDiscDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string) : bool;
  function LoadDiscFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string) : bool;
  function CalculateCost(var vrtlstrngtr : TVirtualStringTree; NoDisc: integer): bool;
  function LoadWaitFile(var VST : TVirtualStringTree; var vrtlstrngtr : TVirtualStringTree; var Av , UnAv : Integer; const FileName: string) : bool;
  function AddToWaitList(Code : string; const FileName: string) : Boolean;
  function DeleteFromWaitList(Code : string; const FileName: string) : Boolean;
implementation

function CheckKey(FileName : string; Id : string): bool;
var
  XMLDocument : TXMLDocument;
  i, k        : Integer;
  Tmp         : string;
begin
  Result:=False;

  if GetXMLDoc(XMLDocument, FileName) then
    begin
      try
        for i := 0 to XMLDocument.ChildNodes.Count - 1 do
          begin
              if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                begin
                   if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Keys' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Client' then
                                begin
                                  Tmp:= VarToStr(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].Attributes['ID']);

                                  if AnsiCompareStr(Id, Tmp) = 0 then
                                      begin
                                        XMLDocument.Free;
                                        Result:=True;
                                        Exit;
                                      end
                                  else
                                    Result:=False;
                                end;
                          end;
                      end;
                end;
          end;

          //Result:=True;
      except on E : Exception do
        begin
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

function GetVersions(FileName : string): TVersions;
var
  XMLDocument : TXMLDocument;
  Ver         : TVersions;
  i           : Integer;
begin
  if not GetXMLDoc(XMLDocument, FileName) then
    begin
      //Ver.Splash:=0;
      //Ver.Info:=0;
      Result:=Ver;
    end;

    try
    for i := 0 to XMLDocument.ChildNodes.Count - 1 do
      begin
          if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
            begin
               if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Version' then
                  begin
                    //Ver.Splash:=StrToInt(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Splash']));
                    //Ver.Info  :=StrToInt(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Info']));
                    Ver.Exe   :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Exe']);
                  end;
            end;
      end;

      Result:=Ver;
  except on E : Exception do
    begin
      //Ver.Splash:=0;
      //Ver.Info:=0;
      Result:=Ver;
    end;
  end;

  XMLDocument.Free;
end;

function GetFileVersions(FileName : string): TFileVersions;
var
  XMLDocument : TXMLDocument;
  Ver         : TFileVersions;
  i           : Integer;
begin
  if not GetXMLDoc(XMLDocument, FileName) then
    begin
      Ver.SplashFile  :='';
      Ver.InfoFile    :='';
      Ver.TvFile      :='';
      Ver.ArrFile     :='';
      Ver.ClientsFile :='';
      Ver.SalesFile   :='';
      Ver.TpSalesFile :='';
      Ver.Rest        :='';
      Ver.SDP         :='';
      Ver.Disc        :='';
      Result          :=Ver;
    end;

    try
    for i := 0 to XMLDocument.ChildNodes.Count - 1 do
      begin
          if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
            begin
               if XMLDocument.ChildNodes.Nodes[i].NodeName = 'FileVersion' then
                  begin
                    Ver.SplashFile  :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['SplashFile']);
                    Ver.InfoFile    :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['InfoFile']);
                    Ver.TvFile      :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['TvFile']);
                    Ver.ArrFile     :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['ArrFile']);
                    Ver.ClientsFile :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['ClientsFile']);
                    Ver.SalesFile   :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['SalesFile']);
                    Ver.TpSalesFile :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['TpSalesFile']);
                    Ver.Rest        :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Rest']);
                    Ver.SDP         :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['SDP']);
                    Ver.Disc        :=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Disc']);
                  end;
            end;
      end;

      Result:=Ver;
  except on E : Exception do
    begin
      Ver.SplashFile  :='';
      Ver.InfoFile    :='';
      Ver.TvFile      :='';
      Ver.ArrFile     :='';
      Ver.ClientsFile :='';
      Ver.SalesFile   :='';
      Ver.TpSalesFile :='';
      Ver.Rest        :='';
      Ver.SDP         :='';
      Ver.Disc        :='';
      Result          :=Ver;
    end;
  end;

  XMLDocument.Free;
end;

function SaveVersions(FileName : string; Ver : TVersions): bool;
var
  XMLDocument           : TXMLDocument;
  RootStock             : IXMLNode;
begin
  XMLDocument           :=TXMLDocument.Create(nil);
  XMLDocument.Active    := true;

  XMLDocument.Encoding  :='UTF-8';
  RootStock             := XMLDocument.AddChild('Version');
  XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

  //RootStock.Attributes['Splash']:=Ver.Splash;
  //RootStock.Attributes['Info']:=Ver.Info;
  RootStock.Attributes['Exe']:=Ver.Exe;

  XMLDocument.SaveToFile(FileName);
  Result:=True;
end;

function SaveFileVersions(FileName : string; Ver : TFileVersions): bool;
var
  XMLDocument           : TXMLDocument;
  RootStock             : IXMLNode;
begin
  XMLDocument           :=TXMLDocument.Create(nil);
  XMLDocument.Active    := true;

  XMLDocument.Encoding  :='UTF-8';
  RootStock             := XMLDocument.AddChild('FileVersion');
  XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

  RootStock.Attributes['SplashFile']  := Ver.SplashFile;
  RootStock.Attributes['InfoFile']    := Ver.InfoFile;
  RootStock.Attributes['TvFile']      := Ver.TvFile;
  RootStock.Attributes['ArrFile']     := Ver.ArrFile;
  RootStock.Attributes['ClientsFile'] := Ver.ClientsFile;
  RootStock.Attributes['SalesFile']   := Ver.SalesFile;
  RootStock.Attributes['TpSalesFile'] := Ver.TpSalesFile;
  RootStock.Attributes['Rest']        := Ver.Rest;
  RootStock.Attributes['SDP']         := Ver.SDP;
  RootStock.Attributes['Disc']        := Ver.Disc;

  XMLDocument.SaveToFile(FileName);
  Result:=True;
end;

function LoadRestFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
begin
  Result:=False;

  if LoadRestDoc(vrtlstrngtr, SourceFile, xTvInf) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadRestDoc(vrtlstrngtr, DestFile, xTvInf) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            if LoadRestDoc(vrtlstrngtr, DestFile, xTvInf) then
                begin
                  Result:=True;
                end
              else
                begin
                  Result:=False;
                end;
      end;
end;

function LoadWaitFile(var VST : TVirtualStringTree; var vrtlstrngtr : TVirtualStringTree; var Av , UnAv : Integer; const FileName: string) : bool;
var
  XMLDocument       : TXMLDocument;
  GrChildNode       : IXMLNode;
  i, k              : Integer;
  Tmp               : string;

  XNodeAval         : PVirtualNode;
  XNodeNonAval      : PVirtualNode;
  XNode             : PVirtualNode;
  VData             : PTreeData;
  Data              : PTreeData;
begin
  vrtlstrngtr.BeginUpdate;
  vrtlstrngtr.Clear;

  Av:=0;
  UnAv:=0;

  if GetXMLDoc(XMLDocument, FileName) then
    begin
      XNodeAval:=vrtlstrngtr.AddChild(nil);
      Data := vrtlstrngtr.GetNodeData(XNodeAval);
      Data^.Name:= 'Доступно:';
      Data^.Root:=True;

      Data^.ImageIndex:=0;

      XNodeNonAval:=vrtlstrngtr.AddChild(nil);
      Data := vrtlstrngtr.GetNodeData(XNodeNonAval);
      Data^.Name:= 'Не доступно:';
      Data^.Root:=True;

      Data^.ImageIndex:=0;

      try
        for i := 0 to XMLDocument.ChildNodes.Count - 1 do
          begin
            if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
              begin
                if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Wait' then
                  begin
                    for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                      begin
                        if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Item' then
                          begin
                            GrChildNode:= XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                            Tmp:=VarToStr(GrChildNode.Attributes['ID']);

                            VData := GetTovarData(VST, Tmp);

                            if Assigned(VData) then
                              begin
                                if not VData.Status then
                                    begin
                                      XNode := vrtlstrngtr.AddChild(XNodeNonAval);
                                      inc(UnAv);
                                    end
                                  else
                                    begin
                                      XNode := vrtlstrngtr.AddChild(XNodeAval);
                                      inc(Av);
                                    end;

                                Data := vrtlstrngtr.GetNodeData(XNode);
                                Data^.Root    :=False;

                                Data^.Name        := VData^.Name;
                                Data^.NameNS      := VData^.NameNS;
                                Data^.Code        := VData^.Code;
                                Data^.Ost         := VData^.Ost;
                                Data^.ImageIndex  := VData^.ImageIndex;
                                Data^.CntInP      := VData^.CntInP;
                                Data^.MinR        := VData^.MinR;
                                Data^.Disc        := VData^.Disc;
                                Data^.DiscDbl     := VData^.DiscDbl;
                                Data^.OEMNum      := VData^.OEMNum;
                                Data^.RefNum      := VData^.RefNum;
                                Data^.Cost1       := VData^.Cost1;
                                Data^.Cost2       := VData^.Cost2;
                                Data^.Cost1Dbl    := VData^.Cost1Dbl;
                                Data^.Cost2Dbl    := VData^.Cost2Dbl;
                                Data^.Cost1DblOr  := VData^.Cost1DblOr;
                                Data^.Cost2DblOr  := VData^.Cost2DblOr;
                                Data^.ImageIndex  := VData^.ImageIndex;
                                Data^.Status      := VData^.Status;
                                Data^.DynOfPrices := VData^.DynOfPrices;
                              end;
                          end;
                      end;
                  end;
              end;
          end;
      except on E : Exception do
          begin
            MessageDlg('Ошибка открытия файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
            Result:=False;
          end;
      end;
    end;

  FreeAndNil(XMLDocument);

  vrtlstrngtr.FullExpand();
  vrtlstrngtr.EndUpdate;
end;

function AddToWaitList(Code : string; const FileName: string) : Boolean;
var
  XMLDocument : TXMLDocument;
  i, k        : Integer;
  Tmp         : string;

  nd          : IXMLNode;
  RootStock   : IXMLNode;

  InList      : Boolean;
begin
  Result:=False;

  InList:=False;

  if not FileExists(FileName) then
    begin
      XMLDocument           :=TXMLDocument.Create(nil);
      //try
      XMLDocument.Active    := true;

      XMLDocument.Encoding  :='UTF-8';
      RootStock             :=XMLDocument.AddChild('Wait');
      XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

      XMLDocument.SaveToFile(FileName);

      XMLDocument.Active:=False;
    end;

  if GetXMLDoc(XMLDocument, FileName) then
    begin
      try
        XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

        for i := 0 to XMLDocument.ChildNodes.Count - 1 do
          begin
              if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                begin
                   if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Wait' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Item' then
                                begin
                                  Tmp:= VarToStr(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].Attributes['ID']);

                                  if Code = Tmp then
                                    begin
                                      InList:=True;
                                      Break;
                                    end;
                                end;
                          end;

                        if InList then
                            begin
                              MessageDlg('Товар уже есть в списке ожидания!', mtInformation, [mbOK], 0) ;
                            end
                          else
                          begin
                            nd:= XMLDocument.CreateNode('Item', ntElement) ;

                            nd.Attributes['ID']:= Code;
                            //nd.Attributes['name']:= UsName;

                            XMLDocument.ChildNodes.Nodes[i].ChildNodes.Add(nd);
                            XMLDocument.SaveToFile(FileName);

                            Result:=True;
                          end;
                      end;
                end;
          end;
      except on E : Exception do
        begin
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

function DeleteFromWaitList(Code : string; const FileName: string) : Boolean;
var
  XMLDocument : TXMLDocument;
  i, k        : Integer;
  Tmp         : string;

  nd          : IXMLNode;
  RootStock   : IXMLNode;

  InList      : Boolean;
begin
  Result:=False;

  InList:=False;

  if FileExists(FileName) then
    begin
      if GetXMLDoc(XMLDocument, FileName) then
        begin
          try
            XMLDocument.Options   :=XMLDocument.Options + [doNodeAutoIndent];

            for i := 0 to XMLDocument.ChildNodes.Count - 1 do
              begin
                  if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                    begin
                       if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Wait' then
                          begin
                            for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                              begin
                                if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Item' then
                                    begin
                                      Tmp:= VarToStr(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].Attributes['ID']);

                                      if Code = Tmp then
                                        begin
                                          XMLDocument.ChildNodes.Nodes[i].ChildNodes.Remove(XMLDocument.ChildNodes.Nodes[i].ChildNodes[k]);

                                          XMLDocument.SaveToFile(FileName);
                                          Result:=True;
                                          Break;
                                        end;
                                    end;
                              end;
                          end;
                    end;
              end;
          except on E : Exception do
            begin
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
end;

function LoadRestDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
var
  i, k              : integer;
  Tmp, Rm           : string;
  Data              : PTreeData;
  XNode             : PVirtualNode;
  XMLDocument       : TXMLDocument;
  GrChildNode       : IXMLNode;
  Rest              : TDictionary<string, string>;
begin
  Rest:= TDictionary<string, string>.Create;

  try
    if GetXMLDoc(XMLDocument, FileName) then
        begin
          try
            for i := 0 to XMLDocument.ChildNodes.Count - 1 do
              begin
                  if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                    begin
                       if XMLDocument.ChildNodes.Nodes[i].NodeName = 'SR' then
                        begin
                          xTvInf.VersionTovars:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['UTD']);
                          ////xTvInf.Kurs:=StrToInt(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['K']));
                      
                          for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                            begin
                              if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'I' then
                                  begin
                                    GrChildNode:= XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                     Tmp:=VarToStr(GrChildNode.Attributes['C']);
                                     Rm:=VarToStr(GrChildNode.Attributes['R']);

                                     Rest.Add(Tmp, Rm);
                                  end;
                            end;
                        end;
                    end;
              end;

              //vrtlstrngtr.BeginUpdate;

              XNode := vrtlstrngtr.GetFirst;
              if XNode <> nil then
                begin
                  //try
                    repeat
                          XNode := vrtlstrngtr.GetNext(XNode);

                          Data := vrtlstrngtr.GetNodeData(XNode);
                                        
                          if Rest.ContainsKey(Data.Code) and (Data.Code <> '') then
                          begin
                            Tmp:=Rest.Items[Data.Code];
                            Data^.Ost := Tmp;

                            if Tmp = 'Y' then
                              begin
                                Data^.Ost:='Есть в наличии';
                                Data^.ImageIndex:=2;
                                Data^.Status:=True;
                              end
                            else
                              begin
                                if Tmp = 'N' then
                                  begin
                                    Data^.Ost:='Нет в наличии';
                                    Data^.ImageIndex:=3;
                                    Data^.Status:=False;
                                  end
                                else
                                  begin
                                    if Tmp = '?' then
                                      begin
                                        Data^.Ost:='Уточняйте наличие';
                                        Data^.ImageIndex:=11;
                                        Data^.Status:=False;
                                      end
                                    else
                                      begin
                                        if StrToIntDef(Tmp, -1) > 0 then
                                          begin
                                            Data^.ImageIndex:=2;
                                            Data^.Status:=True;
                                          end
                                        else
                                          begin
                                            Data^.ImageIndex:=3;
                                            Data^.Status:=False;
                                          end;
                                      end;
                                  end;
                              end;
                          end;
                    until XNode = vrtlstrngtr.GetLast;
                  //finally
                  //  vrtlstrngtr.EndUpdate;
                  //end;
                end
              else Result:=False;

              Result:=True;
          except on E : Exception do
            begin
              MessageDlg('Ошибка открытия файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
              Result:=False;
            end;
          end;

          //XMLDocument.Free;
        end
      else
        begin
          Result:=False;
        end;
  finally
    FreeAndNil(Rest);
    FreeAndNil(XMLDocument);
  end;
end;

function LoadDiscFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string) : bool;
begin
  Result:=False;

  if LoadDiscDoc(vrtlstrngtr, SourceFile) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadDiscDoc(vrtlstrngtr, DestFile) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            if LoadDiscDoc(vrtlstrngtr, DestFile) then
                begin
                  Result:=True;
                end
              else
                begin
                  Result:=False;
                end;
      end;
end;

function LoadDiscDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string) : bool;
var
  i, k              : integer;
  Tmp, Rm           : string;
  Data              : PTreeData;
  XNode             : PVirtualNode;
  XMLDocument       : TXMLDocument;
  GrChildNode       : IXMLNode;
  Disc              : TDictionary<string, Double>;
  Ds                : Double;
begin
  Disc:= TDictionary<string, Double>.Create;

  try
    if GetXMLDoc(XMLDocument, FileName) then
        begin
          try
            for i := 0 to XMLDocument.ChildNodes.Count - 1 do
              begin
                  if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                    begin
                       if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Dsc' then
                        begin
                          //xTvInf.VersionTovars:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['UTD']);
                          ////xTvInf.Kurs:=StrToInt(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['K']));

                          for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                            begin
                              if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'I' then
                                  begin
                                    GrChildNode:= XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                     Tmp:=VarToStr(GrChildNode.Attributes['C']);

                                     Rm:=VarToStr(GrChildNode.Attributes['D']);
//                                     if (Rm <> '') and (Rm <> '0') then
//                                        Rm:=Rm + ' %'
//                                     else
//                                        Rm:='';

                                     Disc.Add(Tmp, StrToFloatDef(Rm, 0));
                                  end;
                            end;
                        end;
                    end;
              end;

              //vrtlstrngtr.BeginUpdate;

              XNode := vrtlstrngtr.GetFirst;
              if XNode <> nil then
                begin
                  //try
                    repeat
                          XNode := vrtlstrngtr.GetNext(XNode);

                          Data := vrtlstrngtr.GetNodeData(XNode);

                          if Disc.ContainsKey(Data.Code) and (Data.Code <> '') then
                          begin
                            Ds:=Disc.Items[Data.Code];
                            if Ds <> 0 then
                              Data^.Disc := FloatToStr(Ds) + ' %'
                            else
                              Data^.Disc:='';

                            Data^.DiscDbl:=Ds / 100;
                            //Data^.Disc := Tmp;
                          end;
                    until XNode = vrtlstrngtr.GetLast;
                  //finally
                  //  vrtlstrngtr.EndUpdate;
                  //end;
                end
              else Result:=False;

              Result:=True;
          except on E : Exception do
            begin
              MessageDlg('Ошибка открытия файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
              Result:=False;
            end;
          end;

          //XMLDocument.Free;
        end
      else
        begin
          Result:=False;
        end;
  finally
    FreeAndNil(Disc);
    FreeAndNil(XMLDocument);
  end;
end;

function CalculateCost(var vrtlstrngtr : TVirtualStringTree; NoDisc: integer): bool;
var
  XNode             : PVirtualNode;
  Data              : PTreeData;
begin
  XNode := vrtlstrngtr.GetFirst;
    if XNode <> nil then
      begin
        repeat
          XNode := vrtlstrngtr.GetNext(XNode);

          Data := vrtlstrngtr.GetNodeData(XNode);

          if not Data^.Root then
            begin
              if NoDisc = 0 then
                begin
                  Data^.Cost1Dbl:= Data^.Cost1DblOr * (1 - Data^.DiscDbl);
                  Data^.Cost2Dbl:= Data^.Cost2DblOr * (1 - Data^.DiscDbl);
                end
              else
                begin
                  Data^.Cost1Dbl:= Data^.Cost1DblOr;
                  Data^.Cost2Dbl:= Data^.Cost2DblOr;
                end;

                Data^.Cost1:=FloatToStrF(Data^.Cost1Dbl, ffCurrency, 12, 2);
                Data^.Cost2:=FloatToStrF(Data^.Cost2Dbl, ffCurrency, 12, 3);
            end;
        until XNode = vrtlstrngtr.GetLast;
      end
    else Result:=False;

  Result:=True;
end;

function LoadTvFile(var VSTree: TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
begin
  if LoadTvDoc(VSTree, SourceFile, xTvInf) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadTvDoc(VSTree, DestFile, xTvInf) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            LoadTvDoc(VSTree, DestFile, xTvInf);
        Result:=False;
      end;
end;

function LoadSDPFile(var VSTree: TVirtualStringTree; const SourceFile: string; DestFile : string; var xTvInf : TvInfo) : bool;
begin
  if LoadSDPDoc(VSTree, SourceFile, xTvInf) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadSDPDoc(VSTree, DestFile, xTvInf) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            LoadSDPDoc(VSTree, DestFile, xTvInf);
        Result:=False;
      end;
end;

function SaveInfoXML(Dir, A, B, C, D, XD : string) : bool;
var
  //i                     : integer;
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
  RootStock             :=RootStock.AddChild('Info');

  ChildStock            :=RootStock.AddChild('A');
  ChildStock.NodeValue  :=A;

  ChildStock            :=RootStock.AddChild('B');
  ChildStock.NodeValue  :=B;

  ChildStock            :=RootStock.AddChild('C');
  ChildStock.NodeValue  :=C;

  ChildStock            :=RootStock.AddChild('D');
  ChildStock.NodeValue  :=D;

  ChildStock            :=RootStock.AddChild('XD');
  ChildStock.NodeValue  :=XD;

  CompletePath:=Dir + '\infodata' + '.xml';

  XMLDocument.SaveToFile(CompletePath);

  if CheckAccessDir(Dir + '\Info\') then
    CopyFileTo(CompletePath, Dir + '\Info\' + 'infodata' + '.xml');

  Result:=True;
end;

function LoadTvDoc(var VSTree: TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
var
  i, k, l, x      : integer;
  Tmp             : string;

  Data            : PTreeData;
  XNode           : PVirtualNode;
  XdNode          : PVirtualNode;

  XMLDocument     : TXMLDocument;

  GrChildNode     : IXMLNode;
  ItChildNode     : IXMLNode;

  TmpArr          : exparr;

  TmpVar          : Variant;

  //TmpDbl          : Double;

  A, B, C, D, XD  : string;
begin

  if GetXMLDoc(XMLDocument, FileName) then
      begin
        VSTree.BeginUpdate;
        VSTree.Clear;

        try
          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'xTovars' then
                      begin
                        xTvInf.VersionTovars:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['UpdateTimeDate']);
                        xTvInf.Kurs:=StrToFloat(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['Kurs']));

                        A:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['A']);
                        B:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['B']);
                        C:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['C']);
                        D:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['D']);

                        Tmp:='';

                        for x := 0 to 32 do
                          begin
                            Tmp:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['A' + IntToStr(x)]);

                            if Tmp <> '' then
                            begin
                              XD:=XD + Tmp + '!@!';
                              Tmp:='';
                            end;

                          end;

                        SaveInfoXML(ExtractFileDir(FileName), A, B, C, D, XD);

                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            GrChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                            if GrChildNode.NodeName = 'Group' then
                                begin
                                   Tmp:=VarToStr(GrChildNode.Attributes['Code']);

                                   XNode:=VSTree.AddChild(nil);

                                   Data := VSTree.GetNodeData(Xnode);
                                   Data^.Name:= Tmp;
                                   Data^.Root:=True;

                                   Data^.ImageIndex:=0;

                                    for l := 0 to GrChildNode.ChildNodes.Count - 1 do
                                      begin
                                        ItChildNode:= GrChildNode.ChildNodes[l];

                                        if ItChildNode.NodeName = 'Item' then
                                            begin
                                              XdNode := VSTree.AddChild(XNode);
                                              Data := VSTree.GetNodeData(Xdnode);

                                              Data^.Root:=False;

                                              Tmp:=VarToStr(ItChildNode.Attributes['MinR']);
                                              Data^.MinR:=StrToIntDef(Tmp, 1);

                                              Tmp:=VarToStr(ItChildNode.Attributes['Desc']);
                                              Data^.Name:= Tmp;

                                              Tmp:=VarToStr(ItChildNode.Attributes['Code']);
                                              Data^.Code:=Tmp;

                                              //ThousandSeparator:=''';
                                              FormatSettings.CurrencyString:='';

                                              Tmp:=VarToStr(ItChildNode.Attributes['Disc']);
                                              if (Tmp <> '') and (Tmp <> '0') then
                                                  Data^.Disc:=Tmp + ' %'
                                                else
                                                  Data^.Disc:='';

                                              Tmp:=VarToStr(ItChildNode.Attributes['Price1']);
                                              Data^.Cost1Dbl:=StrToFloatDef(Tmp, 0);
                                              Data^.Cost1:=FloatToStrF(Data^.Cost1Dbl, ffCurrency, 12, 0);

                                              Tmp:=VarToStr(ItChildNode.Attributes['Price2']);
                                              Data^.Cost2Dbl:=StrToFloatDef(Tmp, 0);
                                              Data^.Cost2:=FloatToStrF(Data^.Cost2Dbl, ffCurrency, 12, 3);

                                              TmpVar :=ItChildNode.Attributes['DP'];

                                              if TmpVar <> null then
                                                  begin
                                                    Tmp:=VarToStr(TmpVar);

                                                    try
                                                      Data^.DynOfPrices := StrToInt(Tmp);
                                                    except
                                                      Data^.DynOfPrices := 0;
                                                    end;
                                                  end
                                                else  Data^.DynOfPrices := 0;

                                              Tmp:=VarToStr(ItChildNode.Attributes['Rem']);
                                              Data^.Ost:=Tmp;

                                              if Tmp = 'Yes' then
                                                  begin
                                                    Data^.Ost:='Есть в наличии';
                                                    Data^.ImageIndex:=2;
                                                    Data^.Status:=True;
                                                  end
                                                else
                                                  begin
                                                      if Tmp = 'No' then
                                                        begin
                                                          Data^.Ost:='Нет в наличии';
                                                          Data^.ImageIndex:=3;
                                                          Data^.Status:=False;
                                                        end
                                                      else
                                                        begin
                                                          if Tmp = '?' then
                                                            begin
                                                              Data^.Ost:='Уточняйте наличие';
                                                              Data^.ImageIndex:=11;
                                                              Data^.Status:=False;
                                                            end
                                                          else
                                                            begin
                                                              if StrToInt(Tmp) > 0 then
                                                                  begin
                                                                    Data^.ImageIndex:=2;
                                                                    Data^.Status:=True;
                                                                  end
                                                                else
                                                                  begin
                                                                    Data^.ImageIndex:=3;
                                                                    Data^.Status:=False;
                                                                  end;
                                                            end;
                                                        end;
                                                  end;

                                              Tmp:=VarToStr(ItChildNode.Attributes['CntinP']);
                                              Data^.CntInP:=Tmp;

                                              TmpVar :=ItChildNode.Attributes['FSTR'];

                                              if TmpVar <> null then
                                                  begin
                                                    Tmp:=VarToStr(TmpVar);

                                                    TmpArr:=Explode(Tmp, ';');

                                                    try
                                                      if Length(TmpArr) = 2 then
                                                          begin
                                                            if Length(TmpArr[0]) > 0 then
                                                                begin
                                                                  Data^.OEMNum:=Explode(TmpArr[0], '@');
                                                                end;

                                                                if Length(TmpArr[1]) > 0 then
                                                                begin
                                                                  Data^.RefNum:=Explode(TmpArr[1], '@');
                                                                end;
                                                          end;

                                                      SetLength(TmpArr, 0);
                                                    except

                                                    end
                                                  end;
                                            end;
                                      end;
                                end;
                          end;
                      end;
                  end;
            end;

            VSTree.EndUpdate;
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

function LoadSDPDoc(var VSTree: TVirtualStringTree; const FileName: string; var xTvInf : TvInfo) : bool;
var
  i, k, l, x      : integer;
  Tmp             : string;
  Data            : PTreeData;
  XNode           : PVirtualNode;
  XdNode          : PVirtualNode;
  XMLDocument     : TXMLDocument;
  GrChildNode     : IXMLNode;
  ItChildNode     : IXMLNode;
  TmpArr          : exparr;
  TmpVar          : Variant;
  A, B, C, D, XD  : string;
begin
  try
    if GetXMLDoc(XMLDocument, FileName) then
        begin
          VSTree.BeginUpdate;
          VSTree.Clear;

          try
            for i := 0 to XMLDocument.ChildNodes.Count - 1 do
              begin
                  if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                    begin
                       if XMLDocument.ChildNodes.Nodes[i].NodeName = 'SDP' then
                        begin
                          xTvInf.VersionTovars:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['UTD']);
                          xTvInf.Kurs:=StrToFloat(VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['K']));

                          A:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['A']);
                          B:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['B']);
                          C:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['C']);
                          D:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['D']);

                          Tmp:='';

                          for x := 0 to 32 do
                            begin
                              Tmp:=VarToStr(XMLDocument.ChildNodes.Nodes[i].Attributes['A' + IntToStr(x)]);

                              if Tmp <> '' then
                              begin
                                XD:=XD + Tmp + '!@!';
                                Tmp:='';
                              end;

                            end;

                          SaveInfoXML(ExtractFileDir(FileName), A, B, C, D, XD);

                          for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                            begin
                              GrChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                              if GrChildNode.NodeName = 'Gr' then
                                  begin
                                     Tmp:=VarToStr(GrChildNode.Attributes['C']);

                                     XNode:=VSTree.AddChild(nil);

                                     Data := VSTree.GetNodeData(Xnode);
                                     Data^.Name:= Tmp;
                                     Data^.Root:=True;

                                     Data^.ImageIndex:=0;

                                      for l := 0 to GrChildNode.ChildNodes.Count - 1 do
                                        begin
                                          ItChildNode:= GrChildNode.ChildNodes[l];

                                          if ItChildNode.NodeName = 'I' then
                                              begin
                                                XdNode := VSTree.AddChild(XNode);
                                                Data := VSTree.GetNodeData(Xdnode);

                                                Data^.Root:=False;

                                                Tmp:=VarToStr(ItChildNode.Attributes['MR']);
                                                Data^.MinR:=StrToIntDef(Tmp, 1);

                                                Tmp:=VarToStr(ItChildNode.Attributes['D']);
                                                Data^.Name:= Tmp;

                                                Data^.NameNS:= StringReplace(Tmp, ' ', '', [rfReplaceAll]);

                                                Tmp:=VarToStr(ItChildNode.Attributes['C']);
                                                Data^.Code:=Tmp;

                                                Tmp:=VarToStr(ItChildNode.Attributes['E']);
                                                Data^.TecDOC:=Tmp;

                                                Tmp:=VarToStr(ItChildNode.Attributes['F']);
                                                Data^.BC:=Tmp;

                                                //ThousandSeparator:=''';
                                                FormatSettings.CurrencyString:='';

                                                //Tmp:=VarToStr(ItChildNode.Attributes['Disc']);
                                                //if (Tmp <> '') and (Tmp <> '0') then
                                                //    Data^.Disc:=Tmp + ' %'
                                                //  else
                                                //    Data^.Disc:='';

                                                Tmp:=VarToStr(ItChildNode.Attributes['P1']);
                                                //Data^.Cost1Dbl:=StrToFloatDef(Tmp, 0);
                                                Data^.Cost1DblOr:=RoundTo(StrToFloatDef(Tmp, 0), -2);
                                                //Data^.Cost1:=FloatToStrF(Data^.Cost1Dbl, ffCurrency, 12, 0);

                                                Tmp:=VarToStr(ItChildNode.Attributes['P2']);
                                                //Data^.Cost2Dbl:=StrToFloatDef(Tmp, 0);
                                                Data^.Cost2DblOr:=RoundTo(StrToFloatDef(Tmp, 0), -2);
                                                //Data^.Cost2:=FloatToStrF(Data^.Cost2Dbl, ffCurrency, 12, 3);

                                                TmpVar :=ItChildNode.Attributes['DP'];

                                                if TmpVar <> null then
                                                    begin
                                                      Tmp:=VarToStr(TmpVar);

                                                      try
                                                        Data^.DynOfPrices := StrToInt(Tmp);
                                                      except
                                                        Data^.DynOfPrices := 0;
                                                      end;
                                                    end
                                                else  Data^.DynOfPrices := 0;

                                                Data^.Ost:='???';
                                                Data^.ImageIndex:=11;
                                                Data^.Status:=False;

                                                //Tmp:=VarToStr(ItChildNode.Attributes['Rem']);
                                                //Data^.Ost:=Tmp;

  //                                              if Tmp = 'Yes' then
  //                                                  begin
  //                                                    Data^.Ost:='Есть в наличии';
  //                                                    Data^.ImageIndex:=2;
  //                                                    Data^.Status:=True;
  //                                                  end
  //                                                else
  //                                                  begin
  //                                                      if Tmp = 'No' then
  //                                                        begin
  //                                                          Data^.Ost:='Нет в наличии';
  //                                                          Data^.ImageIndex:=3;
  //                                                          Data^.Status:=False;
  //                                                        end
  //                                                      else
  //                                                        begin
  //                                                          if Tmp = '?' then
  //                                                            begin
  //                                                              Data^.Ost:='Уточняйте наличие';
  //                                                              Data^.ImageIndex:=11;
  //                                                              Data^.Status:=False;
  //                                                            end
  //                                                          else
  //                                                            begin
  //                                                              if StrToInt(Tmp) > 0 then
  //                                                                  begin
  //                                                                    Data^.ImageIndex:=2;
  //                                                                    Data^.Status:=True;
  //                                                                  end
  //                                                                else
  //                                                                  begin
  //                                                                    Data^.ImageIndex:=3;
  //                                                                    Data^.Status:=False;
  //                                                                  end;
  //                                                            end;
  //                                                        end;
  //                                                  end;

                                                Tmp:=VarToStr(ItChildNode.Attributes['CP']);
                                                Data^.CntInP:=Tmp;

                                                TmpVar :=ItChildNode.Attributes['FSTR'];

                                                if TmpVar <> null then
                                                    begin
                                                      Tmp:=VarToStr(TmpVar);

                                                      TmpArr:=Explode(Tmp, ';');

                                                      try
                                                        if Length(TmpArr) = 2 then
                                                            begin
                                                              if Length(TmpArr[0]) > 0 then
                                                                  begin
                                                                    Data^.OEMNum:=Explode(TmpArr[0], '@');
                                                                  end;

                                                                  if Length(TmpArr[1]) > 0 then
                                                                  begin
                                                                    Data^.RefNum:=Explode(TmpArr[1], '@');
                                                                  end;
                                                            end;

                                                        SetLength(TmpArr, 0);
                                                      except

                                                      end
                                                    end;
                                              end;
                                        end;

                                    //XNode.
                                    //VSTree.Sort(XNode, 0, VirtualTrees.sdAscending);
                                  end;
                            end;
                        end;
                    end;
              end;

              VSTree.EndUpdate;
              Result:=True;
          except on E : Exception do
            begin
              MessageDlg('Ошибка открытия файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
              Result:=False;
            end;
          end;

          //XMLDocument.Free;
        end
      else
        begin
          Result:=False;
        end;
  finally
    FreeAndNil(XMLDocument);
  end;
end;

function LoadArrearageFile(var AdvOutlookList: TAdvOutlookList; var ArrOutlookList : TOtGr; const SourceFile: string; DestFile : string) : bool;
begin
  Result:=False;

  if LoadArrearageDocEx(ArrOutlookList, SourceFile) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadArrearageDocEx(ArrOutlookList, DestFile) then
                  begin
                    FillDocEx(AdvOutlookList, ArrOutlookList);
                    Result:=True;
                  end;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            LoadArrearageDocEx(ArrOutlookList, DestFile);

        Result:=False;
      end;
end;

{function LoadArrearageDoc(var AdvOutlookList: TAdvOutlookList; const FileName: string) : bool;
var
  i, k, l       : integer;
  Tmp           : string;

  XMLDocument   : TXMLDocument;

  olg           : TOutlookGroup;
  sl            : TStrings;

  ItChildNode   : IXMLNode;
  GrChildNode   : IXMLNode;
begin
  if GetXMLDoc(XMLDocument, FileName) then
      begin
        AdvOutlookList.BeginUpdate;
        AdvOutlookList.ClearGroups;

        try
          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Arrearage' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Group' then
                                begin
                                  GrChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                   Tmp:=VarToStr(GrChildNode.Attributes['Name']);
                                   Tmp:=Tmp + ' (УНН ' +VarToStr(GrChildNode.Attributes['UNN']) + ') ';
                                   Tmp:=Tmp + ' (' +VarToStr(GrChildNode.Attributes['Address']) + ')';

                                   olg := advoutlooklist.AddGroup(Tmp);

                                    for l := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes.Count - 1 do
                                      begin
                                        if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes[l].NodeName = 'Item' then
                                            begin
                                              ItChildNode:=GrChildNode.ChildNodes[l];

                                              sl := AdvOutlookList.AddItem(olg);

                                              Tmp:=VarToStr(ItChildNode.Attributes['Date']);
                                              sl.Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['Sum']);
                                              sl.Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['ArSum']);
                                              sl.Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['DateExp']);
                                              sl.Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['Doc']);
                                              sl.Add(Tmp);
                                            end;
                                      end;
                                end;
                          end;
                      end;
                  end;
            end;

            AdvOutlookList.CollapseAll;

            AdvOutlookList.EndUpdate;
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
end; }

function LoadArrearageDocEx(var AdvOutlookList : TOtGr; const FileName: string) : bool;
var
  i, k, l, Ln   : integer;
  Tmp           : string;

  XMLDocument   : TXMLDocument;

  //olg           : TOtGrIt;
  //sl            : TStrings;

  ItChildNode   : IXMLNode;
  GrChildNode   : IXMLNode;

  Cnt           : integer;
begin
  if GetXMLDoc(XMLDocument, FileName) then
      begin
        SetLength(AdvOutlookList, 0);

        try
          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Arrearage' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Group' then
                                begin
                                  GrChildNode:=XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                   Tmp:=VarToStr(GrChildNode.Attributes['Name']);
                                   Tmp:=Tmp + ' (УНН ' +VarToStr(GrChildNode.Attributes['UNN']) + ') ';
                                   Tmp:=Tmp + ' (' +VarToStr(GrChildNode.Attributes['Address']) + ')';

                                   Ln:=Length(AdvOutlookList);
                                   SetLength(AdvOutlookList, Ln + 1);

                                   AdvOutlookList[Ln].Caption:=Tmp;

                                   for l := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes.Count - 1 do
                                      begin
                                        if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].ChildNodes[l].NodeName = 'Item' then
                                            begin
                                              ItChildNode:=GrChildNode.ChildNodes[l];

                                              Cnt := Length(AdvOutlookList[Ln].Items);
                                              SetLength(AdvOutlookList[Ln].Items, Cnt + 1);

                                              AdvOutlookList[Ln].Items[Cnt]:=TStringList.Create;

                                              Tmp:=VarToStr(ItChildNode.Attributes['Date']);
                                              AdvOutlookList[Ln].Items[cnt].Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['Sum']);
                                              AdvOutlookList[Ln].Items[Cnt].Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['ArSum']);
                                              AdvOutlookList[Ln].Items[Cnt].Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['DateExp']);
                                              AdvOutlookList[Ln].Items[Cnt].Add(Tmp);
                                              Tmp:=VarToStr(ItChildNode.Attributes['Doc']);
                                              AdvOutlookList[Ln].Items[Cnt].Add(Tmp);

                                              //Inc(Cnt);
                                            end;
                                      end;

                                      //ShowMessage(AdvOutlookList[Ln].Items.Text);
                                end;
                          end;
                      end;
                  end;
            end;

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

function LoadSalesFile(var vrtlstrngtr : TVirtualStringTree; const SourceFile: string; DestFile : string) : bool;
begin
  Result:=False;

  if LoadSalesDoc(vrtlstrngtr, SourceFile) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if LoadSalesDoc(vrtlstrngtr, DestFile) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            if LoadSalesDoc(vrtlstrngtr, DestFile) then
                begin
                  Result:=True;
                end
              else
                begin
                  Result:=False;
                end;
      end;
end;

function LoadSalesDoc(var vrtlstrngtr : TVirtualStringTree; const FileName: string) : bool;
var
  i, k, l, y, Ind  : integer;
  Tmp               : string;

  Data              : PSale;
  XNode             : PVirtualNode;
  XdNode            : PVirtualNode;
  ItenXdNode        : PVirtualNode;

  XMLDocument       : TXMLDocument;

  GrChildNode       : IXMLNode;
  Gr2ChildNode      : IXMLNode;
  ItChildNode       : IXMLNode;
begin
  if GetXMLDoc(XMLDocument, FileName) then
      begin
        vrtlstrngtr.BeginUpdate;
        vrtlstrngtr.Clear;

        try
          for i := 0 to XMLDocument.ChildNodes.Count - 1 do
            begin
                if XMLDocument.ChildNodes.Nodes[i].NodeType = ntElement then
                  begin
                     if XMLDocument.ChildNodes.Nodes[i].NodeName = 'Sales' then
                      begin
                        for k := 0 to XMLDocument.ChildNodes.Nodes[i].ChildNodes.Count - 1 do
                          begin
                            if XMLDocument.ChildNodes.Nodes[i].ChildNodes[k].NodeName = 'Group' then
                                begin
                                  GrChildNode:= XMLDocument.ChildNodes.Nodes[i].ChildNodes[k];

                                   Tmp:=VarToStr(GrChildNode.Attributes['Name']);
                                   Tmp:=Tmp + ' (УНН ' +VarToStr(GrChildNode.Attributes['UNN']) + ') ';
                                   Tmp:=Tmp + ' (' +VarToStr(GrChildNode.Attributes['Address']) + ')';

                                   XNode:=vrtlstrngtr.AddChild(nil);

                                   Data := vrtlstrngtr.GetNodeData(Xnode);
                                   Data^.Name:= Tmp;
                                   Data^.Root:=True;

                                   Data^.ImageIndex:=4;

                                   Ind:=1;

                                    for l := 0 to GrChildNode.ChildNodes.Count - 1 do
                                      begin
                                        Gr2ChildNode:=GrChildNode.ChildNodes[l];

                                        if Gr2ChildNode.NodeName = 'Group' then
                                            begin
                                              XdNode  := vrtlstrngtr.AddChild(XNode);
                                              Data    := vrtlstrngtr.GetNodeData(Xdnode);

                                              Data^.Root:=False;

                                              Tmp:=VarToStr(Gr2ChildNode.Attributes['Name']);

                                              Data^.Name:=Tmp;

                                              for y := 0 to Gr2ChildNode.ChildNodes.Count - 1 do
                                                begin
                                                  ItChildNode:=Gr2ChildNode.ChildNodes[y];

                                                  if ItChildNode.NodeName = 'Item' then
                                                      begin
                                                        ItenXdNode:= vrtlstrngtr.AddChild(XdNode);
                                                        Data      := vrtlstrngtr.GetNodeData(ItenXdNode);

                                                        Data^.Root:=False;
                                                        Data^.ImageIndex:=8;

                                                        Tmp:=VarToStr(ItChildNode.Attributes['Date']);
                                                        Data^.Date:=Tmp;

                                                        Tmp:=VarToStr(ItChildNode.Attributes['Sum']);
                                                        Data^.Sum:=Tmp;

                                                        Tmp:=VarToStr(ItChildNode.Attributes['DateExp']);
                                                        Data^.DateExp:=Tmp;

                                                        Tmp:=VarToStr(ItChildNode.Attributes['Doc']);
                                                        Data^.Doc:=Tmp;

                                                        Data^.Name := IntToStr(Ind);
                                                        inc(Ind);
                                                      end;

                                                end;

                                            end;
                                      end;
                                end;
                          end;
                      end;
                  end;
            end;

            vrtlstrngtr.EndUpdate;

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

function LoadClientsFile(var ClList : ClientSR; const SourceFile: string; DestFile : string) : bool;
begin
  if ClList.LoadClients(SourceFile) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if ClList.LoadClients(DestFile) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            ClList.LoadClients(DestFile);
        Result:=False;
      end;
end;

function LoadTypeSalFile(var MainRequests : TRequests; const SourceFile: string; DestFile : string) : bool;
begin
  if MainRequests.LoadTypeSal(SourceFile) then
      begin
        if CopyFileTo(SourceFile, DestFile) then
            begin
              if MainRequests.LoadTypeSal(DestFile) then
                  Result:=True
                else
                  Result:=False;
            end
          else
            Result:=False;
      end
    else
      begin
        if FileExists(DestFile) then
            MainRequests.LoadTypeSal(DestFile);

        Result:=False;
      end;
end;

end.
