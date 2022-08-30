unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMenus, AdvMenuStylers, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, AdvToolBar, AdvAppStyler, AdvToolBarStylers,
  ImgList, AdvPageControl, ComCtrls, AdvOfficePager, AdvOfficePagerStylers,
  RzTreeVw, TreeList, ExtCtrls, RzPanel, RzSplit, VirtualTrees, StdCtrls, XPMan,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ActiveX,
  IdExplicitTLSClientServerBase, IdFTP, IOUtils, ZipMstr19, IdGlobalProtocols,
  xmldom, XMLIntf, msxmldom, XMLDoc, CheckLst, IdAntiFreezeBase, IdAntiFreeze,
  AdvPanel, RzListVw, RzCommon, {HTMLUn2, HtmlView,} Utils, IdThreadComponent,
  LoadDoc, MyTypes, {FramView, FramBrwz,} RzForms, RzTray, RzLaunch,
  AdvOutlookList, AdvTreeComboBox, Mask, AdvDropDown, AdvControlDropDown,
  AdvTimePickerDropDown, AdvCalculatorDropdown, AdvMemoDropDown, AdvGrid,
  AsgLinks, AdvDateTimePicker, RzStatus, AdvGlowButton, AdvOfficeSelectors,
  IdZLibCompressorBase, IdCompressorZLib, IDZlib, IdZLibHeaders, IdGlobal, IdHash,
  IdHashMessageDigest, RequisitionClass, OutlookGroupedList, AdvEdit, RzEdit,
  RzSpnEdt, Clients, AdvMultiColumnDropDown, IniFiles, TaskDialog, RzBtnEdt,
  OleCtrls, SHDocVw, AppEvnts{, ShellAPI}, MyConst, FindCompare, ShellAPI,
  WinInet, IdCustomTransparentProxy, IdConnectThroughHttpProxy, IdIOHandlerSocket,
  IdSocks, DateUtils, Registry, IdMultipartFormData, IdHTTP, IdCookieManager,
  EncdDecd, JwaWinCrypt, idURI, Exchange, JvDebugHandler, AdvOfficeHint, AdvHintInfo,
  Math, ComObj;

type
  TUtilityEx = class(TOutlookGroup)
  end;

