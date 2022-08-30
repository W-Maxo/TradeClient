unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzEdit, StdCtrls, Mask, RzStatus, RzPanel,
  ExtCtrls, AES, ElAES, IdHashMessageDigest, IdHash, Math, RzForms, RzCommon,
  inifiles, RzLstBox, AdvOutlookList;
type
  TProgrammSettings = class
    FileName        : string;
  
    ID              : String;
    Pass            : String;
    Name            : String;
    LName           : String;
    CName           : String;
    Tel             : String;
    Address         : String;
    Email           : String;
    ftp             : String;
    Port            : integer;
    PM              : bool;
    Dir             : String;
    SUSSName        : String;
    SUSSPass        : String;
    TvA             : bool;
    ReqA            : bool;
    ArA             : bool;
    SlA             : bool;
    URL             : String;
    Fax             : String;
    FSTR            : string;
  end;

type
  TForm2 = class(TForm)
    RzPanel1: TRzPanel;
    RzGroupBox1: TRzGroupBox;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane7: TRzStatusPane;
    AddressEdit: TRzEdit;
    PortEdit: TRzNumericEdit;
    SrvPassEdit: TRzMaskEdit;
    SrvUserEdit: TRzEdit;
    DirEdit: TRzEdit;
    PassiveCheckBox: TRzCheckBox;
    RzGroupBox2: TRzGroupBox;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane6: TRzStatusPane;
    IDUserEdit: TRzEdit;
    PasswordEdit: TRzMaskEdit;
    RzGroupBox3: TRzGroupBox;
    RzStatusPane8: TRzStatusPane;
    RzStatusPane9: TRzStatusPane;
    RzEdit1: TRzEdit;
    RzMaskEdit1: TRzMaskEdit;
    RzStatusPane10: TRzStatusPane;
    RzStatusPane11: TRzStatusPane;
    RzEdit2: TRzEdit;
    RzMaskEdit2: TRzMaskEdit;
    RzStatusPane12: TRzStatusPane;
    RzMaskEdit3: TRzMaskEdit;
    RzStatusPane13: TRzStatusPane;
    RzMaskEdit4: TRzMaskEdit;
    RzGroupBox4: TRzGroupBox;
    RzCheckBox1: TRzCheckBox;
    RzCheckBox2: TRzCheckBox;
    RzCheckBox3: TRzCheckBox;
    RzCheckBox4: TRzCheckBox;
    RzBitBtn1: TRzBitBtn;
    RzRegIniFile1: TRzRegIniFile;
    RzPropertyStore1: TRzPropertyStore;
    RzFormState1: TRzFormState;
    SaveDialog1: TSaveDialog;
    RzMaskEdit5: TRzMaskEdit;
    RzStatusPane14: TRzStatusPane;
    RzMaskEdit6: TRzMaskEdit;
    RzStatusPane15: TRzStatusPane;
    rzpnl1: TRzPanel;
    lstLisr: TAdvOutlookList;
    rzstspn1: TRzStatusPane;
    edt1: TRzEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RzBitBtn1Click(Sender: TObject);
    procedure lstLisrSelectionChange(Sender: TObject);
    procedure LoadList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function StrToMD5Str(Str : String) : String;
Var
  md5indy   : TIdHashMessageDigest;
begin
  md5indy   :=TIdHashMessageDigest5.Create;
  Result    :=md5indy.HashStringAsHex(Str);
end;

function Encrypt(var DestStream, Res: TMemoryStream) : Boolean;
var
  Size: integer;
  Key: TAESKey128;
begin
  Result:=False;

  Res.Position:=0;
  DestStream.Clear;
  DestStream.Position:=0;

  Size := Res.Size;
  DestStream.WriteBuffer(Size, SizeOf(Size));

  FillChar(Key, SizeOf(Key), 0);
  Move(PChar(StrToMD5Str(StrToMD5Str('{8D8AF430-A6D4-4BD4-A39F-4AB8039917DE}')))^, Key, Min(SizeOf(Key),
      Length(StrToMD5Str(StrToMD5Str('{8D8AF430-A6D4-4BD4-A39F-4AB8039917DE}')))));

  EncryptAESStreamECB(Res, 0, Key, DestStream);

  Res.Position:=0;
  DestStream.Position:=0;

  Result:=True;
end;

function Decrypt(var DecrStream, EncrRes : TMemoryStream) : Boolean;
var
  Size             : integer;
  Key              : TAESKey128;
begin
  DecrStream.Clear;

  DecrStream.Position:=0;
  EncrRes.Position:=0;

  EncrRes.ReadBuffer(Size, SizeOf(Size));

  FillChar(Key, SizeOf(Key), 0);
  Move(PChar(StrToMD5Str(StrToMD5Str('{8D8AF430-A6D4-4BD4-A39F-4AB8039917DE}')))^,
      Key, Min(SizeOf(Key),
  Length(StrToMD5Str(StrToMD5Str('{8D8AF430-A6D4-4BD4-A39F-4AB8039917DE}')))));

  DecryptAESStreamECB(EncrRes, EncrRes.Size - EncrRes.Position, Key, DecrStream);

  DecrStream.Size := Size;
  DecrStream.Position:=0;
  EncrRes.Position:=0;

  Result:=True;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i : Integer;
begin
  //RzPropertyStore1.Save;

  for i := 0 to lstLisr.Columns.Count - 1 do
    begin
      RzRegIniFile1.WriteInteger('List', 'Column' + IntToStr(i), lstLisr.Columns[i].Width);
    end;
end;

function LoadKey(keyFileName : string) : TProgrammSettings;
var
  fStream         : TMemoryStream;
  TmpStream       : TMemoryStream;
  ini             : TMemIniFile;
  sl              : TStrings;

  Settings        : TProgrammSettings;
  SettingsEmp     : TProgrammSettings;
begin
  try
    fStream := TMemoryStream.Create;
    fStream.LoadFromFile(keyFileName);

    TmpStream:=TMemoryStream.Create();
    Decrypt(TmpStream, fStream);

    sl:=TStringList.Create;
    sl.LoadFromStream(TmpStream);

    ini:=TMemIniFile.Create('');
    ini.SetStrings(sl);

    Settings:=TProgrammSettings.Create;

    with Settings do
      begin
        FileName        :=ExtractFileName(keyFileName);
      
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

        if Copy(URL, 1, 7) <> 'http://' then URL := 'http://' + URL;

        Fax             :=ini.ReadString ('Trading agent', 'FAX',      '');

        {idFTP1.Host     :=ftp;

        idFTP1.Username :=SUSSName;
        idFTP1.Passive  :=PM;
        idFTP1.Port     :=Port;
        idFTP1.Password :=SUSSPass;
        fDir            :=Dir;}

        //MainForm.Caption:='Mannol Trade ' + ' ' + Settings.CName + ' (' + Settings.Name + ' ' + Settings.LName + ')';
      end;

    sl.Free;
    TmpStream.Free;
    fStream.Free;
    ini.Free;

    //ShowPages;

    Result:=Settings;
  except
    SettingsEmp:=TProgrammSettings.Create;
    Result:=SettingsEmp;
  end;
end;

function FindFileInFolder(path, ext: string) : TStringList;
Var SR    : TSearchRec;
    Res   : Integer;
    Sl    : TStringList;
begin
  Sl:=TStringList.Create;;

  Res := FindFirst(path + ext, faAnyFile, SR);
  while Res = 0 do
  begin
    Sl.Add(path + Sr.Name);
    Res := FindNext(SR);
  end;
  SysUtils.FindClose(SR);
  Result:=Sl;
end;

procedure TForm2.LoadList;
var
  reqolg              : TOutlookGroup;
  reqsl               : TStrings;

  KeySl               : TStringList;

  Settings            : TProgrammSettings;
  i                   : integer;