type
  TMainForm = class(TForm)
    AdvMainMenu1: TAdvMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    AdvMenuOfficeStyler1: TAdvMenuOfficeStyler;
    AdvOfficeStatusBar1: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    AdvDockPanel1: TAdvDockPanel;
    AdvToolBar1: TAdvToolBar;
    AdvAppStyler1: TAdvAppStyler;
    AdvToolBarOfficeStyler1: TAdvToolBarOfficeStyler;
    btnUpdate: TAdvToolBarMenuButton;
    ImageList1: TImageList;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    AdvOfficePager1: TAdvOfficePager;
    TovarPage: TAdvOfficePage;
    ReqPage: TAdvOfficePage;
    ArrPager: TAdvOfficePage;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    AdvToolBarMenuButton2: TAdvToolBarMenuButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    RzSizePanel1: TRzSizePanel;
    SystemImages: TImageList;
    VST: TVirtualStringTree;
    XPManifest1: TXPManifest;
    IdFTP1: TIdFTP;
    RzSplitter1: TRzSplitter;
    ImageList2: TImageList;
    AdvPanelStyler1: TAdvPanelStyler;
    AdvPanel2: TAdvPanel;
    AdvToolBar2: TAdvToolBar;
    btnAdvToolBarAddReq: TAdvToolBarMenuButton;
    AdvToolBarMenuButton4: TAdvToolBarMenuButton;
    RzRegIniFile1: TRzRegIniFile;
    InfoPage: TAdvOfficePage;
    AdvPopupMenu: TAdvPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    RzFormState1: TRzFormState;
    RzTrayIcon1: TRzTrayIcon;
    RzLauncher1: TRzLauncher;
    lstArr: TAdvOutlookList;
    ImageList: TImageList;
    AdvPanel1: TAdvPanel;
    RzGroupBox1: TRzGroupBox;
    AdvDateTimePicker1: TAdvDateTimePicker;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    Memo1: TMemo;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane6: TRzStatusPane;
    RzStatusPane8: TRzStatusPane;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    AdvToolBarMenuButton7: TAdvToolBarMenuButton;
    ListReq: TAdvOutlookList;
    RzNumericEdit1: TRzNumericEdit;
    AdvToolBarMenuButton8: TAdvToolBarMenuButton;
    TovarsList: TAdvOutlookList;
    DiscountSpinEdit: TRzSpinEdit;
    AdvToolBarMenuButton5: TAdvToolBarMenuButton;
    ClientsPage: TAdvOfficePage;
    AdvOutlookList1: TAdvOutlookList;
    AdvToolBarMenuButton6: TAdvToolBarMenuButton;
    ClientsDropDown: TAdvMultiColumnDropDown;
    PointDropDown: TAdvMultiColumnDropDown;
    XMLDocument1: TXMLDocument;
    AdvInputTaskDialog1: TAdvInputTaskDialog;
    OpenDialog1: TOpenDialog;
    RzPanel1: TRzPanel;
    WebBrowser: TWebBrowser;
    ApplicationEvents1: TApplicationEvents;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    AddTovar: TAdvToolBarMenuButton;
    advtlbrsprtr1: TAdvToolBarSeparator;
    btnExpandAllbtn: TAdvToolBarMenuButton;
    btnCollapsAll: TAdvToolBarMenuButton;
    edtSearch: TRzEdit;
    advtlbrsprtr2: TAdvToolBarSeparator;
    btnSearchType: TAdvToolBarMenuButton;
    advpmnSearchType: TAdvPopupMenu;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    rzvrsnf1: TRzVersionInfo;
    TypeDropDown: TAdvMultiColumnDropDown;
    N23: TMenuItem;
    SalesPage: TAdvOfficePage;
    vrtlstrngtr1: TVirtualStringTree;
    advpmnTvReq: TAdvPopupMenu;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    advpmn1: TAdvPopupMenu;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    btnAddReq: TAdvToolBarMenuButton;
    advtlbrsprtr3: TAdvToolBarSeparator;
    lst1: TAdvOutlookList;
    rzglyphsts1: TRzGlyphStatus;
    btnNotify: TAdvToolBarButton;
    advpmn2: TAdvPopupMenu;
    N31: TMenuItem;
    N32: TMenuItem;
    N110: TMenuItem;
    N33: TMenuItem;
    N301: TMenuItem;
    edt1: TRzSpinEdit;
    btn3: TAdvToolBarMenuButton;
    N34: TMenuItem;
    N35: TMenuItem;
    rzprprtystr1: TRzPropertyStore;
    excel1: TMenuItem;
    dlgOpen1: TOpenDialog;
    pm1: TPopupMenu;
    N36: TMenuItem;
    N38: TMenuItem;
    tmr1: TTimer;
    idckmngr1: TIdCookieManager;
    idcmprsrzlb1: TIdCompressorZLib;
    idhtp1: TIdHTTP;
    idntfrz1: TIdAntiFreeze;
    tmrUpdInfo: TTimer;
    btn4: TAdvToolBarButton;
    advtlbrsprtr4: TAdvToolBarSeparator;
    jvdbghndlr1: TJvDebugHandler;
    idthrdcmpnt1: TIdThreadComponent;
    btnCloneReq: TAdvToolBarButton;
    advfchnt1: TAdvOfficeHint;
    advfcpgWait: TAdvOfficePage;
    advpnl1: TAdvPanel;
    advtlbr1: TAdvToolBar;
    btnDeleteFrWaitList: TAdvToolBarButton;
    vrtlstrngtrWait: TVirtualStringTree;
    btn2: TAdvToolBarButton;
    pm2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    tmrWait: TTimer;
    N37: TMenuItem;
    excel2: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure AdvToolBarMenuButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure VSTGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure VSTFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure VSTFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure VSTGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure btnUpdateClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure VSTPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
    procedure VSTDblClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AdvPopupMenuPopup(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OnMyException(Sender: TObject; E: Exception);
    procedure N6Click(Sender: TObject);
    procedure VSTBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure AdvToolBarMenuButton7Click(Sender: TObject);
    procedure ListReqDrawItemProp(Sender: TObject; Item: POGLItem;
      Column: Integer; AValue: string; ABrush: TBrush; AFont: TFont);
    procedure btnAdvToolBarAddReqClick(Sender: TObject);

    function LoadKey(FileName : string) : bool;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TovarsListKeyPress(Sender: TObject; var Key: Char);
    procedure OnRlSelect(Status : integer);
    procedure AdvToolBarMenuButton4Click(Sender: TObject);
    procedure AdvToolBarMenuButton5Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure ShowPages;
    procedure AddTovarClick(Sender: TObject);
    procedure btnExpandAllbtnClick(Sender: TObject);
    procedure btnCollapsAllClick(Sender: TObject);
    function  xcheck : Boolean;
    procedure edtSearchChange(Sender: TObject);
    procedure advpmnSearchTypePopup(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure vrtlstrngtr1GetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vrtlstrngtr1GetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vrtlstrngtr1GetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure VSTKeyPress(Sender: TObject; var Key: Char);
    procedure AdvOfficePager1Change(Sender: TObject);
    procedure advpmnTvReqPopup(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure DiscountSpinEditKeyPress(Sender: TObject; var Key: Char);
    procedure N24Click(Sender: TObject);
    procedure advpmn1Popup(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure vrtlstrngtr1KeyPress(Sender: TObject; var Key: Char);
    procedure lstArrKeyPress(Sender: TObject; var Key: Char);
    procedure AdvOutlookList1KeyPress(Sender: TObject; var Key: Char);
    procedure VSTFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure lst1DrawItemProp(Sender: TObject; Item: POGLItem; Column: Integer;
      AValue: string; ABrush: TBrush; AFont: TFont);
    procedure lst1KeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure advpmn2Popup(Sender: TObject);
    procedure ListReqGroupCollaps(Sender: TObject; Item: POGLItem);
    procedure TovarsListGroupCollaps(Sender: TObject; Item: POGLItem);
    procedure edt1Change(Sender: TObject);
    procedure TovarsListItemDblClick(Sender: TObject; Item: POGLItem;
      Column: Integer);
    procedure N35Click(Sender: TObject);
    procedure edt1KeyPress(Sender: TObject; var Key: Char);
    procedure TovarsListItemClick(Sender: TObject; Item: POGLItem;
      Column: Integer);
    procedure rzglyphsts1Click(Sender: TObject);
    function GetTovarMinR(Code : integer) : integer;
    procedure UpdDateL(datestr : string);
    procedure excel1Click(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure tmrUpdInfoTimer(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure ChangeColN(Sender: TObject);
    procedure idthrdcmpnt1Run(Sender: TIdThreadComponent);
    procedure WebBrowserBeforeNavigate2(ASender: TObject;
      const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
      Headers: OleVariant; var Cancel: WordBool);
    procedure btnCloneReqClick(Sender: TObject);
    procedure VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure VSTHeaderClick(Sender: TVTHeader; HitInfo: TVTHeaderHitInfo);
    procedure vrtlstrngtrWaitChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vrtlstrngtrWaitFocusChanging(Sender: TBaseVirtualTree; OldNode,
      NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
      var Allowed: Boolean);
    procedure vrtlstrngtrWaitFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vrtlstrngtrWaitGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vrtlstrngtrWaitGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vrtlstrngtrWaitGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: string);
    procedure AdvOfficeStatusBar1Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnDeleteFrWaitListClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure pm2Popup(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure tmrWaitTimer(Sender: TObject);
    procedure btnAddReqClick(Sender: TObject);
    procedure ListReqCustomCompare(Sender: TObject; Item1, Item2: POGLItem;
      Column: Integer; Value1, Value2: string; var SortResult: Integer);
    procedure excel2Click(Sender: TObject);
  private

  public
    ZipMaster1       : TZipMaster19;
    TmpDir           : string;
    DataDir          : string;
    fDir             : string;
    UpdateIndx       : integer;
    Cash             : integer;
    NoDisc           : integer;
    FileList         : Array[0..7] of string;
    IDClient         : string;
    MainRequests     : TRequests;
    TvInf            : TvInfo;
    ClList           : ClientSR;
    Settings         : TProgrammSettings;
    IVessions        : TVersions;
    YVessions        : TVersions;
    IFileVersions    : TFileVersions;
    YFileVersions    : TFileVersions;
    ArrOutlookList   : TOtGr;
    UpdateAvalible   : Boolean;
    ExeMD5           : string;

    TvSearcT         : string;
    LastActPage      : Integer;
    CancelSearch     : Boolean;
    VSTSortDirection : VirtualTrees.TSortDirection;
    GLAv, GLUnAv     : Integer;
  end;

var
  MainForm: TMainForm;
  {NewNode:TNameNode;
  Node:PVirtualNode;
  count:integer; }

implementation

uses
  Splash, AddUnit, Settings, About, Update;

{$R *.dfm}

function StrCmpLogicalW(psz1, psz2: PWideChar): Integer; stdcall;
  external 'shlwapi.dll';

function StrCmpLogical(const s1, s2: string): Integer;
begin
  Result := StrCmpLogicalW(PChar(s1), PChar(s2));
end;

procedure TMainForm.AddTovarClick(Sender: TObject);
begin
  if AdvOfficePager1.ActivePageIndex = 1 then
      begin
        VSTDblClick(VST);
      end;

  if AdvOfficePager1.ActivePageIndex = 6 then
      begin
        VSTDblClick(vrtlstrngtrWait);
      end;

  if (AdvOfficePager1.ActivePageIndex <> 1) and (AdvOfficePager1.ActivePageIndex <> 6) then
      AdvOfficePager1.ActivePageIndex := 1;
end;

//procedure TMainForm.advfchnt1BeforeShowHint(Sender: TObject; AControl: TControl;
//  AHintInfo: TAdvHintInfo; var UseOfficeHint: Boolean);
//begin
////  if AControl.ClassType = TAdvToolBarMenuButton then
////  begin
////    UseOfficeHint := true;
////    //AHintInfo.Title := 'Button title';
////    AHintInfo.Notes.Text := AControl.Hint;
////
////    AHintInfo.Picture.LoadFromFile(''); // optionally add a hint picture here from file, resource or stream
////  end;
//end;

procedure TMainForm.AdvOfficePager1Change(Sender: TObject);
begin
  if AdvOfficePager1.ActivePageIndex = 1 then
      begin
        btnSearchType.Enabled:=True;
        btn2.Enabled:=True;
        btn4.Enabled:=True;
      end
    else
      begin
        btnSearchType.Enabled:=False;
        btn2.Enabled:=False;
        btn4.Enabled:=False;
      end;

  if AdvOfficePager1.ActivePageIndex <> 0 then
      begin
        ///edtSearch.Text:='';
        if (LastActPage <> 1) and (AdvOfficePager1.ActivePageIndex = 1) then
          begin
            if edtSearch.Text <> TvSearcT then CancelSearch := True;
            edtSearch.Text:=TvSearcT;
          end;

        if AdvOfficePager1.ActivePageIndex <> 1 then
          begin
            if LastActPage = 1 then
              begin
                TvSearcT := edtSearch.Text;
              end;


            edtSearch.Text:='';
            edtSearchChange(Sender);
          end;
      end;

  if AdvOfficePager1.ActivePageIndex = 0 then
      begin
        //WebBrowser.SetFocus;
      end;

  LastActPage:= AdvOfficePager1.ActivePageIndex;

  if AdvOfficePager1.ActivePageIndex = 6 then
      begin
        tmrWait.Enabled :=False;
        advfcpgWait.ImageIndex:=64;
      end;
end;

procedure TMainForm.AdvOfficeStatusBar1Click(Sender: TObject);
begin
  //LoadWaitFile(VST, vrtlstrngtrWait, DataDir + 'WaitList.xml');
end;

procedure TMainForm.AdvOutlookList1KeyPress(Sender: TObject; var Key: Char);
var
  Control: TControl;
begin
  Control:=edtSearch;
  Control.Perform(WM_CHAR, Ord(Key), 0);
end;

procedure TMainForm.lstArrKeyPress(Sender: TObject; var Key: Char);
var
    Control: TControl;
begin
  Control:=edtSearch;
  Control.Perform(WM_CHAR, Ord(Key), 0);
end;

procedure TMainForm.MenuItem1Click(Sender: TObject);
begin
  VSTDblClick(vrtlstrngtrWait);
end;

procedure TMainForm.MenuItem2Click(Sender: TObject);
begin
  btnDeleteFrWaitListClick(Sender);
end;

procedure TMainForm.advpmnTvReqPopup(Sender: TObject);
begin
  advpmnTvReq.MenuStyler:=AdvMenuOfficeStyler1;
  if TovarsList.SelectedCount = 0 then
      begin
        N24.Visible:=False;
        N35.Visible:=False;
      end
    else
      begin
        N24.Visible:=True;
        N35.Visible:=True;
      end;
end;

procedure TMainForm.advpmn1Popup(Sender: TObject);
begin
  advpmn1.MenuStyler:=AdvMenuOfficeStyler1;
  if ListReq.SelectedCount = 0 then
      begin
        N27.Visible:=False;
        N28.Visible:=False;
        N29.Visible:=False;
      end
    else
      begin
        N27.Visible:=True;
        N28.Visible:=True;
        N29.Visible:=True;
      end;
end;

procedure TMainForm.advpmn2Popup(Sender: TObject);
begin
  advpmn2.MenuStyler:=AdvMenuOfficeStyler1;
end;

procedure TMainForm.advpmnSearchTypePopup(Sender: TObject);
begin
  advpmnSearchType.MenuStyler:=AdvMenuOfficeStyler1;
end;

procedure TMainForm.AdvPopupMenuPopup(Sender: TObject);
begin
  AdvPopupMenu.MenuStyler:=AdvMenuOfficeStyler1;
end;

procedure TMainForm.btnUpdateClick(Sender: TObject);
var
  XNode       : PVirtualNode;
  Data        : PTreeData;
  stream      : TFileStream;
  ExeName     : string;
  Fl          : TStrings;
  Filel       : TStrings;
  ADest       : TMemoryStream;
  i, k, J     : Integer;
  xRequest    : Request;
  finf        : exparr;
  Tmp, fstr,
  cstr        : string;
  FInfo       : TMemIniFile;
  TmpStrL     : TStringList;
  ProxyEnabled: boolean;
  ProxyServer : string;
  ProxyPort   : integer;
  names       : string;
  AnsArr      : exparr;
  Av, UnAv    : Integer;
begin
  btnUpdate.Enabled:=False;
  N23.Enabled:=False;

  UpdateForm.RzListView1.Clear;
  UpdateForm.AdvGlowButton2.Caption:='Отмена';
  UpdateForm.Show;

      try
        if not CheckAccessDir(TmpDir) then
            begin
              btnUpdate.Enabled:=True;
              Exit;
            end;

        if not CheckAccessDir(DataDir) then
            begin
              btnUpdate.Enabled:=True;
              Exit;
            end;

        PreDownload(xKey, Settings.ID, Settings.Dir,
                    Settings.Name + ' ' + Settings.LName,
                    idhtp1, IFileVersions, AnsArr,
                    rzvrsnf1.FileVersion, ExeMD5);

       if UpdateForm.Visible then
          begin
            if IFileVersions.ExeFile <> rzvrsnf1.FileVersion then
                if MessageDlg('Доступна новая версия программы. Обновить сейчас?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                    begin
                      ExeName:=ExtractFileName(Application.ExeName);

                      UpdateForm.RzListView1.AddItem('Обновление программы', nil);
                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add(FloatToStrF(IFileVersions.ExeFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                      names := LowerCase(StrToMD5Str(xKey + ExeName));

                      if DownloadFile(DownloadLink + names, TmpDir + ExeName, idhtp1) then
                        begin
                          RzLauncher1.FileName:=ExtractFileDir(Application.ExeName) + '\Updater.exe';

                          RzLauncher1.Parameters:='"' + Application.ExeName + '"';
                          RzLauncher1.Launch;
                          MessageDlg('Сейчас программа будет перезапущена.', mtConfirmation, [mbOk], 0);
                          Application.Terminate;
                          Exit;
                        end
                      else
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                        end;
                    end;
          end;

        if UpdateForm.Visible and (IFileVersions.InfoFile <> YFileVersions.InfoFile) then
            begin
              UpdateForm.RzListView1.AddItem('Информация', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add(FloatToStrF(IFileVersions.InfoFileSize / 1024, ffNumber, 6, 2) + ' Кб');

              names := LowerCase(StrToMD5Str(xKey + 'Info' + '.zip'));

              if DownloadFile(DownloadLink + names, TmpDir + 'Info' +'.zip', idhtp1) then
                  begin
                    if DirectoryExists(TmpDir + 'Info\') then TDirectory.Delete(TmpDir + 'Info\', True);

                    if CheckAccessDir(TmpDir + 'Info\') then
                        if ExtractZip(ZipMaster1, TmpDir + 'Info' + '.zip', TmpDir + 'Info\', '') then
                            begin
                              if CheckAccessDir(DataDir + 'Info\') then
                                  begin
                                    FullDirectoryCopy(TmpDir + 'Info\', DataDir + 'Info\', False, True);
                                  end;

                              Tmp:= DataDir + 'data' + '.xml';
                              Tmp:= DataDir + 'Info\' + 'data' + '.xml';

                              if FileExists(DataDir + 'data' + '.xml') then
                              CopyFileTo(DataDir + 'data' + '.xml', DataDir + 'Info\' + 'data' + '.xml');

                              WebBrowser.Navigate(DataDir + 'Info\Index.html');

                              InfoPage.TabVisible:=True;
                              AdvOfficePager1.ActivePageIndex:=0;

                              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                              YFileVersions.InfoFile := IFileVersions.InfoFile;

                              TDirectory.Delete(TmpDir + 'Info\', True);
                            end;
                    DeleteFile(TmpDir + 'Info' +'.zip');
                  end;

              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                  end;
            end;

        if UpdateForm.Visible and (IFileVersions.SplashFile <> YFileVersions.SplashFile) then
            begin
              UpdateForm.RzListView1.AddItem('Splash', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add(FloatToStrF(IFileVersions.SplashFileSize / 1024, ffNumber, 6, 2) + ' Кб');

              names := LowerCase(StrToMD5Str(xKey + 'Splash' + '.zip'));

              if DownloadFile(DownloadLink + names, TmpDir + 'Splash' +'.zip', idhtp1) then
                  begin
                    if ExtractZip(ZipMaster1, TmpDir + 'Splash' + '.zip', DataDir, '') then
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                          YFileVersions.SplashFile := IFileVersions.SplashFile;
                        end;
                    DeleteFile(TmpDir + 'Splash' + '.zip');
                  end;

              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                  end;
            end;

//        if UpdateForm.Visible and Settings.TvA then
//            begin
//              UpdateForm.RzListView1.AddItem('Товары', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.TvFile <> YFileVersions.TvFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.TvFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//                     names := LowerCase(StrToMD5Str(xKey + FileList[0] + '.zip'));
//
//                     if DownloadFile(DownloadLink + names, TmpDir + FileList[0] +'.zip', idhtp1) then
//                          begin
//                            if ExtractZip(ZipMaster1, TmpDir + FileList[0] + '.zip', TmpDir, '') then
//                                begin
//                                  LoadTvFile(VST, TmpDir + FileList[0] + '.xml', DataDir + FileList[0] + '.xml', TvInf);
//
//                                  RzNumericEdit1.Value:=TvInf.Kurs;
//
//                                  UpdDateL(TvInf.VersionTovars);
//
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                  YFileVersions.TvFile := IFileVersions.TvFile;
//                                  SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//                                  DeleteFile(TmpDir + FileList[0] + '.xml');
//
//                                  WebBrowser.Navigate(DataDir + 'Info\Index.html');
//
//                                  InfoPage.TabVisible:=True;
//                                  AdvOfficePager1.ActivePageIndex:=0;
//                                end;
//
//                            DeleteFile(TmpDir + FileList[0] +'.zip');
//                          end;
//
//                      if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                          begin
//                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                          end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;

        if UpdateForm.Visible and Settings.TvA then
            begin
              UpdateForm.RzListView1.AddItem('Товары', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.SDP <> YFileVersions.SDP) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.SDPFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                     names := LowerCase(StrToMD5Str(xKey + FileList[6] + '.zip'));

                     if DownloadFile(DownloadLink + names, TmpDir + FileList[6] +'.zip', idhtp1) then
                          begin
                            if ExtractZip(ZipMaster1, TmpDir + FileList[6] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                                begin
                                  LoadSDPFile(VST, TmpDir + FileList[6] + '.xml', DataDir + FileList[6] + '.xml', TvInf);

                                  RzNumericEdit1.Value:=TvInf.Kurs;

                                  UpdDateL(TvInf.VersionTovars);

                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                  YFileVersions.SDP := IFileVersions.SDP;
                                  SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                  DeleteFile(TmpDir + FileList[6] + '.xml');

                                  if (IFileVersions.Rest = YFileVersions.Rest) then
                                  begin
                                    if DirectoryExists(DataDir) then
                                      begin
                                        if FileExists(DataDir + 'Stock_rest.xml') then
                                            begin
                                              try
                                                LoadRestDoc(VST, DataDir + 'Stock_rest.xml', TvInf);
                                                UpdDateL(TvInf.VersionTovars);
                                              finally

                                              end;
                                            end;
                                      end;
                                  end;

                                  if (IFileVersions.Disc = YFileVersions.Disc) then
                                  begin
                                    if DirectoryExists(DataDir) then
                                      begin
                                        if FileExists(DataDir + 'Disc.xml') then
                                            begin
                                              try
                                                LoadDiscDoc(VST, DataDir + 'Disc.xml');
                                                CalculateCost(VST, NoDisc);
                                              finally

                                              end;
                                            end;
                                      end;
                                  end;

                                  WebBrowser.Navigate(DataDir + 'Info\Index.html');

                                  InfoPage.TabVisible:=True;
                                  AdvOfficePager1.ActivePageIndex:=0;
                                end;

                            DeleteFile(TmpDir + FileList[6] +'.zip');
                          end;

                      if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                          begin
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                          end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;

        if UpdateForm.Visible and Settings.TvA then
            begin
              UpdateForm.RzListView1.AddItem('Остатки', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.Rest <> YFileVersions.Rest) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.RestFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                     names := LowerCase(StrToMD5Str(xKey + FileList[5] + '.zip'));

                     if DownloadFile(DownloadLink + names, TmpDir + FileList[5] +'.zip', idhtp1) then
                          begin
                            if ExtractZip(ZipMaster1, TmpDir + FileList[5] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                                begin
                                  LoadRestFile(VST, TmpDir + FileList[5] + '.xml', DataDir + FileList[5] + '.xml', TvInf);

                                  //RzNumericEdit1.Value:=TvInf.Kurs;
                                  if FileExists(DataDir + 'WaitList.xml') then
                                      begin
                                        LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');
                                      end;

                                  //LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');

                                  if Av > GLAv then
                                      begin
                                        tmrWait.Enabled:=True;
                                        GLAv:=Av;
                                      end;

                                  UpdDateL(TvInf.VersionTovars);

                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                  YFileVersions.Rest := IFileVersions.Rest;
                                  SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                  DeleteFile(TmpDir + FileList[5] + '.xml');

                                  //WebBrowser.Navigate(DataDir + 'Info\Index.html');

                                  InfoPage.TabVisible:=True;
                                  AdvOfficePager1.ActivePageIndex:=0;
                                end;

                            DeleteFile(TmpDir + FileList[5] +'.zip');
                          end;

                      if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                          begin
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                          end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;

        if UpdateForm.Visible and Settings.TvA then
            begin
              UpdateForm.RzListView1.AddItem('Скидки', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.Disc <> YFileVersions.Disc) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.DiscFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                     names := LowerCase(StrToMD5Str(xKey + FileList[7] + '.zip'));

                     if DownloadFile(DownloadLink + names, TmpDir + FileList[7] +'.zip', idhtp1) then
                          begin
                            if ExtractZip(ZipMaster1, TmpDir + FileList[7] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                                begin
                                  LoadDiscFile(VST, TmpDir + FileList[7] + '.xml', DataDir + FileList[7] + '.xml');
                                  CalculateCost(VST, NoDisc);
                                  //RzNumericEdit1.Value:=TvInf.Kurs;

                                  //UpdDateL(TvInf.VersionTovars);

                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                  YFileVersions.Disc := IFileVersions.Disc;
                                  SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                  DeleteFile(TmpDir + FileList[7] + '.xml');

                                  //WebBrowser.Navigate(DataDir + 'Info\Index.html');

                                  InfoPage.TabVisible:=True;
                                  AdvOfficePager1.ActivePageIndex:=0;
                                end;

                            DeleteFile(TmpDir + FileList[7] +'.zip');
                          end;

                      if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                          begin
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                          end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;

        if UpdateForm.Visible and Settings.ArA then
            begin
              UpdateForm.RzListView1.AddItem('Долги', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.ArrFile <> YFileVersions.ArrFile) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.ArrFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                    names := LowerCase(StrToMD5Str(xKey + FileList[1] + '_Cr.zip'));

                    if DownloadFile(DownloadLink + names, TmpDir + FileList[1] +'.zip', idhtp1) then
                        begin
                          if ExtractZip(ZipMaster1, TmpDir + FileList[1] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                              begin
                                if LoadArrearageFile(lstArr, ArrOutlookList, TmpDir + FileList[1] + '.xml', DataDir + FileList[1] + '.xml') then
                                    begin
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                      YFileVersions.ArrFile := IFileVersions.ArrFile;
                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                      DeleteFile(TmpDir + FileList[1] + '.xml');
                                    end;
                              end;
                          DeleteFile(TmpDir + FileList[1] +'.zip');
                        end;

                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                        end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;

        if UpdateForm.Visible and Settings.SlA then
            begin
              UpdateForm.RzListView1.AddItem('Продажи', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.SalesFile <> YFileVersions.SalesFile) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.SalesFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                    names := LowerCase(StrToMD5Str(xKey + FileList[2] + '_Cr.zip'));

                     if DownloadFile(DownloadLink + names, TmpDir + FileList[2] +'.zip', idhtp1) then
                        begin
                          if ExtractZip(ZipMaster1, TmpDir + FileList[2] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                              begin
                                if LoadSalesFile(vrtlstrngtr1, TmpDir + FileList[2] + '.xml', DataDir + FileList[2] + '.xml') then
                                    begin
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                      YFileVersions.SalesFile := IFileVersions.SalesFile;
                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                      DeleteFile(TmpDir + FileList[2] + '.xml');
                                    end;
                              end;
                          DeleteFile(TmpDir + FileList[2] +'.zip');
                        end;

                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                        end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;


        if UpdateForm.Visible and Settings.SlA then
            begin
              UpdateForm.RzListView1.AddItem('Клиенты', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.ClientsFile <> YFileVersions.ClientsFile) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.ClientsFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                    names := LowerCase(StrToMD5Str(xKey + FileList[3] + '_Cr.zip'));

                    if DownloadFile(DownloadLink + names, TmpDir + FileList[3] +'.zip', idhtp1) then
                        begin
                          if ExtractZip(ZipMaster1, TmpDir + FileList[3] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
                              begin
                                if LoadClientsFile(ClList, TmpDir + FileList[3] + '.xml', DataDir + FileList[3] + '.xml') then
                                    begin
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                      YFileVersions.ClientsFile := IFileVersions.ClientsFile;
                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                                      WebBrowser.Navigate(DataDir + 'Info\Index.html');

                                      DeleteFile(TmpDir + FileList[3] + '.xml');
                                    end;
                              end;

                          DeleteFile(TmpDir + FileList[3] + '.zip');
                        end;

                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                        end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;

        if UpdateForm.Visible and Settings.SlA then
            begin
              UpdateForm.RzListView1.AddItem('Виды оплаты', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              if (IFileVersions.TpSalesFile <> YFileVersions.TpSalesFile) then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.TpSalesFileSize / 1024, ffNumber, 6, 2) + ' Кб');

                    names := LowerCase(StrToMD5Str(xKey + FileList[4] + '.xml'));

                    if DownloadFile(DownloadLink + names, TmpDir + FileList[4] +'.xml', idhtp1) then
                        begin
                          if LoadTypeSalFile(MainRequests, TmpDir + FileList[4] + '.xml', DataDir + FileList[4] + '.xml') then
                              begin
                                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;

                                YFileVersions.TpSalesFile := IFileVersions.TpSalesFile;
                                SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
                              end;

                          DeleteFile(TmpDir + FileList[4] + '.xml');
                        end;

                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                        begin
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                        end;
                  end
              else
                begin
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                end;
            end;


        if UpdateForm.Visible and Settings.SlA then
            begin
              UpdateForm.RzListView1.AddItem('Заявки', nil);
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');

              try
                ADest := TMemoryStream.Create;

                for i := 0 to Length(AnsArr) - 1 do
                  begin
                    Tmp:= ChangeFileExt(AnsArr[i], '');

                    if MainRequests.RecFound(Tmp) then
                        begin
                          if DownloadAnsFile(DownloadLink, AnsArr[i], idhtp1, ADest) then
                            if MainRequests.ParseReq(ADest, xRequest) then
                                begin
                                  if MainRequests.UpdateReq(xRequest) then
                                      begin
                                        DeleteAnsFile(DownloadLink, AnsArr[i], idhtp1);

                                        UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
                                        UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                                      end;
                                end;
                        end;
                  end;

                if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
                    begin
                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
                    end;
              except
                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
              end;

              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 0 then
                  begin
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
                  end;
            end;

        SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

        if UpdateForm.Visible then
            begin
              UpdateForm.Timer1.Enabled:=True;
              UpdateForm.AdvGlowButton2.Caption:='Закрыть';
            end;

      except on E : Exception do
        begin
          MessageDlg('Ошибка процесса обновления: ' + E.Message, mtError, [mbOK], 0);
          btnUpdate.Enabled:=True;
          N23.Enabled:=True;
          Exit;
        end;
      end;

  btnUpdate.Enabled:=True;
  N23.Enabled:=True;
  UpdateAvalible:=False;
  tmrUpdInfo.Enabled:=UpdateAvalible;
  btnUpdate.ImageIndex:=36;
end;

//procedure TMainForm.AdvToolBarMenuButton1Click(Sender: TObject);
//var
//  XNode     : PVirtualNode;
//  Data      : PTreeData;
//  stream    : TFileStream;
//
//  ExeName   : string;
//
//  Fl        : TStrings;
//  Filel     : TStrings;
//
//  ADest     : TStream;
//  i, k, J   : Integer;
//
//  xRequest  : Request;
//
//  finf      : exparr;
//
//  Tmp, fstr,
//  cstr      : string;
//
//  FInfo     : TMemIniFile;
//
//  TmpStrL   : TStringList;
//
//  ProxyEnabled: boolean;
//  ProxyServer : string;
//  ProxyPort   : integer;
//
//  fStream     : TMemoryStream;
//
//  Sl          : TStringList;
//begin
//  {GetProxyData(ProxyEnabled, ProxyServer, ProxyPort);
//
//  if ProxyEnabled then
//      begin
//        idFTP1.ProxySettings.ProxyType:= fpcmOpen;
//
//        idFTP1.ProxySettings.Host:= ProxyServer;
//        idFTP1.ProxySettings.Port:=ProxyPort;
//      end;}
//
//    //ShowMessage(ProxyServer + ':' + IntToStr(ProxyPort));
//
//
//  AdvToolBarMenuButton1.Enabled:=False;
//  N23.Enabled:=False;
//
//  if idFTP1.Connected then
//      idFTP1.Disconnect
//    else
//      try
//        idFTP1.Connect();
//      except on E : Exception do
//        begin
//          MessageDlg(ErrorConection + E.Message, mtError, [mbOK], 0);
//          AdvToolBarMenuButton1.Enabled:=True;
//          Exit;
//        end;
//      end;
//
//  UpdateForm.RzListView1.Clear;
//  UpdateForm.AdvGlowButton2.Caption:='Отмена';
//  UpdateForm.Show;
//
//  if idFTP1.Connected then
//    begin
//      try
//        //if not (fDir = '') then
//        idftp1.ChangeDir('/TAUpd/');
//
//        if not CheckAccessDir(TmpDir) then
//            begin
//              AdvToolBarMenuButton1.Enabled:=True;
//              Exit;
//            end;
//
//        if not CheckAccessDir(DataDir) then
//            begin
//              AdvToolBarMenuButton1.Enabled:=True;
//              Exit;
//            end;
//
//        if UpdateForm.Visible then
//            begin
//              if GetFile(idFTP1, 'Keys' + '.xml', TmpDir + 'Keys' +'.xml') then
//                  begin
//                    if not CheckKey(TmpDir + 'Keys' +'.xml', Settings.ID) then
//                      begin
//                        UpdateForm.Close;
//                        MessageDlg('Ваш ключ не прошел проверку. Обновление невозможно.', mtError, [mbOK], 0);
//                        DeleteFile(TmpDir + 'Keys' +'.xml');
//                        Exit;
//                      end;
//
//                      DeleteFile(TmpDir + 'Keys' +'.xml');
//                  end
//                else
//                  begin
//                    UpdateForm.Close;
//                    MessageDlg('Невозможно проверить подлинность ключа. Обновление невозможно.', mtError, [mbOK], 0);
//                    Exit;
//                  end;
//            end;
//
//        if UpdateForm.Visible then
//            begin
//              if GetFile(idFTP1, 'Version' + '.xml', TmpDir + 'Version' +'.xml') then
//                  begin
//                    IVessions:=GetVersions(TmpDir + 'Version' +'.xml');
//                    DeleteFile(TmpDir + 'Version' +'.xml');
//
//                    if IVessions.Exe <> rzvrsnf1.FileVersion then
//                       if MessageDlg('Доступна новая версия программы. Обновить сейчас?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//                          begin
//                            ExeName:=ExtractFileName(Application.ExeName);
//
//                            UpdateForm.RzListView1.AddItem('Обновление программы', nil);
//                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//
//                            if GetFile(idFTP1, ExeName, TmpDir + ExeName) then
//                                begin
//                                  RzLauncher1.FileName:=ExtractFileDir(Application.ExeName) + '\Updater.exe';
//                                  //ShowMessage(RzLauncher1.FileName);
//                                  RzLauncher1.Parameters:='"' + Application.ExeName + '"';
//                                  RzLauncher1.Launch;
//                                  MessageDlg('Сейчас программа будет перезапущена.', mtConfirmation, [mbOk], 0);
//                                  Application.Terminate;
//                                  Exit;
//                                end
//                              else
//                                begin
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                                end;
//                          end;
//                  end;
//            end;
//
//        Filel :=TStringList.Create;
//        IdFTP1.List(Filel, '*', True);
//
//        FInfo:=TMemIniFile.Create('');
//        TmpStrL:=TStringList.Create;
//
//        for k := 0 to Filel.Count - 1 do
//            begin
//              Tmp:='[FInfo]' + #13#10 + Filel[k];
//
//              Tmp  := StringReplace(Tmp, ';', #13#10,
//                           [rfReplaceAll, rfIgnoreCase]);
//
//              TmpStrL.Text:=Tmp;
//
//              FInfo.SetStrings(TmpStrL);
//
//              if FInfo.ReadString('FInfo', 'type', '') = 'file' then
//                  begin
//                    cstr:=LowerCase(('Info' + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.InfoFile    := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.InfoFileUnq := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.InfoFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//
//                    cstr:=LowerCase(('Splash' + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.SplashFile    := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.SplashFileUnq := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.SplashFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//                  end;
//            end;
//
//            FInfo.Free;
//            TmpStrL.Free;
//
//        if UpdateForm.Visible and (IFileVersions.InfoFile <> YFileVersions.InfoFile) then
//            begin
//              UpdateForm.RzListView1.AddItem('Информация', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add(FloatToStrF(IFileVersions.InfoFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//              if GetFile(idFTP1, 'Info' + '.zip', TmpDir + 'Info' +'.zip') then
//                  begin
//                    if DirectoryExists(TmpDir + 'Info\') then TDirectory.Delete(TmpDir + 'Info\', True);
//
//                    if CheckAccessDir(TmpDir + 'Info\') then
//                        if ExtractZip(ZipMaster1, TmpDir + 'Info' + '.zip', TmpDir + 'Info\') then
//                            begin
//                              //if DirectoryExists(DataDir + 'Info\') then TDirectory.Delete(DataDir + 'Info\', True);
//
//                              if CheckAccessDir(DataDir + 'Info\') then
//                                  begin
//                                    FullDirectoryCopy(TmpDir + 'Info\', DataDir + 'Info\', False, True);
//                                  end;
//
//                              Tmp:= DataDir + 'data' + '.xml';
//                              Tmp:= DataDir + 'Info\' + 'data' + '.xml';
//
//                              if FileExists(DataDir + 'data' + '.xml') then
//                              CopyFileTo(DataDir + 'data' + '.xml', DataDir + 'Info\' + 'data' + '.xml');
//
//                              WebBrowser.Navigate(DataDir + 'Info\Index.html');
//
//                              InfoPage.TabVisible:=True;
//                              AdvOfficePager1.ActivePageIndex:=0;
//
//                              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                              YFileVersions.InfoFile := IFileVersions.InfoFile;
//
//                              TDirectory.Delete(TmpDir + 'Info\', True);
//                            end;
//
//                    DeleteFile(TmpDir + 'Info' +'.zip');
//                  end;
//
//              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                  end;
//            end;
//
//        if UpdateForm.Visible and (IFileVersions.SplashFile <> YFileVersions.SplashFile) then
//            begin
//              UpdateForm.RzListView1.AddItem('Splash', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add(FloatToStrF(IFileVersions.SplashFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//              if GetFile(idFTP1, 'Splash' + '.zip', TmpDir + 'Splash' +'.zip') then
//                  begin
//                    if ExtractZip(ZipMaster1, TmpDir + 'Splash' + '.zip', DataDir) then
//                        begin
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                          YFileVersions.SplashFile := IFileVersions.SplashFile;
//                        end;
//
//                    DeleteFile(TmpDir + 'Splash' + '.zip');
//                  end;
//
//              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                  end;
//            end;
//
//        idftp1.ChangeDir(fDir);
//
//        fStream := TMemoryStream.Create;
//        Sl:=TStringList.Create;
//        try
//          Sl.Add(FormatDateTime('yyyy.mm.dd hh:nn.ss', Now));
//          Sl.Add(OSVersion);
//          Sl.Add(GetSystemInfo);
//          Sl.Add(ProcessorName);
//
//
//          Sl.SaveToStream(fStream);
//          fStream.Position:=0;
//          idFTP1.Put(fStream, 'Time.log', False);
//        finally
//          fStream.Free;
//          Sl.Free;
//        end;
//
//        Filel :=TStringList.Create;
//        IdFTP1.List(Filel, '*', True);
//
//        FInfo:=TMemIniFile.Create('');
//        TmpStrL:=TStringList.Create;
//
//        for k := 0 to Filel.Count - 1 do
//            begin
//              Tmp:='[FInfo]' + #13#10 + Filel[k];
//
//              Tmp  := StringReplace(Tmp, ';', #13#10,
//                           [rfReplaceAll, rfIgnoreCase]);
//
//              TmpStrL.Text:=Tmp;
//
//              FInfo.SetStrings(TmpStrL);
//
//              if FInfo.ReadString('FInfo', 'type', '') = 'file' then
//                  begin
//                    cstr:=LowerCase((FileList[0] + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.TvFile      := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.TvFileUnq   := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.TvFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//
//                    cstr:=LowerCase((FileList[1] + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.ArrFile     := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.ArrFileUnq  := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.ArrFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//
//                    cstr:=LowerCase((FileList[2] + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.SalesFile    := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.SalesFileUnq := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.SalesFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//
//                    cstr:=LowerCase((FileList[3] + '.zip'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.ClientsFile    := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.ClientsFileUnq := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.ClientsFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//
//                    cstr:=LowerCase((FileList[4] + '.xml'), loUserLocale);
//                    fstr:=Copy(LowerCase(TmpStrL[TmpStrL.Count - 1], loUserLocale), 2, Length(cstr));
//
//                    if AnsiCompareText(fstr, cstr) = 0 then
//                      begin
//                        IFileVersions.TpSalesFile    := FInfo.ReadString('FInfo', 'modify', '');
//                        IFileVersions.TpSalesFileUnq := FInfo.ReadString('FInfo', 'unique', '');
//
//                        IFileVersions.TpSalesFileSize  := FInfo.ReadInteger('FInfo', 'size', 0);
//                      end;
//                  end;
//            end;
//
//            FInfo.Free;
//            TmpStrL.Free;
//
//        if UpdateForm.Visible and Settings.TvA then
//            begin
//              UpdateForm.RzListView1.AddItem('Товары', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.TvFile <> YFileVersions.TvFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.TvFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//                      if not GetFile(idFTP1, FileList[0] + '.zip', TmpDir + FileList[0] +'.zip') then
//                          begin
//                            //AdvToolBarMenuButton1.Enabled:=True;
//                            //Exit;
//                          end
//                        else
//                          begin
//                            if ExtractZip(ZipMaster1, TmpDir + FileList[0] + '.zip', TmpDir) then
//                                begin
//                                  LoadTvFile(VST, TmpDir + FileList[0] + '.xml', DataDir + FileList[0] + '.xml', TvInf);
//
//                                  RzNumericEdit1.Value:=TvInf.Kurs;
//                                  ///AdvOfficeStatusBar1.Panels[0].Text:='Версия спр. тов.: ' + TvInf.VersionTovars;
//
//                                  UpdDateL(TvInf.VersionTovars);
//
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                  UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                  YFileVersions.TvFile := IFileVersions.TvFile;
//                                  SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//                                  DeleteFile(TmpDir + FileList[0] + '.xml');
//
//                                  WebBrowser.Navigate(DataDir + 'Info\Index.html');
//
//                                  InfoPage.TabVisible:=True;
//                                  AdvOfficePager1.ActivePageIndex:=0;
//                                end;
//
//                            DeleteFile(TmpDir + FileList[0] +'.zip');
//                          end;
//
//                      if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                          begin
//                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                            UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                          end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;
//
//        if UpdateForm.Visible and Settings.ArA then
//            begin
//              UpdateForm.RzListView1.AddItem('Долги', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.ArrFile <> YFileVersions.ArrFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.ArrFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//                    if not GetFile(idFTP1, FileList[1] + '.zip', TmpDir + FileList[1] +'.zip') then
//                        begin
//                          //AdvToolBarMenuButton1.Enabled:=True;
//                          //Exit;
//                        end
//                      else
//                        begin
//                          if ExtractZip(ZipMaster1, TmpDir + FileList[1] + '.zip', TmpDir) then
//                              begin
//                                if LoadArrearageFile(AdvOutlookList, ArrOutlookList, TmpDir + FileList[1] + '.xml', DataDir + FileList[1] + '.xml') then
//                                    begin
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                      YFileVersions.ArrFile := IFileVersions.ArrFile;
//                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//                                      DeleteFile(TmpDir + FileList[1] + '.xml');
//                                    end;
//                              end;
//
//                          DeleteFile(TmpDir + FileList[1] +'.zip');
//                        end;
//
//                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                        begin
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                        end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;
//
//        if UpdateForm.Visible and Settings.SlA then
//            begin
//              UpdateForm.RzListView1.AddItem('Продажи', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.SalesFile <> YFileVersions.SalesFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.SalesFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//                    if not GetFile(idFTP1, FileList[2] + '.zip', TmpDir + FileList[2] +'.zip') then
//                        begin
//                          //AdvToolBarMenuButton1.Enabled:=True;
//                          //Exit;
//                        end
//                      else
//                        begin
//                          if ExtractZip(ZipMaster1, TmpDir + FileList[2] + '.zip', TmpDir) then
//                              begin
//                                if LoadSalesFile(vrtlstrngtr1, TmpDir + FileList[2] + '.xml', DataDir + FileList[2] + '.xml') then
//                                    begin
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                      YFileVersions.SalesFile := IFileVersions.SalesFile;
//                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//                                      DeleteFile(TmpDir + FileList[2] + '.xml');
//                                    end;
//                              end;
//
//                          DeleteFile(TmpDir + FileList[2] +'.zip');
//                        end;
//
//                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                        begin
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                        end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;
//
//
//        if UpdateForm.Visible and Settings.SlA then
//            begin
//              UpdateForm.RzListView1.AddItem('Клиенты', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.ClientsFile <> YFileVersions.ClientsFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.ClientsFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//                    if not GetFile(idFTP1, FileList[3] + '.zip', TmpDir + FileList[3] +'.zip') then
//                        begin
//                          //AdvToolBarMenuButton1.Enabled:=True;
//                          //Exit;
//                        end
//                      else
//                        begin
//                          if ExtractZip(ZipMaster1, TmpDir + FileList[3] + '.zip', TmpDir) then
//                              begin
//                                if LoadClientsFile(ClList, TmpDir + FileList[3] + '.xml', DataDir + FileList[3] + '.xml') then
//                                    begin
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                      YFileVersions.ClientsFile := IFileVersions.ClientsFile;
//                                      SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//                                      WebBrowser.Navigate(DataDir + 'Info\Index.html');
//
//                                      DeleteFile(TmpDir + FileList[3] + '.xml');
//                                    end;
//                              end;
//
//                          DeleteFile(TmpDir + FileList[3] + '.zip');
//                        end;
//
//                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                        begin
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                        end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;
//
//        if UpdateForm.Visible and Settings.SlA then
//            begin
//              UpdateForm.RzListView1.AddItem('Виды оплаты', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              if (IFileVersions.TpSalesFile <> YFileVersions.TpSalesFile) then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems[0]:=(FloatToStrF(IFileVersions.TpSalesFileSize / 1024, ffNumber, 6, 2) + ' Кб');
//
//                    if not GetFile(idFTP1, FileList[4] + '.xml', TmpDir + FileList[4] +'.xml') then
//                        begin
//                          //AdvToolBarMenuButton1.Enabled:=True;
//                          //Exit;
//                        end
//                      else
//                        begin
//                          if LoadTypeSalFile(MainRequests, TmpDir + FileList[4] + '.xml', DataDir + FileList[4] + '.xml') then
//                              begin
//                                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//
//                                YFileVersions.TpSalesFile := IFileVersions.TpSalesFile;
//                                SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//                              end;
//
//                          DeleteFile(TmpDir + FileList[4] + '.xml');
//                        end;
//
//                    if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                        begin
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                          UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                        end;
//                  end
//              else
//                begin
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                   UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                end;
//            end;
//
//
//        if UpdateForm.Visible and Settings.SlA then
//            begin
//              UpdateForm.RzListView1.AddItem('Заявки', nil);
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=47;
//              UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('');
//
//              Fl :=TStringList.Create;
//
//              try
//                IdFTP1.ChangeDir(fDir + '/ANS/');
//                IdFTP1.List(Fl, '*.xml', False);
//
//                ADest := TMemoryStream.Create;
//
//                for i := 0 to Fl.Count - 1 do
//                  begin
//                    Tmp:= ChangeFileExt(Fl[i], '');
//
//                    if MainRequests.RecFound(Tmp) then
//                        begin
//                          idFTP1.Get(Fl[i], ADest, False);
//
//                            //ShowMessage(IntToStr(ADest.Size));
//
//                          if MainRequests.ParseReq(ADest, xRequest) then
//                              begin
//                                if MainRequests.UpdateReq(xRequest) then
//                                    begin
//                                      idFTP1.Delete(Fl[i]);
//
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Завершено');
//                                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                                    end;
//                              end;
//                            //ShowMessage(xRequest.UID);
//                        end;
//                  end;
//
//                if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 1 then
//                    begin
//                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Не требуется');
//                      UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=18;
//                    end;
//              except
//                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//              end;
//
//              if UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Count = 0 then
//                  begin
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].SubItems.Add('Ошибка');
//                    UpdateForm.RzListView1.Items[UpdateForm.RzListView1.Items.Count - 1].ImageIndex:=14;
//                  end;
//            end;
//
//        //SaveVersions(DataDir + 'Version' + '.xml', YVessions);
//        SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);
//
//        if UpdateForm.Visible then
//            begin
//              UpdateForm.Timer1.Enabled:=True;
//              UpdateForm.AdvGlowButton2.Caption:='Закрыть';
//            end;
//
//        try
//          idFTP1.Disconnect;
//        finally
//
//        end;
//      except on E : Exception do
//        begin
//          if not Pos('10054', E.Message) > 0 then
//            begin
//              MessageDlg('Ошибка процесса обновления: ' + E.Message, mtError, [mbOK], 0);
//              AdvToolBarMenuButton1.Enabled:=True;
//              N23.Enabled:=True;
//              Exit;
//            end;
//
//        end;
//      end;
//    end
//  else
//    begin
//      MessageDlg('Ошибка подключения', mtInformation, [mbOK], 0);
//    end;
//
//  AdvToolBarMenuButton1.Enabled:=True;
//  N23.Enabled:=True;
//end;

procedure TMainForm.AdvToolBarMenuButton2Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnAddReqClick(Sender: TObject);
begin
  MainRequests.NewRequest;
end;

procedure TMainForm.btnAdvToolBarAddReqClick(Sender: TObject);
begin
  MainRequests.NewRequest;
end;

procedure TMainForm.AdvToolBarMenuButton4Click(Sender: TObject);
begin
  if MainRequests.SelectedItem > -1 then
      MainRequests.DeleteReq(MainRequests.SelectedItem);
end;

procedure TMainForm.AdvToolBarMenuButton5Click(Sender: TObject);
begin
  if MainRequests.SelectedItem > -1 then
      MainRequests.SendReq(MainRequests.SelectedItem);
end;

procedure TMainForm.AdvToolBarMenuButton7Click(Sender: TObject);
begin
  if AdvToolBarMenuButton7.Tag = 0 then
      begin
        AdvToolBarMenuButton7.Tag:= 1;
        Cash:=1;
        AdvToolBarMenuButton7.Caption:='U.S.D';
        AdvToolBarMenuButton7.ImageIndex:=45;

//        VST.Header.Columns[8].Text:='Цена Бел. руб.';
//        VST.Header.Columns[9].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%';
//        VST.Header.Columns[6].Text:='Цена USD';
//        VST.Header.Columns[7].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%';
      end
    else
      begin
        AdvToolBarMenuButton7.Tag:= 0;
        Cash:=0;
        AdvToolBarMenuButton7.Caption:='Бел. руб.';
        AdvToolBarMenuButton7.ImageIndex:=44;

//        VST.Header.Columns[6].Text:='Цена Бел. руб.';
//        VST.Header.Columns[7].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%';
//        VST.Header.Columns[8].Text:='Цена USD';
//        VST.Header.Columns[9].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%';
      end;

  ChangeColN(Sender);
  VST.Repaint;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  AdvOfficeStatusBar1.Panels[1].Text:=Application.Hint;
end;

procedure TMainForm.btn2Click(Sender: TObject);
begin
  N38Click(Sender);
end;

procedure TMainForm.btn4Click(Sender: TObject);
begin
  if btn4.Tag = 0 then
      begin
        btn4.Tag:= 1;
        NoDisc:=1;
        btn4.Caption:='Без скидки*';
        btn4.ImageIndex:=21;
      end
    else
      begin
        btn4.Tag:= 0;
        NoDisc:=0;
        btn4.Caption:='Со скидкой';
        btn4.ImageIndex:=20;
      end;

  CalculateCost(VST, NoDisc);
  ChangeColN(Sender);
  VST.Repaint;
end;

procedure TMainForm.btnCloneReqClick(Sender: TObject);
begin
  if MainRequests.SelectedItem > -1 then
      MainRequests.CloneReq(MainRequests.SelectedItem, Sender);
end;

procedure TMainForm.ChangeColN(Sender: TObject);
var
  star : string;
begin
  if NoDisc = 1 then
    star:='*'
  else
    star:='';

  if Cash = 1 then
     begin
        VST.Header.Columns[8].Text:='Цена Бел. руб.' + star;
        VST.Header.Columns[9].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%' + star;
        VST.Header.Columns[6].Text:='Цена USD' + star;
        VST.Header.Columns[7].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%' + star;
     end
  else
    begin
        VST.Header.Columns[6].Text:='Цена Бел. руб.' + star;
        VST.Header.Columns[7].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%' + star;
        VST.Header.Columns[8].Text:='Цена USD' + star;
        VST.Header.Columns[9].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%' + star;
    end;
end;

procedure TMainForm.btnCollapsAllClick(Sender: TObject);
begin
  case AdvOfficePager1.ActivePageIndex of
    1: VST.FullExpand();
    3: vrtlstrngtr1.FullExpand();
    4: lstArr.ExpandAll;
    5: AdvOutlookList1.ExpandAll;
  end;
end;

procedure TMainForm.btnDeleteFrWaitListClick(Sender: TObject);
var
  Data      : PTreeData;
  Av, UnAv  : Integer;
begin
  if vrtlstrngtrWait.SelectedCount > 0 then
      begin
        Data:=vrtlstrngtrWait.GetNodeData(vrtlstrngtrWait.GetFirstSelected);

        if not Data^.Root then
            begin
              if DeleteFromWaitList(Data^.Code, DataDir + 'WaitList.xml') then
                  begin
                    LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');
                    GLAv:=Av;
                    GLUnAv:=UnAv;
                  end;
            end;
      end;
end;

procedure TMainForm.btnExpandAllbtnClick(Sender: TObject);
begin
  case AdvOfficePager1.ActivePageIndex of
    1: VST.FullCollapse;
    3: vrtlstrngtr1.FullCollapse;
    4: lstArr.CollapseAll;
    5: AdvOutlookList1.CollapseAll;
  end;
end;

procedure TMainForm.DiscountSpinEditKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = '.' then Key := ',';
end;

procedure TMainForm.edt1Change(Sender: TObject);
begin
  if Cash = 1 then
      begin
        VST.Header.Columns[8].Text:='Цена Бел. руб.';
        VST.Header.Columns[9].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%';
        VST.Header.Columns[6].Text:='Цена USD';
        VST.Header.Columns[7].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%';
      end
    else
      begin
        VST.Header.Columns[6].Text:='Цена Бел. руб.';
        VST.Header.Columns[7].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%';
        VST.Header.Columns[8].Text:='Цена USD';
        VST.Header.Columns[9].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%';
      end;

  VST.Repaint;
end;

procedure TMainForm.edt1KeyPress(Sender: TObject; var Key: Char);
begin
  if key <> #8 then
    begin
      case Key of
        '0'..'9': key := key;
        else
          Key := #0;
      end;
    end;
end;

procedure TMainForm.edtSearchChange(Sender: TObject);
var
  XNode     : PVirtualNode;
  Data      : PTreeData;
  xData     : PSale;

  ToSerc    : string;
  TpSerc    : bool;
  Res       : bool;
  i, k      : Integer;

  olg       : TOutlookGroup;
  sl        : TStrings;

  CodeFound : BOOL;
begin
  if CancelSearch then
    begin
      CancelSearch:= False;
      Exit;
    end;

  if AdvOfficePager1.ActivePageIndex = 0 then AdvOfficePager1.ActivePageIndex := 1;

  case AdvOfficePager1.ActivePageIndex of
    1:
      begin
        XNode := VST.GetFirst;
        if XNode = nil then Exit;

        TpSerc:=False;

          if edtSearch.Text = '' then
              begin
                VST.BeginUpdate;
                try
                  repeat
                    XNode := VST.GetNext(XNode);

                    VST.IsVisible[XNode]:=True;
                  until XNode = VST.GetLast;
                finally
                  VST.EndUpdate;
                end;

                VST.FullCollapse;
                lst1.ClearGroups;

                Exit;
              end;

        VST.FullCollapse;

        VST.BeginUpdate;
        try
          VST.IsVisible[XNode]:=False;

          repeat
            XNode := VST.GetNext(XNode);
            Data := VST.GetNodeData(XNode);

            case btnSearchType.Tag of
              0: ToSerc := Copy(Data^.Code, 0, Length(edtSearch.Text));
              1: ToSerc := Data^.Name;
              2:
                  begin
                    ToSerc := Data^.Name;
                    TpSerc := True;
                  end;
            end;

            if TpSerc then
                begin
                  Res:=IndistinctMatching(3, edtSearch.Text, ToSerc) > 20;
                end
              else
                begin
                  if btnSearchType.Tag = 1 then
                  Res:=(Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ToSerc, loUserLocale)) > 0) or
                       (Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(Data^.NameNS, loUserLocale)) > 0)
                  else Res:=(Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ToSerc, loUserLocale)) > 0);
                end;

            CodeFound:=False;

            if InAraay(edtSearch.Text, Data^.OEMNum) then CodeFound:=True;
            if InAraay(edtSearch.Text, Data^.RefNum) then CodeFound:=True;

            if Res or (CodeFound and (btnSearchType.Tag = 1)) then
                begin
                  if XNode <> nil then
                  if not VST.IsVisible[XNode] then

                      VST.IsVisible[XNode]:=True;

                  if XNode.Parent <> nil then
                    if not VST.IsVisible[XNode.Parent] then
                      VST.IsVisible[XNode.Parent]:=True;
                end
              else
                begin
                  if XNode <> nil then
                      VST.IsVisible[XNode]:=False;
                end;
          until XNode = VST.GetLast;

          XNode := VST.GetFirst;

          repeat
            XNode := VST.GetNext(XNode);
            Data:=VST.GetNodeData(XNode);

            if not Data^.Root and VST.IsVisible[XNode] then
                begin
                  VST.Selected[XNode]:=True;

                  VSTFocusChanged(VST, XNode, 0);

                  Break;
                end;

          until XNode = VST.GetLast;

          if VST.VisibleCount = 0 then lst1.ClearGroups;

        finally
          VST.EndUpdate;
        end;

        VST.FullExpand();
      end;

    3:
      begin
        XNode := vrtlstrngtr1.GetFirst;
        if XNode = nil then Exit;

        //TpSerc:=False;

        if edtSearch.Text = '' then
            begin
              vrtlstrngtr1.BeginUpdate;
              try
                repeat
                  XNode := vrtlstrngtr1.GetNext(XNode);
                  vrtlstrngtr1.IsVisible[XNode]:=True;
                until XNode = vrtlstrngtr1.GetLast;
              finally
                vrtlstrngtr1.EndUpdate;
              end;

              vrtlstrngtr1.FullCollapse;
              Exit;
            end;

        vrtlstrngtr1.FullCollapse;

        vrtlstrngtr1.BeginUpdate;
        try
          vrtlstrngtr1.IsVisible[XNode]:=False;

          repeat
            XNode := vrtlstrngtr1.GetNext(XNode);
            xData := vrtlstrngtr1.GetNodeData(XNode);

            {case btnSearchType.Tag of
              0: ToSerc := Data^.Code;
              1: ToSerc := Data^.Name;
              2:
                  begin
                    ToSerc := Data^.Name;
                    TpSerc := True;
                  end;
            end;}

            {if TpSerc then
                begin
                  Res:=IndistinctMatching(3, edtSearch.Text, ToSerc) > 20;
                end
              else
                begin
                  Res:=(Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ToSerc, loUserLocale)) > 0);
                end;}

            ToSerc := xData^.Name;

            if Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ToSerc, loUserLocale)) > 0 then
                begin
                  if XNode <> nil then
                      if not vrtlstrngtr1.IsVisible[XNode] then
                          vrtlstrngtr1.IsVisible[XNode]:=True;

                  if XNode.Parent <> nil then
                    if not vrtlstrngtr1.IsVisible[XNode.Parent] then
                      vrtlstrngtr1.IsVisible[XNode.Parent]:=True;
                end
              else
                begin
                  if (XNode <> nil) and xData^.Root then
                      begin
                        vrtlstrngtr1.IsVisible[XNode]:=False;
                      end;
                end;
          until XNode = vrtlstrngtr1.GetLast;
        finally
          vrtlstrngtr1.EndUpdate;
        end;

        vrtlstrngtr1.FullExpand();
      end;

    4:
    begin
      if edtSearch.Text = '' then
          begin
            FillDocEx(lstArr, ArrOutlookList);
            Exit;
          end;

      lstArr.BeginUpdate;
      lstArr.ClearGroups;

      for i := 0 to Length(ArrOutlookList) - 1 do
        begin
          if Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ArrOutlookList[i].Caption, loUserLocale)) > 0 then
              begin
                olg:=lstArr.AddGroup(ArrOutlookList[i].Caption);

                if ArrOutlookList[i].Items <> nil then
                    begin
                      for k := 0 to Length(ArrOutlookList[i].Items) - 1 do
                        begin
                          sl:=lstArr.AddItem(olg);
                          sl.Assign(ArrOutlookList[i].Items[k]);
                        end;
                    end;
              end
        end;

      lstArr.EndUpdate;
    end;

    5:
    begin
      if edtSearch.Text = '' then
          begin
            FillDocEx(AdvOutlookList1, ClList.ClOtLst);
            Exit;
          end;

      AdvOutlookList1.BeginUpdate;
      AdvOutlookList1.ClearGroups;

      for i := 0 to Length(ClList.ClOtLst) - 1 do
        begin
          if Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(ClList.ClOtLst[i].Caption, loUserLocale)) > 0 then
              begin
                olg:=AdvOutlookList1.AddGroup(ClList.ClOtLst[i].Caption);

                if ClList.ClOtLst[i].Items <> nil then
                    begin
                      for k := 0 to Length(ClList.ClOtLst[i].Items) - 1 do
                        begin
                          sl:=AdvOutlookList1.AddItem(olg);
                          sl.Assign(ClList.ClOtLst[i].Items[k]);
                        end;
                    end;
              end
        end;

      AdvOutlookList1.EndUpdate;
    end;
  end;
end;

procedure TMainForm.excel1Click(Sender: TObject);
begin
  if dlgOpen1.Execute then
    begin
      MainRequests.LoadFromExcelFile('Заявка', dlgOpen1.FileName);
    end;

end;

function RefToCell(ARow, ACol: Integer): string;
begin
  Result := Chr(Ord('A') + ACol - 1) + IntToStr(ARow);
end;

function CheckExcelInstall:boolean;
const ExcelApp = 'Excel.Application';
var
  ClassID: TCLSID;
  Rez : HRESULT;
begin
// Ищем CLSID OLE-объекта
  Rez := CLSIDFromProgID(PWideChar(WideString(ExcelApp)), ClassID);
  if Rez = S_OK then  // Объект найден
    Result := true
  else
    Result := false;
end;

procedure TMainForm.excel2Click(Sender: TObject);
const
  xlWBATWorksheet = -4167;
var
  //Row, Col            : Integer;
  //GridPrevFile        : string;
  XLApp, Sheet, Data  : OLEVariant;
  i, cn, Mr           : Integer;

  ci                  : ClInfo;

  Tmp                 : string;
  DataX               : PTreeData;

  XNode               : PVirtualNode;
  Folder              : string;
begin
  if not CheckExcelInstall then
    begin
      ShowMessage('На компьютере не установлен Excel!');
      Exit;
    end;

  XLApp := CreateOleObject('Excel.Application');
  try
    XLApp.Visible := True;

    XLApp.Workbooks.Add(xlWBatWorkSheet);
    Sheet := XLApp.Workbooks[1].WorkSheets[1];
    Sheet.Name := StringReplace(TvInf.VersionTovars, ':', '.', [rfReplaceAll]);
    cn:=0;
    Mr:=0;
    i:=0;

    Data := VarArrayCreate([1, 100, 1, 8], varVariant);

    sheet.Columns[1].ColumnWidth:=65;
    sheet.Columns[4].ColumnWidth:=15;
    sheet.Columns[6].ColumnWidth:=40;
    sheet.Columns[7].ColumnWidth:=25;
    sheet.Columns[8].ColumnWidth:=25;
    sheet.Columns[8].NumberFormat := 0;

    XNode:=nil;
    repeat
      if XNode = nil then XNode:=VST.GetFirst else XNode:=VST.GetNext(XNode);
      DataX:=VST.GetNodeData(XNode);

      if DataX^.Root then
        begin
          Folder := DataX^.Name;
        end
      else
        begin
          Data[cn + 1, 1]:=DataX^.Name;
          Data[cn + 1, 2]:=DataX^.Code;
          Data[cn + 1, 3]:='';
          Data[cn + 1, 4]:=DataX^.Cost1Dbl;
          if DataX^.Status then Data[cn + 1, 5]:='+' else Data[cn + 1, 5]:='-';
          Data[cn + 1, 6]:=Folder;
          Data[cn + 1, 7]:=DataX^.TecDOC;
          //Data[cn + 1, 8]:=DataX^.BC;
          if (DataX^.BC <> '0') and (DataX^.BC <> '') then Data[cn + 1, 8]:=DataX^.BC else Data[cn + 1, 8]:='';

          inc(cn);

          inc(i);
        end;

        if cn = 100 then
          begin
            Inc(Mr);
            cn:=0;

            Sheet.Range[RefToCell(100 * Mr - 99 , 1), RefToCell(100 * Mr, 8)].Value := Data;

            Data := VarArrayCreate([1, 100, 1, 8], varVariant);
          end;

    until XNode = VST.GetLast();

    if cn > 0 then
      begin
        Inc(Mr);

        Sheet.Range[RefToCell(100 * Mr - 99 , 1), RefToCell(100 * Mr, 8)].Value := Data;
      end;

    // Save Excel Worksheet
    try
      //XLApp.Workbooks[1].SaveAs(AFileName);

      /////Result := True;
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

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : Integer;
begin
  try
    for i := 0 to VST.Header.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('VST', 'Column' + IntToStr(i), VST.Header.Columns[i].Width);
      end;

    for i := 0 to vrtlstrngtr1.Header.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('VSTSales', 'Column' + IntToStr(i), vrtlstrngtr1.Header.Columns[i].Width);
      end;

    for i := 0 to lstArr.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('VSTArr', 'Column' + IntToStr(i), lstArr.Columns[i].Width);
      end;

    for i := 0 to AdvOutlookList1.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('VSTCl', 'Column' + IntToStr(i), AdvOutlookList1.Columns[i].Width);
      end;

    for i := 0 to ListReq.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('ListReq', 'Column' + IntToStr(i), ListReq.Columns[i].Width);
      end;

    for i := 0 to TovarsList.Columns.Count - 1 do
      begin
        RzRegIniFile1.WriteInteger('TovarsList', 'Column' + IntToStr(i), TovarsList.Columns[i].Width);
      end;

    RzRegIniFile1.WriteInteger('Page', 'Active', AdvOfficePager1.ActivePageIndex);
    RzRegIniFile1.WriteBool('Page', 'TvHotSpot', RzSizePanel1.HotSpotClosed);

    rzprprtystr1.Save;

    WebBrowser.Stop;

  finally

  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if (MessageBox(0, 'Завершить работу?', 'Mannol Trade', MB_ICONQUESTION or MB_YESNO or MB_DEFBUTTON1) = idYes) then
  //if MessageDlg('Завершить работу? ', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      CanClose:=True
    else
      CanClose:=False;
end;

procedure TMainForm.OnMyException(Sender: TObject; E: Exception);
begin
  //exit;
end;

procedure TMainForm.TovarsListGroupCollaps(Sender: TObject; Item: POGLItem);
begin
  if TovarsList.GroupCount > 0 then
    TovarsList.ExpandAll;
end;

procedure TMainForm.TovarsListItemClick(Sender: TObject; Item: POGLItem;
  Column: Integer);
begin
  if Column = 8 then
      begin
        TovarsListItemDblClick(TovarsList, TovarsList.FirstSelectedItem, 0);
      end;

  if Column = 9 then
      begin
        MainRequests.CheckAndDeleteTv;
      end;
end;

function TMainForm.GetTovarMinR(Code : integer) : integer;
var
  Data    : PTreeData;
  StrCode : string;
  XNode   : PVirtualNode;
begin
  StrCode:=IntToStr(Code);

  if VST.GetFirst = nil then
  begin
    Result:=1;
    Exit;
  end;

  XNode:=nil;
  repeat
    if XNode = nil then XNode:=VST.GetFirst else XNode:=VST.GetNext(XNode);
    Data:=VST.GetNodeData(XNode);
    if (Data^.Code = StrCode) then
        begin
          Result:=Data^.MinR;
          exit;
        end;
  until XNode = VST.GetLast();

  Result:=1;
end;

procedure TMainForm.idthrdcmpnt1Run(Sender: TIdThreadComponent);
begin
  ExeMD5:=MD5File(Application.ExeName);
  idthrdcmpnt1.Terminate;
end;

procedure TMainForm.TovarsListItemDblClick(Sender: TObject; Item: POGLItem;
  Column: Integer);
var
  Tmp  : Tovar;
  //Cost : Double;
begin
  Tmp := MainRequests.GetSelTv;

  if Tmp.Code = -1 then
      begin

      end
    else
      begin
        AddForm.Add:=False;

        AddForm.RzMemo1.Text:=Tmp.Name;
        if Cash = 0 then
            AddForm.Cost:=Tmp.Coast1
          else
            AddForm.Cost:=Tmp.Coast2;

        AddForm.Code:=Tmp.Code;

        AddForm.Cost1:=Tmp.Coast1;
        AddForm.Cost2:=Tmp.Coast2;

        if MainForm.Cash = 0 then
            begin
              FormatSettings.CurrencyString := ' Бел. руб.';
              //Cost:=Tmp.Coast1;
            end
          else
            begin
              FormatSettings.CurrencyString := ' USD';
              //Cost:=Tmp.Coast2;
            end;

        //RzStatusPane1.Caption:='Сумма: ' + FloatToStrF(RzSpinEdit1.Value * Cost, ffCurrency, 10, 2);

        if Cash = 1 then
            AddForm.RzStatusPane2.Caption:='Стоимость: ' + FloatToStrF(Tmp.Coast2, ffCurrency, 10, 2)
          else
            AddForm.RzStatusPane2.Caption:='Стоимость: ' + FloatToStrF(Tmp.Coast1, ffCurrency, 10, 2);

        AddForm.MinR:=GetTovarMinR(Tmp.Code);

        AddForm.RzSpinEdit1.IntValue:=Tmp.Count;
        AddForm.RzSpinEdit1.OnChange(sender);

        AddForm.ShowModal;
      end;
end;

procedure TMainForm.TovarsListKeyPress(Sender: TObject; var Key: Char);
begin
  //Showmessage(IntToStr(Ord(Key)));
end;

procedure TMainForm.vrtlstrngtr1GetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PSale;
begin

  Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      begin
        if (Column = 0) {and (Node.Parent = Sender.RootNode)} then
            ImageIndex := Data.ImageIndex;

        //if (Column = 4) and not Data.Root then
            //ImageIndex := 6;

        //if (Column = 5) and not Data.Root then
            //ImageIndex := 7;
      end;
  end;
end;

procedure TMainForm.vrtlstrngtr1GetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TSale);
end;

procedure TMainForm.vrtlstrngtr1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PSale;
begin
  Data := VST.GetNodeData(Node);
  case Column of
    0:  CellText := Data^.Name;
    1:  CellText := Data^.Date;
    2:  CellText := Data^.Sum;
    3:  CellText := Data^.DateExp;
    4:  CellText := Data^.Doc;
    {5:  CellText := Data^.Cost2;
    6:  CellText := Data^.Disc;
    7:  CellText := Data^.Cost4;
    8:  CellText := Data^.Cost5;
    9:  CellText := Data^.Cost6;
    10: CellText := Data^.Cost7;
    11: CellText := Data^.Cost8;
    12: CellText := Data^.Cost9;
    13: CellText := Data^.Cost10;
    14: CellText := Data^.Cost11;
    15: CellText := Data^.Cost12;
    16: CellText := Data^.Cost13;
    17: CellText := Data^.Cost14;
    18: CellText := Data^.Cost15;}
  end;
end;

procedure TMainForm.vrtlstrngtr1KeyPress(Sender: TObject; var Key: Char);
var
    Control: TControl;
begin
  Control:=edtSearch;
  Control.Perform(WM_CHAR, Ord(Key), 0);
end;

procedure TMainForm.vrtlstrngtrWaitChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  vrtlstrngtrWait.Refresh;
end;

procedure TMainForm.vrtlstrngtrWaitFocusChanging(Sender: TBaseVirtualTree;
  OldNode, NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  vrtlstrngtrWait.Refresh;
end;

procedure TMainForm.vrtlstrngtrWaitFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
begin
  Data:=vrtlstrngtrWait.GetNodeData(Node);
  if Assigned(Data) then
      begin
        Data^.Name := '';
      end;
end;

procedure TMainForm.vrtlstrngtrWaitGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      begin
        if (Column = 0) {and (Node.Parent = Sender.RootNode)} then
            ImageIndex := Data.ImageIndex;
      end;
  end;
end;

procedure TMainForm.vrtlstrngtrWaitGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TTreeData);
end;

procedure TMainForm.vrtlstrngtrWaitGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PTreeData;
begin
  Data := vrtlstrngtrWait.GetNodeData(Node);
  FormatSettings.CurrencyString:='';

  case Column of
    0:  CellText := Data^.Name;
    1:  CellText := Data^.Code;
    2:  CellText := Data^.Ost;
  end;
end;

function TMainForm.LoadKey(FileName : string) : bool;
var
  fStream         : TMemoryStream;
  TmpStream       : TMemoryStream;
  ini             : TMemIniFile;
  sl              : TStrings;
begin
  try
    fStream := TMemoryStream.Create;
    fStream.LoadFromFile(FileName);

    TmpStream:=TMemoryStream.Create();
    Decrypt(TmpStream, fStream);

    sl:=TStringList.Create;
    sl.LoadFromStream(TmpStream);

    ini:=TMemIniFile.Create('');
    ini.SetStrings(sl);

    with Settings do
      begin
        ID              :=ini.ReadString ('Trading agent', 'ID',       '');
        Pass            :=ini.ReadString ('Trading agent', 'Pass', 'adgk');
        Name            :=ini.ReadString ('Trading agent', 'Name',     '');
        LName           :=ini.ReadString ('Trading agent', 'LName',    '');
        CName           :=ini.ReadString ('Trading agent', 'CName',    '');
        Tel             :=ini.ReadString ('Trading agent', 'Tel',      '');
        Address         :=ini.ReadString ('Trading agent', 'Address',  '');
        Email           :=ini.ReadString ('Trading agent', 'Email',    '');
        ftp             :=ini.ReadString ('Trading agent', 'ftp',      '');
        Port            :=ini.ReadInteger('Trading agent', 'Port',     21);
        PM              :=ini.ReadBool   ('Trading agent', 'PM',     True);
        Dir             :=ini.ReadString ('Trading agent', 'Dir',      '');
        SUSSName        :=ini.ReadString ('Trading agent', 'SUSSName', '');
        SUSSPass        :=ini.ReadString ('Trading agent', 'SUSSPass', '');
        TvA             :=ini.ReadBool   ('Trading agent', 'TvA',   False);
        ReqA            :=ini.ReadBool   ('Trading agent', 'ReqA',  False);
        ArA             :=ini.ReadBool   ('Trading agent', 'ArA',   False);
        SlA             :=ini.ReadBool   ('Trading agent', 'SlA',   False);
        URL             :=ini.ReadString ('Trading agent', 'URL',      '');

        URL:=StringReplace(URL, '\', '/', [rfReplaceAll]);
        if Copy(URL, 1, 7) <> 'http://' then URL := 'http://' + URL;

        Fax             :=ini.ReadString ('Trading agent', 'FAX',      '');

        idFTP1.Host     :=ftp;

        idFTP1.Username :=SUSSName;
        idFTP1.Passive  :=PM;
        idFTP1.Port     :=Port;
        idFTP1.Password :=SUSSPass;
        fDir            :=Dir;
        //Тестовая версия НЕ ДЛЯ КЛИЕНТОВ!!!
        MainForm.Caption:='Mannol Trade ' + ' ' + Settings.CName + ' (' + Settings.Name + ' ' + Settings.LName + ')';
      end;

    sl.Free;
    TmpStream.Free;
    fStream.Free;
    ini.Free;

    ShowPages;

    Result:=True;
  except
    Result:=False;
  end;
end;

procedure TMainForm.lst1DrawItemProp(Sender: TObject; Item: POGLItem;
  Column: Integer; AValue: string; ABrush: TBrush; AFont: TFont);
begin
  if btnSearchType.Tag = 1 then
      begin
        case Item.Tag of
          0 : AFont.Color:=clGray;
          1 : AFont.Color:=clBlue;

          else AFont.Color:=clBlack;
        end;
      end
    else
      begin
        AFont.Color:=clBlack;
      end;

end;

procedure  TMainForm.lst1KeyPress(Sender: TObject; var Key: Char);
var
  Control: TControl;
begin
  Control:=edtSearch;
  Control.Perform(WM_CHAR, Ord(Key), 0);
end;

procedure TMainForm.ShowPages;
begin
  try
    with Settings do
      begin
        TovarPage.TabVisible    :=  TvA;
        ReqPage.  TabVisible    :=  ReqA;
        SalesPage.TabVisible    :=  SlA;
        ArrPager. TabVisible    :=  ArA;
        ClientsPage.TabVisible  :=  SlA;
      end;

    AdvOfficePager1.ActivePageIndex:=0;
  finally

  end;
end;

procedure TMainForm.tmr1Timer(Sender: TObject);
var
  ADest       : TMemoryStream;
  i           : Integer;
  xRequest    : Request;

  Tmp, names  : string;

  AnsArr      : exparr;

  Av, UnAv    : Integer;
begin
  try
    PreDownload(xKey, Settings.ID, Settings.Dir,
                Settings.Name + ' ' + Settings.LName,
                idhtp1, IFileVersions, AnsArr,
                rzvrsnf1.FileVersion, ExeMD5);

  ADest := TMemoryStream.Create;

  for i := 0 to Length(AnsArr) - 1 do
    begin
      Tmp:= ChangeFileExt(AnsArr[i], '');

      if MainRequests.RecFound(Tmp) then
        begin
          if DownloadAnsFile(DownloadLink, AnsArr[i], idhtp1, ADest) then
            if MainRequests.ParseReq(ADest, xRequest) then
              begin
                if MainRequests.UpdateReq(xRequest) then
                  begin
                    DeleteAnsFile(DownloadLink, AnsArr[i], idhtp1);
                  end;
              end;
        end;
    end;

    if (IFileVersions.Rest <> YFileVersions.Rest) then
      begin
        names := LowerCase(StrToMD5Str(xKey + FileList[5] + '.zip'));

        if DownloadFile(DownloadLink + names, TmpDir + FileList[5] +'.zip', idhtp1) then
          begin
            if ExtractZip(ZipMaster1, TmpDir + FileList[5] + '.zip', TmpDir, LowerCase(StrToMD5Str(zFileP))) then
              begin
                LoadRestFile(VST, TmpDir + FileList[5] + '.xml', DataDir + FileList[5] + '.xml', TvInf);
                if FileExists(DataDir + 'WaitList.xml') then
                  begin
                    LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');
                  end;

                if Av > GLAv then
                    begin
                      tmrWait.Enabled:=True;
                      GLAv:=Av;
                    end;

                UpdDateL(TvInf.VersionTovars);

                YFileVersions.Rest := IFileVersions.Rest;
                SaveFileVersions(DataDir + 'FileVersions' + '.xml', YFileVersions);

                DeleteFile(TmpDir + FileList[5] + '.xml');
              end;

              DeleteFile(TmpDir + FileList[5] +'.zip');
          end;
      end;

    tmrUpdInfo.Enabled:=False;

    if IFileVersions.SplashFile   <> YFileVersions.SplashFile   then  UpdateAvalible:=True;
    if IFileVersions.InfoFile     <> YFileVersions.InfoFile     then  UpdateAvalible:=True;
    if IFileVersions.SDP          <> YFileVersions.SDP          then  UpdateAvalible:=True;
    if IFileVersions.ArrFile      <> YFileVersions.ArrFile      then  UpdateAvalible:=True;
    if IFileVersions.ClientsFile  <> YFileVersions.ClientsFile  then  UpdateAvalible:=True;
    if IFileVersions.SalesFile    <> YFileVersions.SalesFile    then  UpdateAvalible:=True;
    if IFileVersions.TpSalesFile  <> YFileVersions.TpSalesFile  then  UpdateAvalible:=True;
    if IFileVersions.ExeFile      <> rzvrsnf1.FileVersion       then  UpdateAvalible:=True;
    if IFileVersions.Rest         <> YFileVersions.Rest         then  UpdateAvalible:=True;
    if IFileVersions.Disc         <> YFileVersions.Disc         then  UpdateAvalible:=True;

    tmrUpdInfo.Enabled:=UpdateAvalible;

    if not UpdateAvalible then btnUpdate.ImageIndex:=36;
  except

  end;
end;

procedure TMainForm.tmrUpdInfoTimer(Sender: TObject);
begin
  if btnUpdate.ImageIndex = 36 then
    begin
      btnUpdate.ImageIndex:=62;
    end
    else
    begin
      btnUpdate.ImageIndex:=36;
    end;
end;

procedure TMainForm.tmrWaitTimer(Sender: TObject);
begin
  if advfcpgWait.ImageIndex = 64 then
    begin
      advfcpgWait.ImageIndex:=11;
    end
    else
    begin
      advfcpgWait.ImageIndex:=64;
    end;
end;

//procedure TMainForm.tmr1Timer(Sender: TObject);
//var
//  Fl        : TStrings;
//  ADest     : TStream;
//  i         : Integer;
//  xRequest  : Request;
//
//  Tmp       : string;
//
//  IdFTP     : TIdFTP;
//begin
//  Fl :=TStringList.Create;
//
//  idFTP:=TIdFTP.Create(nil);
//
//  with Settings do
//    begin
//      idFTP.Host     :=ftp;
//
//      idFTP.Username :=SUSSName;
//      idFTP.Passive  :=PM;
//      idFTP.Port     :=Port;
//      idFTP.Password :=SUSSPass;
//    end;
//
//    if idFTP.Connected then
//        idFTP.Disconnect
//      else
//        try
//          idFTP.Connect();
//        except on E : Exception do
//          begin
//            //MessageDlg(ErrorConection + E.Message, mtError, [mbOK], 0);
//          end;
//        end;
//
//    if idFTP.Connected then
//    begin
//      try
//        IdFTP.ChangeDir(fDir + '/ANS/');
//        IdFTP.List(Fl, '*.xml', False);
//
//        ADest := TMemoryStream.Create;
//
//        for i := 0 to Fl.Count - 1 do
//        begin
//          Tmp:= ChangeFileExt(Fl[i], '');
//
//          if MainRequests.RecFound(Tmp) then
//            begin
//            idFTP.Get(Fl[i], ADest, False);
//
//            if MainRequests.ParseReq(ADest, xRequest) then
//              begin
//                if MainRequests.UpdateReq(xRequest) then
//                  begin
//                    idFTP.Delete(Fl[i]);
//                  end;
//              end;
//            end;
//        end;
//      except
//
//      end;
//
//      IdFTP.Disconnect;
//      IdFTP.Free;
//    end;
//
//  Fl.Free;
//end;


function TMainForm.xcheck : Boolean;
var
  PassIn : TMaskEdit;
begin
  if Settings.Pass <> '' then
      begin
        PassIn :=TMaskEdit.Create(nil);
        PassIn.Width:=220;
        PassIn.PasswordChar:='*';

        AdvInputTaskDialog1.Title:='Начало работы';
        AdvInputTaskDialog1.Content:='Введите пароль:';
        AdvInputTaskDialog1.InputText:='';

        AdvInputTaskDialog1.Icon:=tiShield;

        AdvInputTaskDialog1.InputType := itCustom;
        AdvInputTaskDialog1.InputControl := PassIn;

        if AdvInputTaskDialog1.Execute <> 1 then
            begin
              Result:=False;
            end
          else
            begin
              if AdvInputTaskDialog1.InputText <> Settings.Pass then
                  begin
                    MessageDlg('Неверный пароль', mtError, [mbOK], 0);
                    Result:=False;
                  end
                else
                begin
                  Result:=True;
                end;
            end;

        PassIn.Free;
      end
    else
      begin
        Result:=True;
      end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  KeySl           : TStringList;
  i               : integer;

  Av, UnAv        : Integer;
begin
  Cash:=0;

  if not FindCmdLineSwitch('ShowException') then
    begin
      Application.OnException:= OnMyException;
    end;

  SplashForm:=TSplashForm.Create(Application);

  idthrdcmpnt1.Start;

  if not FindCmdLineSwitch('NoSplash') then
    begin
      SplashForm.ShowModal;
      //SplashForm.Show;
      FreeAndNil(SplashForm);
    end;

  ZipMaster1                := TZipMaster19.Create(Self);
  ZipMaster1.Active         := True;
  ZipMaster1.DLLDirectory   := ExtractFileDir(Application.ExeName);
  ZipMaster1.Dll_Load       := False;

  KeySl:=FindFileInFolder(ExtractFilePath(Application.ExeName), '*.key');

  if KeySl.Count = 0  then
      begin
        OpenDialog1.Title:='Начало работы. Укажите путь к файлу ключа:';

        if not OpenDialog1.Execute then
            begin
              Application.Terminate;
              exit;
            end
          else
            begin
              CopyFileTo(OpenDialog1.FileName, ExtractFilePath(Application.ExeName) + ExtractFileName(OpenDialog1.FileName));
              KeySl:=FindFileInFolder(ExtractFilePath(Application.ExeName), '*.key');
            end;
      end;

  if not LoadKey(KeySl[0]) then
      begin
        MessageDlg('Ошибка открытия ключа', mtError, [mbOK], 0);
        if FileExists(KeySl[0]) then DeleteFile(KeySl[0]);
        Application.Terminate;
        exit;
      end;

  if not xcheck then
      begin
        Application.Terminate;
        exit;
      end;

  TmpDir:=ExtractFilePath(Application.ExeName) + 'Temp\';
  DataDir:=ExtractFilePath(Application.ExeName) + 'Data\';

  VST.Header.Columns[0].Text:='Товары';
  VST.Header.Columns[0].Width:=320;

  VST.Header.Columns[1].Text:='Код';
  VST.Header.Columns[1].Alignment:=taRightJustify;
  VST.Header.Columns[1].Width:=55;

  VST.Header.Columns[2].Text:='Остаток';
  VST.Header.Columns[2].Alignment:=taRightJustify;
  VST.Header.Columns[2].Width:=65;

  VST.Header.Columns[3].Text:='Скидка';
  VST.Header.Columns[3].Alignment:=taRightJustify;
  VST.Header.Columns[3].Width:=65;

  VST.Header.Columns[4].Text:='Кол-во в уп.';
  VST.Header.Columns[4].Alignment:=taRightJustify;
  VST.Header.Columns[4].Width:=70;

  VST.Header.Columns[5].Text:='Изменение цены';
  VST.Header.Columns[5].Alignment:=taCenter;
  VST.Header.Columns[5].Width:=25;

  VST.Header.Columns[6].Text:='Цена Бел. руб.';
  VST.Header.Columns[6].Alignment:=taRightJustify;
  VST.Header.Columns[6].Width:=100;

  VST.Header.Columns[7].Text:='Цена Бел. руб. + ' + FloatToStr(edt1.Value) + '%';
  VST.Header.Columns[7].Alignment:=taRightJustify;
  VST.Header.Columns[7].Width:=100;

  //VST.Header.Columns[8].Text:='Цена USD';
  //VST.Header.Columns[8].Alignment:=taRightJustify;
  VST.Header.Columns[8].MinWidth:=0;
  VST.Header.Columns[8].Width:=0;

  //VST.Header.Columns[9].Text:='Цена USD + ' + FloatToStr(edt1.Value) + '%';
  //VST.Header.Columns[9].Alignment:=taRightJustify;
  VST.Header.Columns[9].MinWidth:=0;
  VST.Header.Columns[9].Width:=0;

  vrtlstrngtrWait.Header.Columns[0].Text:='Товары';
  //vrtlstrngtrWait.Header.Columns[0].Width:=320;

  vrtlstrngtrWait.Header.Columns[1].Text:='Код';
  vrtlstrngtrWait.Header.Columns[1].Alignment:=taRightJustify;
  //vrtlstrngtrWait.Header.Columns[1].Width:=55;

  vrtlstrngtrWait.Header.Columns[2].Text:='Остаток';
  vrtlstrngtrWait.Header.Columns[2].Alignment:=taRightJustify;
  //vrtlstrngtrWait.Header.Columns[2].Width:=65;

  for i := 0 to VST.Header.Columns.Count - 1 - 2 do
    begin
      VST.Header.Columns[i].Width:=RzRegIniFile1.ReadInteger('VST', 'Column' + IntToStr(i), VST.Header.Columns[i].Width);
    end;

  for i := 0 to vrtlstrngtr1.Header.Columns.Count - 1 do
    begin
      vrtlstrngtr1.Header.Columns[i].Width:=RzRegIniFile1.ReadInteger('VSTSales', 'Column' + IntToStr(i), vrtlstrngtr1.Header.Columns[i].Width);
    end;

  for i := 0 to lstArr.Columns.Count - 1 do
    begin
      lstArr.Columns[i].Width:=RzRegIniFile1.ReadInteger('VSTArr', 'Column' + IntToStr(i), lstArr.Columns[i].Width);
    end;

  for i := 0 to AdvOutlookList1.Columns.Count - 1 do
    begin
      AdvOutlookList1.Columns[i].Width:=RzRegIniFile1.ReadInteger('VSTCl', 'Column' + IntToStr(i), AdvOutlookList1.Columns[i].Width);
    end;

  for i := 0 to ListReq.Columns.Count - 1 do
    begin
      ListReq.Columns[i].Width:=RzRegIniFile1.ReadInteger('ListReq', 'Column' + IntToStr(i), ListReq.Columns[i].Width);
    end;

  for i := 0 to TovarsList.Columns.Count - 1 do
    begin
      TovarsList.Columns[i].Width:=RzRegIniFile1.ReadInteger('TovarsList', 'Column' + IntToStr(i), TovarsList.Columns[i].Width);
    end;

  //AdvOfficePager1.ActivePageIndex:=RzRegIniFile1.ReadInteger('Page', 'Active', 0);
  AdvOfficePager1.ActivePageIndex:=0;

  if RzRegIniFile1.ReadBool('Page', 'TvHotSpot', False) then
      RzSizePanel1.CloseHotSpot;

  //SetLength(FileList, 8);
  FileList[0]:='Tovars';
  FileList[1]:='Arrearage';
  FileList[2]:='Sales';
  FileList[3]:='Clients';
  FileList[4]:='Ts';
  FileList[5]:='Stock_rest';
  FileList[6]:='SDP';
  FileList[7]:='Disc';

  ListReq.SortSettings.Column:=2;
  ListReq.SortSettings.Direction:= AdvOutlookList.TSortDirection.sdDescending;

//  if DirectoryExists(DataDir) then
//    begin
//      if FileExists(DataDir + 'Tovars.xml') then
//          begin
//            try
//              LoadTvDoc(VST, DataDir + 'Tovars.xml', TvInf);
//              RzNumericEdit1.Value:=TvInf.Kurs;
//
//              UpdDateL(TvInf.VersionTovars);
//              //AdvOfficeStatusBar1.Panels[0].AppearanceStyle
//            finally
//
//            end;
//          end;
//    end;

    if DirectoryExists(DataDir) then
    begin
      if FileExists(DataDir + 'SDP.xml') then
          begin
            try
              LoadSDPDoc(VST, DataDir + 'SDP.xml', TvInf);
              RzNumericEdit1.Value:=TvInf.Kurs;

              UpdDateL(TvInf.VersionTovars);
            finally

            end;
          end;

      if FileExists(DataDir + 'Stock_rest.xml') then
          begin
            try
              LoadRestDoc(VST, DataDir + 'Stock_rest.xml', TvInf);
              UpdDateL(TvInf.VersionTovars);
            finally

            end;
          end;

      if FileExists(DataDir + 'WaitList.xml') then
          begin
            try
              LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');

              GLAv:=Av;
              GLUnAv:=UnAv;
              //UpdDateL(TvInf.VersionTovars);
            finally

            end;
          end;

      if FileExists(DataDir + 'Disc.xml') then
          begin
            try
              LoadDiscDoc(VST, DataDir + 'Disc.xml');
            finally

            end;
          end;

      try
        CalculateCost(VST, NoDisc);
      finally

      end;

      try
        if FileExists(DataDir + 'FileVersions.xml') then YFileVersions := GetFileVersions(DataDir + 'FileVersions.xml');
      finally

      end;

      if FileExists(DataDir + 'Arrearage.xml') then
          begin
            try
              if LoadArrearageDocEx(ArrOutlookList, DataDir + 'Arrearage.xml') then
                  begin
                    FillDocEx(lstArr, ArrOutlookList);
                  end;
            finally

            end;
          end;

      try
        if FileExists(DataDir + 'Sales.xml') then LoadSalesDoc(vrtlstrngtr1, DataDir + 'Sales.xml');
      finally

      end;
    end;

   ClList:=ClientSR.Create(ClientsDropDown, PointDropDown, TypeDropDown, AdvOutlookList1);

   if DirectoryExists(DataDir) then
    begin
      try
        if FileExists(DataDir + 'Clients.xml') then
            begin
              ClList.LoadClients(DataDir + 'Clients.xml');
            end;
      finally

      end;
    end;

    try
     MainRequests:=TRequests.Create(DataDir + 'Requests.xml',
                                    ListReq,
                                    ClList,
                                    Memo1,
                                    AdvDateTimePicker1,
                                    DiscountSpinEdit,
                                    TovarsList,
                                    TypeDropDown,
                                    idhtp1);

     //MainRequests.TypeDropDown        :=TypeDropDown;
     MainRequests.ClientsDropDown     :=ClientsDropDown;
     MainRequests.PointDropDown       :=PointDropDown;
     MainRequests.VST                 :=VST;
     MainRequests.OnRlSelect          :=OnRlSelect;
     MainRequests.Settings            :=Settings;
    finally

    end;

   if DirectoryExists(DataDir) then
    begin
      try
        if FileExists(DataDir + 'Requests.xml') then
            begin
              MainRequests.LoadRequests;
            end;

        if FileExists(DataDir + 'Ts.xml') then
            begin
              MainRequests.LoadTypeSal(DataDir + 'Ts.xml');
            end;
      finally

      end;
    end;

   TovarsList.ProgressAppearance.Level3Color    :=clLime;
   TovarsList.ProgressAppearance.Level3ColorTo  :=$00E1FFE1;
   TovarsList.ProgressAppearance.Level2Color    :=clYellow;
   TovarsList.ProgressAppearance.Level2ColorTo  :=$00CAFFFF;
   TovarsList.ProgressAppearance.Level1Color    :=$0053A9FF;
   TovarsList.ProgressAppearance.Level1ColorTo  :=$00A8D3FF;
   TovarsList.ProgressAppearance.Level0Color    :=clRed;
   TovarsList.ProgressAppearance.Level0ColorTo  :=$00CACAFF;
   TovarsList.ProgressAppearance.Level1Perc     :=30;
   TovarsList.ProgressAppearance.Level2Perc     :=60;
   TovarsList.ProgressAppearance.CompleteColor  :=clLime;

   AdvDateTimePicker1.DateTime:=Now;

   /////AdvToolBarMenuButton7.Click;

   rzprprtystr1.Load;

   Application.HintHidePause:=5000;
   //VST.SortTree(1, VirtualTrees.sdDescending);

   //SplashForm.Close;
end;

procedure TMainForm.UpdDateL(datestr : string);
var
  cl : string;
  dt : Double;
begin
  cl:='#000000';
    try
      dt:=VarToDateTime(datestr);

      if CompareDateTime(Now(), IncDay(dt)) = 1 then
        begin
          cl:='#FF0000';
        end;
    except

    end;

    AdvOfficeStatusBar1.Panels[0].Text:='<FONT  face="Tahoma" size="10"> Версия справочника товаров: </FONT>' + '<FONT color="' + cl + '" size="9"><b>' + datestr + '</b></FONT>';
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  //ZipMaster1.Dll_Load := False;
end;

procedure TMainForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
var
  S : TKeyboardState;
begin
  GetKeyboardState(S);

  //ShowMessage(IntToStr(Msg.CharCode));

  if S[VK_MENU] and 128 <> 0 then
      begin
        if Msg.CharCode = 84 then
            begin
              AdvOfficePager1.ActivePageIndex := 1;
              Handled := True;
            end;

        if Msg.CharCode = 82 then
            begin
              AdvOfficePager1.ActivePageIndex := 2;
              Handled := True;
            end;
      end;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  dir : string;
begin
  dir:=DataDir + 'Info\Index.html';

  if FileExists(dir) then
      begin
        InfoPage.TabVisible:=False;
        WebBrowser.Navigate(dir);
        InfoPage.TabVisible:=True;
      end
    else
      begin
        InfoPage.TabVisible:=False;
        AdvOfficePager1.ActivePageIndex:=1;
      end;
end;

procedure TMainForm.ListReqCustomCompare(Sender: TObject; Item1,
  Item2: POGLItem; Column: Integer; Value1, Value2: string;
  var SortResult: Integer);
begin
  SortResult := CompareValue(Item1.Tag, Item2.Tag);
  //CompareDateTime(VarToDateTime(Value1), VarToDateTime(Value2));
end;

procedure TMainForm.ListReqDrawItemProp(Sender: TObject; Item: POGLItem;
  Column: Integer; AValue: string; ABrush: TBrush; AFont: TFont);
begin
  if Item.Index mod 2=0 then
    begin
      //ItemCanvas.Font.Color:=$00040404;
      ABrush.Color:=$00FEDABA;
    end
  else
    begin
      //ItemCanvas.Font.Color:=$00040404;
      ABrush.Color:=$00FEFEFE;
    end;
end;

procedure TMainForm.ListReqGroupCollaps(Sender: TObject; Item: POGLItem);
begin
  ListReq.ExpandAll;
end;

procedure TMainForm.OnRlSelect(Status : integer);
begin
  if Status = 0 then
      begin
        //AdvToolBarSeparator3.Visible:=True;
        AdvToolBarMenuButton5.Visible:=True;
        //AdvToolBarSeparator2.Visible:=True;
        ////AdvToolBarMenuButton4.Visible:=True;

        N27.Visible:=True;
        N28.Visible:=True;
        N29.Visible:=True;
      end
    else
      begin
        //AdvToolBarSeparator3.Visible:=False;
        AdvToolBarMenuButton5.Visible:=False;
        //AdvToolBarSeparator2.Visible:=False;
        ////AdvToolBarMenuButton4.Visible:=False;

        N27.Visible:=False;
        N28.Visible:=False;
        N29.Visible:=False;
      end;

   rzglyphsts1.ImageIndex:= Status;

   case Status of
      0 : rzglyphsts1.Caption:='- Не отправлена';
      1 : rzglyphsts1.Caption:='- Отправлена';
      2 : rzglyphsts1.Caption:='- Принята';

      else rzglyphsts1.Caption:='';
   end;
end;

procedure TMainForm.pm1Popup(Sender: TObject);
var
  Data: PTreeData;
begin
  if VST.SelectedCount > 0 then
      begin
        Data:=VST.GetNodeData(VST.GetFirstSelected);

        if not Data^.Root then
            begin
              if not Data^.Status then
                  begin
                    N36.Visible := False;
                    N38.Visible := True;
                    //MessageDlg('Выбранного товара нет в наличии', mtInformation, [mbOK], 0) ;
                    //exit;
                  end
                else
                  begin
                    N36.Visible := True;
                    N38.Visible := True;
                  end;
            end
          else
            begin
              N36.Visible := False;
              N38.Visible := False;
            end;
      end;
end;

procedure TMainForm.pm2Popup(Sender: TObject);
var
  Data: PTreeData;
begin
  if vrtlstrngtrWait.SelectedCount > 0 then
      begin
        Data:=vrtlstrngtrWait.GetNodeData(vrtlstrngtrWait.GetFirstSelected);

        if not Data^.Root then
            begin
              if not Data^.Status then
                  begin
                    MenuItem1.Visible := False;
                    MenuItem2.Visible := True;
                    //MessageDlg('Выбранного товара нет в наличии', mtInformation, [mbOK], 0) ;
                    //exit;
                  end
                else
                  begin
                    MenuItem1.Visible := True;
                    MenuItem2.Visible := True;
                  end;
            end
          else
            begin
              MenuItem1.Visible := False;
              MenuItem2.Visible := False;
            end;
      end;
end;

procedure TMainForm.rzglyphsts1Click(Sender: TObject);
//var
//  ProxyEnabled: boolean;
//  ProxyServer: string;
//  ProxyPort: integer;
//
//
//  Result: DWORD;
//  ProxyInfo: TProxyInfo;

begin

//  GetProxyData(ProxyEnabled, ProxyServer, ProxyPort);
//
//  if ProxyEnabled then
//    ShowMessage(ProxyServer + ':' + IntToStr(ProxyPort))
//  else
//    ShowMessage('-');
//
//
//
//
//  case GetProxyInfo('192.168.2.240:8080', ProxyInfo) of
//    0:
//      ShowMessage(
//        'Proxy URL: ' + ProxyInfo.ProxyURL + sLineBreak +
//        'Proxy bypass: ' + ProxyInfo.ProxyBypass +
//        'Proxy autodetected: ' + BoolToStr(ProxyInfo.ProxyAutoDetected, True));
//    12166: ShowMessage('Error in proxy auto-config script code');
//    12167: ShowMessage('Unable to download proxy auto-config script');
//    12180: ShowMessage('WPAD detection failed');
//  else
//    ShowMessage('Last error: ' + IntToStr(Result));
//  end;


end;

procedure TMainForm.N10Click(Sender: TObject);
Var
  i: Integer;
  Tmp : TMenuItem;
begin
  for i := 0 to AdvPopupMenu.Items.Count - 1 do
      begin
        Tmp := TMenuItem(Sender);

        if AdvPopupMenu.Items[i].Name = Tmp.Name then
            begin
              AdvPopupMenu.Items[i].Checked := True;
              btnUpdate.Caption:=AdvPopupMenu.Items[i].Caption;
              UpdateIndx:=AdvPopupMenu.Items[i].Tag;
            end
          else
            AdvPopupMenu.Items[i].Checked := False;
      end;
end;

procedure TMainForm.N17Click(Sender: TObject);
var
  KeySl : TStringList;
  i     : Integer;
begin
  if OpenDialog1.Execute then
      begin
        if not (LoadKey(OpenDialog1.FileName) and xcheck) then
            begin
              KeySl:=FindFileInFolder(ExtractFilePath(Application.ExeName), '*.key');
              LoadKey(KeySl[0]);
              KeySl.Free;
              MessageDlg('Ошибка открытия ключа. Ключ не изменен.', mtError, [mbOK], 0);
            end
          else
            begin
              KeySl:=FindFileInFolder(ExtractFilePath(Application.ExeName), '*.key');
              for i := 0 to KeySl.Count - 1 do
                begin
                  DeleteFile(KeySl[i]);
                end;

              if CopyFileTo(OpenDialog1.FileName, ExtractFilePath(Application.ExeName) + ExtractFileName(OpenDialog1.FileName)) then
                  begin
                    MainRequests.Settings:=Settings;

                    MessageDlg('Ключ успешно изменен.', mtInformation, [mbOK], 0);
                  end;
            end;
      end;
end;

procedure TMainForm.N18Click(Sender: TObject);
var
  S: string;
  ShellInfo: TShellExecuteInfo;
begin
  FillChar( ShellInfo, SizeOf( TShellExecuteInfo ), 0 );
  ShellInfo.cbSize := SizeOf( TShellExecuteInfo );
  ShellInfo.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI or
                       SEE_MASK_FLAG_DDEWAIT;

  ShellInfo.Wnd := HWnd_Desktop;
  ShellInfo.lpVerb := 'Open';
  ShellInfo.lpFile := PChar(Settings.URL);
  ShellInfo.lpParameters := nil;
  ShellInfo.lpDirectory := nil;
  ShellInfo.nShow := sw_ShowNormal;

  if ShellExecuteEx( @ShellInfo ) then

  else
    begin
      if UpperCase(ExtractFileExt(S)) = '.HTM' then
        WinExec( 'RunDLL32.exe Shell32.dll,OpenAs_RunDLL *.htm', sw_ShowNormal );
    end;
end;

procedure TMainForm.N20Click(Sender: TObject);
Var
  i: Integer;
  Tmp : TMenuItem;
begin
  for i := 0 to advpmnSearchType.Items.Count - 1 do
      begin
        Tmp := TMenuItem(Sender);

        if advpmnSearchType.Items[i].Name = Tmp.Name then
            begin
              btnSearchType.Caption:=advpmnSearchType.Items[i].Caption;
              btnSearchType.Tag:=advpmnSearchType.Items[i].Tag;
              advpmnSearchType.Items[i].Checked:=True;
            end
          else
            advpmnSearchType.Items[i].Checked := False;
      end;
  edtSearchChange(Sender);
end;

procedure TMainForm.N23Click(Sender: TObject);
begin
  btnUpdateClick(Sender);
end;

procedure TMainForm.N24Click(Sender: TObject);
begin
  MainRequests.CheckAndDeleteTv;
end;

procedure TMainForm.N25Click(Sender: TObject);
begin
  if MainRequests.SelectedItem = -1 then
      begin
        MessageDlg('Не выбрана заявка', mtInformation, [mbOK], 0);
        exit;
      end;

  MainRequests.SaveAsExcelFile('Заявка', 'Заявка');
end;

procedure TMainForm.N27Click(Sender: TObject);
begin
  AdvToolBarMenuButton5Click(Sender);
end;

procedure TMainForm.N29Click(Sender: TObject);
begin
  AdvToolBarMenuButton4Click(Sender);
end;

procedure TMainForm.N2Click(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.N35Click(Sender: TObject);
begin
  TovarsListItemDblClick(TovarsList, TovarsList.FirstSelectedItem, 0);
end;

procedure TMainForm.N36Click(Sender: TObject);
begin
  VSTDblClick(VST);
end;

procedure TMainForm.N38Click(Sender: TObject);
var
  Data      : PTreeData;
  Av, UnAv  : Integer;
begin
  if VST.SelectedCount > 0 then
      begin
        Data:=VST.GetNodeData(VST.GetFirstSelected);

        if not Data^.Root then
            begin
              if AddToWaitList(Data^.Code, DataDir + 'WaitList.xml') then
                  begin
                    LoadWaitFile(VST, vrtlstrngtrWait, Av, UnAv, DataDir + 'WaitList.xml');
                    GLAv:=Av;
                    GLUnAv:=UnAv;
                  end;
            end;
      end;
end;

procedure TMainForm.N6Click(Sender: TObject);
begin
  RzLauncher1.FileName:=ExtractFileDir(Application.ExeName) + '\Help.txt';
  RzLauncher1.Launch;
end;

procedure TMainForm.N8Click(Sender: TObject);
begin
  AboutForm:=TAboutForm.Create(Application);
  AboutForm.ShowModal;
  AboutForm.Free;
end;

procedure TMainForm.N9Click(Sender: TObject);
begin
  SettingsForm:=TSettingsForm.Create(Application);
  if SettingsForm.ShowModal = mrOK then
      begin
        idFTP1.Host:=SettingsForm.AddressEdit.Text;
        idFTP1.Username:=SettingsForm.SrvUserEdit.Text;
        idFTP1.Password:=SettingsForm.SrvPassEdit.Text;
        idFTP1.Passive:= SettingsForm.PassiveCheckBox.Checked;
        idFTP1.Port:= SettingsForm.PortEdit.IntValue;

        fDir:= SettingsForm.DirEdit.Text;

        RzRegIniFile1.WriteString('ServerSettings', 'Host', idFTP1.Host);
        RzRegIniFile1.WriteString('ServerSettings', 'Pass', xCompressString(idFTP1.Password, clMax, zsRaw));
        RzRegIniFile1.WriteString('ServerSettings', 'UserName', idFTP1.Username);
        RzRegIniFile1.WriteBool('ServerSettings', 'Passive', idFTP1.Passive);
        RzRegIniFile1.WriteInteger('ServerSettings', 'Port', idFTP1.Port);
        RzRegIniFile1.WriteString('ServerSettings', 'Dir', fDir);
      end;
end;

procedure TMainForm.VSTBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  Data: PTreeData;
begin
  //if Assigned(Node) and ((Column <> Sender.FocusedColumn) or (Node <> Sender.FocusedNode)) and
    //((Column - 2) = (Integer(Node.Index) mod (VST5.Header.Columns.Count - 1))) then
  Data:=VST.GetNodeData(Node);

  if (Column = 2) and not Data^.Root then
  begin
    TargetCanvas.Brush.Color := $00FFD7AE;
    TargetCanvas.FillRect(CellRect);
  end;

  if (Column = 4) and not Data^.Root  then
  begin
    TargetCanvas.Brush.Color := $0075BAFF;
    TargetCanvas.FillRect(CellRect);
  end;
end;

procedure TMainForm.VSTChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  VST.Refresh;
end;

procedure TMainForm.VSTCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  Data1 : PTreeData;
  Data2 : PTreeData;
begin
  if Column = 0 then
    begin
      Data1 := VST.GetNodeData(Node1);
      Data2 := VST.GetNodeData(Node2);

      if (not Assigned(Data1)) or (not Assigned(Data2)) then
        Result:=0
      else
        begin
          if Data1^.Root then
                Result:=0
              else
                Result := StrCmpLogical(Data1^.Name, Data2^.Name);

          //if VST.Header.SortDirection = VirtualTrees.sdAscending then
              //begin
                //Result := StrCmpLogical(Data1^.Name, Data2^.Name);
              //end
            //else
              //begin
              //  Result := (-1) * StrCmpLogical(Data1^.Name, Data2^.Name);
              //end;
        end;
    end;
end;

function ShiftDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Shift] and 128) <> 0);
end;

function CtrlDown : Boolean;
var
  State : TKeyboardState;
begin
  GetKeyboardState(State);
  Result := ((State[vk_Control] and 128) <> 0);
end;

procedure TMainForm.VSTDblClick(Sender: TObject);
var
  Data: PTreeData;
  VL  : TVirtualStringTree;
begin
  VL :=  Sender as TVirtualStringTree;

  if VL.SelectedCount > 0 then
      begin
        Data:=VL.GetNodeData(VL.GetFirstSelected);

        if not Data^.Root then
            begin
              if not Data^.Status then
                  begin
                    MessageDlg('Выбранного товара нет в наличии', mtInformation, [mbOK], 0) ;
                    exit;
                  end;

              if MainRequests.SelectedItem = -1 then
                  begin
                    if MessageDlg('Не выбрана заявка. Создать новую заявку?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
                        btnAdvToolBarAddReqClick(Sender)
                      else
                        exit;
                  end;

              if MainRequests.GetReqStatus(MainRequests.SelectedItem)> 0 then
                  begin
                    MessageDlg('В выбранную заявку нельзя добавить товар. Так как заявка уже была отправлена', mtInformation, [mbOK], 0);
                    exit;
                  end;

              AddForm.Add:=True;

              AddForm.RzMemo1.Text:=Data^.Name;
              if Cash = 0 then
                  AddForm.Cost:=Data^.Cost1Dbl
                else
                  AddForm.Cost:=Data^.Cost2Dbl;

              AddForm.Code:=StrToInt(Data^.Code);

              AddForm.Cost1:=Data^.Cost1Dbl;
              AddForm.Cost2:=Data^.Cost2Dbl;

              AddForm.MinR:=Data^.MinR;

              if Cash = 1 then
                  AddForm.RzStatusPane2.Caption:='Стоимость: ' + Data^.Cost2 + ' USD'
                else
                  AddForm.RzStatusPane2.Caption:='Стоимость: ' + Data^.Cost1 + ' Бел. руб.';

              AddForm.RzSpinEdit1.OnChange(sender);
              AddForm.ShowModal;

              if ShiftDown or CtrlDown then MainForm.edtSearch.Text:='';
            end;
      end;
end;

procedure TMainForm.VSTFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Data        : PTreeData;

  i           : integer;
  olg         : TOutlookGroup;
  sl          : TStrings;
begin  if not RzSizePanel1.HotSpotClosed then
      begin
        Data:=VST.GetNodeData(Node);

        lst1.BeginUpdate;
        try
          lst1.ClearGroups;

          if not Data^.Root then
            begin
              olg := lst1.AddGroup('Номера О.Е.М.');

              for i := 0 to Length(Data^.OEMNum) - 1 do
                begin
                  sl := lst1.AddItem(olg);
                  sl.Add(Data^.OEMNum[i]);

                  if edtSearch.Text <> '' then
                      begin
                        if Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(Data^.OEMNum[i], loUserLocale)) > 0 then
                            begin
                              lst1.Groups[0].ChildOGLItem[i].Tag:=1;
                            end;
                      end
                    else
                      lst1.Groups[0].ChildOGLItem[i].Tag:=2;
                end;

              olg := lst1.AddGroup('Референц номера');

              for i := 0 to Length(Data^.RefNum) - 1 do
                begin
                  sl := lst1.AddItem(olg);
                  sl.Add(Data^.RefNum[i]);

                  if edtSearch.Text <> '' then
                      begin
                        if Pos(LowerCase(edtSearch.Text, loUserLocale), LowerCase(Data^.RefNum[i], loUserLocale)) > 0 then
                            begin
                              lst1.Groups[1].ChildOGLItem[i].Tag:=1;
                            end;
                      end
                    else
                      lst1.Groups[1].ChildOGLItem[i].Tag:=2;
                end;
            end;

        finally
          lst1.EndUpdate;
        end;
      end;



  //if (tsToggleFocusedSelection in Leave) then ShowMessage('ffffrr');
end;

procedure TMainForm.VSTFocusChanging(Sender: TBaseVirtualTree; OldNode,
  NewNode: PVirtualNode; OldColumn, NewColumn: TColumnIndex;
  var Allowed: Boolean);
begin
  VST.Refresh;
end;

procedure TMainForm.VSTFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PTreeData;
begin
  Data:=VST.GetNodeData(Node);
  if Assigned(Data) then
      begin
        Data^.Name := '';
      end;
end;

procedure TMainForm.VSTGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PTreeData;
begin
  Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      begin
        if (Column = 0) {and (Node.Parent = Sender.RootNode)} then
            ImageIndex := Data.ImageIndex;

        if (Column = 5) {and (Node.Parent = Sender.RootNode)} then
        begin
          case Data.DynOfPrices of
            0: ImageIndex := -1;
            1: ImageIndex := 9;
            2: ImageIndex := 10;
          end;
        end;


        if ((Column = 6) or (Column = 7)) and not Data.Root then
            if Cash = 1 then ImageIndex := 7
                else
                  ImageIndex := 6;

        if ((Column = 8) or (Column = 9)) and not Data.Root then
            if Cash = 1 then ImageIndex := 6
                else
                  ImageIndex := 7;
      end;
  end;



if Kind in [ikNormal , ikSelected] then // Either Selected or not
  begin
    //if Column = 0 then                    // if 1st Column
      //ImageIndex:=0;                      // 1st Image of the ImageList1

    //if Column = 1 then                    // if 2nd Column
      //ImageIndex:=1;                      // 2nd Image of the ImageList1

    //if Sender.FocusedNode = Node then     // Only show if Focused
      //if Column =2 then                    // if 3rd Column
        //ImageIndex:=2;                      // 3rd Image of the ImageList1
  end;
  {Sender.NodeHeight[node]:=40; //If Image is big}
  {Data := Sender.GetNodeData(Node);
  case Kind of
    ikNormal, ikSelected:
      if (Column = 0) and (Node.Parent = Sender.RootNode) then
        ImageIndex := Data.Image;
    ikState:
      case Column of
        0:
          if Node.Parent <> Sender.RootNode then
            ImageIndex := 1;
      end;
  end; }
end;

procedure TMainForm.VSTGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TTreeData);
end;

procedure TMainForm.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
  Data: PTreeData;
begin
  Data := VST.GetNodeData(Node);
  FormatSettings.CurrencyString:='';

  case Column of
    0:  CellText := Data^.Name;
    1:  CellText := Data^.Code;
    2:  CellText := Data^.Ost;
    3:  CellText := Data^.Disc;
    4:  CellText := Data^.CntInP;
    5:  begin
          case Data^.DynOfPrices of
            0: CellText := '';
            1: CellText := 'Повышение цены';
            2: CellText := 'Снижение цены';
          end;
        end;

    6:  begin
          if Cash = 1 then
              CellText := Data^.Cost2
            else
              CellText := Data^.Cost1;
        end;
    7:  begin
          if Data^.Root then  CellText := ''
          else
            if Cash = 1 then
                CellText := FloatToStrF(Data^.Cost2Dbl * (1 + (edt1.Value / 100)), ffCurrency, 12, 3)
              else
                CellText := FloatToStrF(Data^.Cost1Dbl * (1 + (edt1.Value / 100)), ffCurrency, 12, 2)
        end;
    8:  begin
          if Cash = 1 then
              CellText := Data^.Cost1
            else
              CellText := Data^.Cost2;
        end;
    9:  begin
          if Data^.Root then  CellText := ''
          else
            if Cash = 1 then
                CellText := FloatToStrF(Data^.Cost1Dbl * (1 + (edt1.Value / 100)), ffCurrency, 12, 0)
              else
                CellText := FloatToStrF(Data^.Cost2Dbl * (1 + (edt1.Value / 100)), ffCurrency, 12, 3)
        end;
  end;
end;

procedure TMainForm.VSTHeaderClick(Sender: TVTHeader;
  HitInfo: TVTHeaderHitInfo);
var
  XNode     : PVirtualNode;
  Data      : PTreeData;
begin
  vst.SortTree(VST.Header.SortColumn, Sender.SortDirection, True);
//  XNode := VST.GetFirst;
//
//  repeat
//    XNode:= VST.GetNext(XNode);
//    Data:=VST.GetNodeData(XNode);
//
//    if not Data^.Root then
//      begin
//        VST.Sort(XNode, 0, VSTSortDirection);
//        Break;
//      end;
//
//  until XNode = VST.GetLast;


  if Sender.SortDirection=VirtualTrees.sdAscending then
      Sender.SortDirection:=VirtualTrees.sdDescending
    else
      Sender.SortDirection:=VirtualTrees.sdAscending;
end;

procedure TMainForm.VSTInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Level: Integer;
begin
  Level := VST.GetNodeLevel(Node);

  if Level = 1 then
  begin
    //Node.CheckType:=ctTriStateCheckBox;
    //Node.CheckState := csCheckedNormal;
  end;
end;

procedure TMainForm.VSTKeyPress(Sender: TObject; var Key: Char);
var
    Control: TControl;
begin
  if Ord(Key) = 13 then VSTDblClick(Sender);

  Control:=edtSearch;
  Control.Perform(WM_CHAR, Ord(Key), 0);
end;

procedure TMainForm.VSTPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
begin
  if Column = 1 then
  begin
    TargetCanvas.Font.Color:=$007D1004;
  end;
end;

procedure TMainForm.WebBrowserBeforeNavigate2(ASender: TObject;
  const pDisp: IDispatch; var URL, Flags, TargetFrameName, PostData,
  Headers: OleVariant; var Cancel: WordBool);
var
   newURL: string;
 begin
   newURL := URL;

  if AnsiCompareStr(LowerCase(DataDir + 'Info\Index.html'), LowerCase(newURL)) <> 0 then
   begin
     Cancel := True;
     ShellExecute(Application.Handle, 'open', PChar(newURL), nil, nil, SW_NORMAL);
   end;
end;

end.