begin
  lstLisr.ClearGroups;
  reqolg := lstLisr.AddGroup('');

  KeySl :=TStringList.Create;
  KeySl:=FindFileInFolder(ExtractFilePath(Application.ExeName) + '\Keys\', '*.key');

  for i := 0 to KeySl.Count - 1 do
    begin


      Settings:=LoadKey(KeySl[i]);


      reqsl := lstLisr.AddItem(reqolg);

      reqsl.Add(ExtractFileName(KeySl[i]));
      reqsl.Add(Settings.ID);
      reqsl.Add(Settings.Name);
      reqsl.Add(Settings.LName);

      reqolg.ChildOGLItem[i].ItemObject := TObject(Settings);

      {reqsl.Add(RequestsArray[indx].DCreate);
      reqsl.Add(ClList.GetNameClientFromUNN(RequestsArray[indx].UNN, RequestsArray[indx].IDPoint).Name);
      RequestsArray[indx].FullSum:=RequestsArray[indx].FullSum;
      reqsl.Add(FloatToStr(RequestsArray[indx].FullSum));
      reqsl.Add('');

      if RequestsArray[indx].Status = 0 then
          begin
            reqsl.Add('13');
            reqsl.Add('11');
          end
        else
          begin
            reqsl.Add('12');
            reqsl.Add('10');
          end;

      reqolg.ChildOGLItem[indx].ItemObject := TObject(indx);
      reqolg.ChildOGLItem[indx].Tag:=indx;

      if not LoadL then
        begin
          LisrReq.SelectItem(reqolg.ChildOGLItem[indx]);
        end;

      LisrReq.Sort;}
    end;


  for i := 0 to lstLisr.Columns.Count - 1 do
    begin
      lstLisr.Columns[i].Width:=RzRegIniFile1.ReadInteger('List', 'Column' + IntToStr(i), lstLisr.Columns[i].Width);
    end;

  //RzPropertyStore1.Load;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  LoadList;
end;

procedure TForm2.lstLisrSelectionChange(Sender: TObject);
var
  setings : TProgrammSettings;
begin
  if (lstLisr.Groups[0].ChildCount > 0) and (lstLisr.SelectedCount > 0) then
      begin
        setings:=TProgrammSettings(lstLisr.FirstSelectedItem.ItemObject);

        edt1.Text:=setings.FileName;

        //'ID='
        IDUserEdit.Text:=setings.ID;
        //'Pass='
        PasswordEdit.Text:=setings.Pass;
        //'Name='
        RzEdit2.Text:=setings.Name;
        //'LName='
        RzMaskEdit2.Text:=setings.LName;
        //'CName='
        RzEdit1.Text:=setings.CName;
        //'Tel='
        RzMaskEdit1.Text:=setings.Tel;
        //'Address='
        RzMaskEdit3.Text:=setings.Address;
        //'Email='
        RzMaskEdit4.Text:=setings.Email;
        //'ftp='
        AddressEdit.Text:=setings.ftp;
        //'Port='
        PortEdit.IntValue:=setings.Port;
        //'PM='
        PassiveCheckBox.Checked:=setings.PM;
        //'Dir='
        DirEdit.Text:=setings.Dir;
        //'SUSSName='
        SrvUserEdit.Text:=setings.SUSSName;
        //'SUSSPass='
        SrvPassEdit.Text:=setings.SUSSPass;
        //'TvA='
        RzCheckBox1.Checked:=setings.TvA;
        //'ReqA='
        RzCheckBox2.Checked:=setings.ReqA;
        //'ArA='
        RzCheckBox3.Checked:=setings.ArA;
        //'SlA='
        RzCheckBox4.Checked:=setings.SlA;
        //'URL='
        RzMaskEdit5.Text:=setings.URL;
        //'FAX='
        RzMaskEdit6.Text:=setings.Fax;
      end
    else
      begin
        //SelectedItem:= -1;
        //TovarsList.ClearGroups;
      end;
end;

function xBoolToStr(B: Boolean): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '1');
begin
  Result := cSimpleBoolStrs[B];
end;

procedure TForm2.RzBitBtn1Click(Sender: TObject);
var
  fStream       : TMemoryStream;
  TmpStream     : TMemoryStream;

  Sl            : TStringList;

  Ini           : TIniFile;
begin
  //SaveDialog1.FileName:=IDUserEdit.Text + '.key';

        Sl := TStringList.Create;

        Sl.Add('[Trading agent]');
        Sl.Add('ID='        + IDUserEdit.Text);
        Sl.Add('Pass='      + PasswordEdit.Text);
        Sl.Add('Name='      + RzEdit2.Text);
        Sl.Add('LName='     + RzMaskEdit2.Text);
        Sl.Add('CName='     + RzEdit1.Text);
        Sl.Add('Tel='       + RzMaskEdit1.Text);
        Sl.Add('Address='   + RzMaskEdit3.Text);
        Sl.Add('Email='     + RzMaskEdit4.Text);
        Sl.Add('ftp='       + AddressEdit.Text);
        Sl.Add('Port='      + IntToStr(PortEdit.IntValue));
        Sl.Add('PM='        + xboolToStr(PassiveCheckBox.Checked));
        Sl.Add('Dir='       + DirEdit.Text);
        Sl.Add('SUSSName='  + SrvUserEdit.Text);
        Sl.Add('SUSSPass='  + SrvPassEdit.Text);
        Sl.Add('TvA='       + xboolToStr(RzCheckBox1.Checked));
        Sl.Add('ReqA='      + xboolToStr(RzCheckBox2.Checked));
        Sl.Add('ArA='       + xboolToStr(RzCheckBox3.Checked));
        Sl.Add('SlA='       + xboolToStr(RzCheckBox4.Checked));
        Sl.Add('URL='       + RzMaskEdit5.Text);
        Sl.Add('FAX='       + RzMaskEdit6.Text);

        //ShowMessage(xboolToStr(RzCheckBox2.Checked));

        fStream := TMemoryStream.Create;
        Sl.SaveToStream(fStream);

        TmpStream:=TMemoryStream.Create(); //  fmOpenWrite
        Encrypt(TmpStream, fStream);

        TmpStream.SaveToFile(ExtractFilePath(Application.ExeName) + '\Keys\' + edt1.Text);

        /////////////////////////////
        ///
        ///
        ///
        ///

        //Decrypt(fStream, TmpStream);

        //sl.LoadFromStream(fStream);




        //Showmessage(Sl.Text);

        fStream.Free;
        TmpStream.Free;
        Sl.Free;

        LoadList;

end;

end.
