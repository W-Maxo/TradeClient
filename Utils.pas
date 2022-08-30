unit Utils;

interface

uses
  SysUtils, IOUtils, Dialogs, Windows, ZipMstr19, XMLDoc, Forms, IdFTP, Classes,
  IdZLibCompressorBase, IdCompressorZLib, IDZlib, IdZLibHeaders, IdGlobal, IdHash,
  IdHashMessageDigest, AES, ElAES, Math, MyTypes, advoutlooklist, WinInet, Registry,
  VirtualTrees;

  type
  HINTERNET = Pointer;
  {$EXTERNALSYM HINTERNET}
  INTERNET_PORT = Word;
  {$EXTERNALSYM INTERNET_PORT}

  PWinHTTPProxyInfo = ^TWinHTTPProxyInfo;
  WINHTTP_PROXY_INFO = record
    dwAccessType: DWORD;
    lpszProxy: LPWSTR;
    lpszProxyBypass: LPWSTR;
  end;
  {$EXTERNALSYM WINHTTP_PROXY_INFO}
  TWinHTTPProxyInfo = WINHTTP_PROXY_INFO;
  LPWINHTTP_PROXY_INFO = PWinHTTPProxyInfo;
  {$EXTERNALSYM LPWINHTTP_PROXY_INFO}

  PWinHTTPAutoProxyOptions = ^TWinHTTPAutoProxyOptions;
  WINHTTP_AUTOPROXY_OPTIONS = record
    dwFlags: DWORD;
    dwAutoDetectFlags: DWORD;
    lpszAutoConfigUrl: LPCWSTR;
    lpvReserved: Pointer;
    dwReserved: DWORD;
    fAutoLogonIfChallenged: BOOL;
  end;
  {$EXTERNALSYM WINHTTP_AUTOPROXY_OPTIONS}
  TWinHTTPAutoProxyOptions = WINHTTP_AUTOPROXY_OPTIONS;
  LPWINHTTP_AUTOPROXY_OPTIONS = PWinHTTPAutoProxyOptions;
  {$EXTERNALSYM LPWINHTTP_AUTOPROXY_OPTIONS}

  PWinHTTPCurrentUserIEProxyConfig = ^TWinHTTPCurrentUserIEProxyConfig;
  WINHTTP_CURRENT_USER_IE_PROXY_CONFIG = record
    fAutoDetect: BOOL;
    lpszAutoConfigUrl: LPWSTR;
    lpszProxy: LPWSTR;
    lpszProxyBypass: LPWSTR;
  end;
  {$EXTERNALSYM WINHTTP_CURRENT_USER_IE_PROXY_CONFIG}
  TWinHTTPCurrentUserIEProxyConfig = WINHTTP_CURRENT_USER_IE_PROXY_CONFIG;
  LPWINHTTP_CURRENT_USER_IE_PROXY_CONFIG = PWinHTTPCurrentUserIEProxyConfig;
  {$EXTERNALSYM LPWINHTTP_CURRENT_USER_IE_PROXY_CONFIG}

  TProxyInfo = record
    ProxyURL: WideString;
    ProxyBypass: WideString;
    ProxyAutoDetected: Boolean;
  end;

  function WinHttpOpen(pwszUserAgent: LPCWSTR; dwAccessType: DWORD;
    pwszProxyName, pwszProxyBypass: LPCWSTR; dwFlags: DWORD): HINTERNET; stdcall;
    external 'winhttp.dll' name 'WinHttpOpen';
  {$EXTERNALSYM WinHttpOpen}
  function WinHttpConnect(hSession: HINTERNET; pswzServerName: LPCWSTR;
    nServerPort: INTERNET_PORT; dwReserved: DWORD): HINTERNET; stdcall;
    external 'winhttp.dll' name 'WinHttpConnect';
  {$EXTERNALSYM WinHttpConnect}
  function WinHttpOpenRequest(hConnect: HINTERNET; pwszVerb: LPCWSTR;
    pwszObjectName: LPCWSTR; pwszVersion: LPCWSTR; pwszReferer: LPCWSTR;
    ppwszAcceptTypes: PLPWSTR; dwFlags: DWORD): HINTERNET; stdcall;
    external 'winhttp.dll' name 'WinHttpOpenRequest';
  {$EXTERNALSYM WinHttpOpenRequest}
  function WinHttpQueryOption(hInet: HINTERNET; dwOption: DWORD;
    lpBuffer: Pointer; var lpdwBufferLength: DWORD): BOOL; stdcall;
    external 'winhttp.dll' name 'WinHttpQueryOption';
  {$EXTERNALSYM WinHttpQueryOption}
  function WinHttpGetProxyForUrl(hSession: HINTERNET; lpcwszUrl: LPCWSTR;
    pAutoProxyOptions: LPWINHTTP_AUTOPROXY_OPTIONS;
    var pProxyInfo: WINHTTP_PROXY_INFO): BOOL; stdcall;
    external 'winhttp.dll' name 'WinHttpGetProxyForUrl';
  {$EXTERNALSYM WinHttpGetProxyForUrl}
  function WinHttpGetIEProxyConfigForCurrentUser(
    var pProxyInfo: WINHTTP_CURRENT_USER_IE_PROXY_CONFIG): BOOL; stdcall;
    external 'winhttp.dll' name 'WinHttpGetIEProxyConfigForCurrentUser';
  {$EXTERNALSYM WinHttpGetIEProxyConfigForCurrentUser}
  function WinHttpCloseHandle(hInternet: HINTERNET): BOOL; stdcall;
    external 'winhttp.dll' name 'WinHttpCloseHandle';
  {$EXTERNALSYM WinHttpCloseHandle}

const
  WINHTTP_NO_REFERER = nil;
  {$EXTERNALSYM WINHTTP_NO_REFERER}
  WINHTTP_NO_PROXY_NAME = nil;
  {$EXTERNALSYM WINHTTP_NO_PROXY_NAME}
  WINHTTP_NO_PROXY_BYPASS = nil;
  {$EXTERNALSYM WINHTTP_NO_PROXY_BYPASS}
  WINHTTP_DEFAULT_ACCEPT_TYPES = nil;
  {$EXTERNALSYM WINHTTP_DEFAULT_ACCEPT_TYPES}
  WINHTTP_ACCESS_TYPE_DEFAULT_PROXY = 0;
  {$EXTERNALSYM WINHTTP_ACCESS_TYPE_DEFAULT_PROXY}
  WINHTTP_ACCESS_TYPE_NO_PROXY = 1;
  {$EXTERNALSYM WINHTTP_ACCESS_TYPE_NO_PROXY}
  WINHTTP_OPTION_PROXY = 38;
  {$EXTERNALSYM WINHTTP_OPTION_PROXY}
  WINHTTP_OPTION_PROXY_USERNAME = $1002;
  {$EXTERNALSYM WINHTTP_OPTION_PROXY_USERNAME}
  WINHTTP_OPTION_PROXY_PASSWORD = $1003;
  {$EXTERNALSYM WINHTTP_OPTION_PROXY_PASSWORD}
  WINHTTP_AUTOPROXY_AUTO_DETECT = $00000001;
  {$EXTERNALSYM WINHTTP_AUTOPROXY_AUTO_DETECT}
  WINHTTP_AUTOPROXY_CONFIG_URL = $00000002;
  {$EXTERNALSYM WINHTTP_AUTOPROXY_CONFIG_URL}
  WINHTTP_AUTO_DETECT_TYPE_DHCP = $00000001;
  {$EXTERNALSYM WINHTTP_AUTO_DETECT_TYPE_DHCP}
  WINHTTP_AUTO_DETECT_TYPE_DNS_A = $00000002;
  {$EXTERNALSYM WINHTTP_AUTO_DETECT_TYPE_DNS_A}
  WINHTTP_FLAG_BYPASS_PROXY_CACHE = $00000100;
  {$EXTERNALSYM WINHTTP_FLAG_BYPASS_PROXY_CACHE}
  WINHTTP_FLAG_REFRESH = WINHTTP_FLAG_BYPASS_PROXY_CACHE;
  {$EXTERNALSYM WINHTTP_FLAG_REFRESH}


  function FullDirectoryCopy(SourceDir, TargetDir: string; StopIfNotAllCopied,
    OverWriteFiles: Boolean): Boolean;
  function CheckAccessDir(Dir : string) : bool;
  function ExtractZip(ZipMaster: TZipMaster19; SourceF : string; Dest : string; UseP : string) : bool;
  function GetXMLDoc(var XMLDocument: TXMLDocument; FileName : String) : bool;
  function GetFile(var IdFTP: TIdFTP; const FileName : String; FileDest : string) : bool;
  function xCompressString(const InString: string; level: TCompressionLevel; StreamType : TZStreamType): string;
  function DecompressString(const InString: string): string;
  function GetUniqueCode(IDClient : string) : string;
  function StrToMD5Str(Str : String) : String;
  function Encrypt(var DestStream, Res: TMemoryStream) : Boolean;
  function Decrypt(var DecrStream, EncrRes : TMemoryStream) : Boolean;
  function FindFileInFolder(path, ext: string) : TStringList;
  function FillDocEx(var AdvOutlookList: TAdvOutlookList; var ArrOutlookList : TOtGr) : bool;
  function Explode(var input:string; c:char):exparr;
  function InAraay(input : string; var a : exparr) : BOOL;
  procedure GetProxyData(var ProxyEnabled: boolean; var ProxyServer: string; var ProxyPort: integer);
  function GetTovarData(var VST : TVirtualStringTree; StrCode : string) : PTreeData;

  function GetProxyInfo(const AURL: WideString; var AProxyInfo: TProxyInfo): DWORD;
  function OSVersion: string;
  function GetSystemInfo: String;
  function ProcessorName: string;

implementation

function GetProxyInfo(const AURL: WideString; var AProxyInfo: TProxyInfo): DWORD;
var
  Session: HINTERNET;
  AutoDetectProxy: Boolean;
  WinHttpProxyInfo: TWinHTTPProxyInfo;
  AutoProxyOptions: TWinHTTPAutoProxyOptions;
  IEProxyConfig: TWinHTTPCurrentUserIEProxyConfig;
begin
  // initialize the result
  Result := 0;
  // initialize auto-detection to off
  AutoDetectProxy := False;
  // initialize the result structure
  AProxyInfo.ProxyURL := '';
  AProxyInfo.ProxyBypass := '';
  AProxyInfo.ProxyAutoDetected := False;
  // initialize the auto-proxy options
  FillChar(AutoProxyOptions, SizeOf(AutoProxyOptions), 0);

  // check if the Internet Explorer's proxy configuration is
  // available and if so, check its settings for auto-detect
  // proxy settings and auto-config script URL options
  if WinHttpGetIEProxyConfigForCurrentUser(IEProxyConfig) then
  begin
    // if the Internet Explorer is configured to auto-detect
    // proxy settings then we try to detect them later on
    if IEProxyConfig.fAutoDetect then
    begin
      AutoProxyOptions.dwFlags := WINHTTP_AUTOPROXY_AUTO_DETECT;
      AutoProxyOptions.dwAutoDetectFlags := WINHTTP_AUTO_DETECT_TYPE_DHCP or
        WINHTTP_AUTO_DETECT_TYPE_DNS_A;
      AutoDetectProxy := True;
    end;
    // if the Internet Explorer is configured to use the proxy
    // auto-config script then we try to use it
    if IEProxyConfig.lpszAutoConfigURL <> '' then
    begin
      AutoProxyOptions.dwFlags := AutoProxyOptions.dwFlags or
        WINHTTP_AUTOPROXY_CONFIG_URL;
      AutoProxyOptions.lpszAutoConfigUrl := IEProxyConfig.lpszAutoConfigUrl;
      AutoDetectProxy := True;
    end;
    // if IE don't have auto-detect or auto-config set, we are
    // done here and we can fill the AProxyInfo with the IE settings
    if not AutoDetectProxy then
    begin
      AProxyInfo.ProxyURL := IEProxyConfig.lpszProxy;
      AProxyInfo.ProxyBypass := IEProxyConfig.lpszProxyBypass;
      AProxyInfo.ProxyAutoDetected := False;
    end;
  end
  else
  begin
    // if the Internet Explorer's proxy configuration is not
    // available, then try to auto-detect it
    AutoProxyOptions.dwFlags := WINHTTP_AUTOPROXY_AUTO_DETECT;
    AutoProxyOptions.dwAutoDetectFlags := WINHTTP_AUTO_DETECT_TYPE_DHCP or
      WINHTTP_AUTO_DETECT_TYPE_DNS_A;
    AutoDetectProxy := True;
  end;

  // if the IE proxy settings are not available or IE has
  // configured auto-config script or auto-detect proxy settings
  if AutoDetectProxy then
  begin
    // create a temporary WinHttp session to allow the WinHTTP
    // auto-detect proxy settings if possible
    Session := WinHttpOpen(nil, WINHTTP_ACCESS_TYPE_DEFAULT_PROXY,
      WINHTTP_NO_PROXY_NAME, WINHTTP_NO_PROXY_BYPASS, 0);

    // if the WinHttp session has been created then try to
    // get the proxy data for the specified URL else we assign
    // the last error code to the function result
    if Assigned(Session) then
    try
      // get the proxy data for the specified URL with the
      // auto-proxy options specified, if succeed then we can
      // fill the AProxyInfo with the retrieved settings else
      // we assign the last error code to the function result
      if WinHttpGetProxyForUrl(Session, LPCWSTR(AURL),
        @AutoProxyOptions, WinHttpProxyInfo) then
      begin
        AProxyInfo.ProxyURL := WinHttpProxyInfo.lpszProxy;
        AProxyInfo.ProxyBypass := WinHttpProxyInfo.lpszProxyBypass;
        AProxyInfo.ProxyAutoDetected := True;
      end
      else
        Result := GetLastError;
    finally
      WinHttpCloseHandle(Session);
    end
    else
      Result := GetLastError;
  end;
end;


procedure GetProxyData(var ProxyEnabled: boolean; var ProxyServer: string; var ProxyPort: integer);
var
  ProxyInfo: PInternetProxyInfo;
  Len: LongWord;
  i, j: integer;
begin
  Len := 4096;
  ProxyEnabled := false;
  GetMem(ProxyInfo, Len);
  try
    if InternetQueryOption(nil, INTERNET_OPTION_PROXY, ProxyInfo, Len)
    then
      if ProxyInfo^.dwAccessType = INTERNET_OPEN_TYPE_PROXY then
      begin
        ProxyEnabled:= True;
        ProxyServer := ProxyInfo^.lpszProxy;
        //ShowMessage(ProxyInfo^.lpszProxyBypass);
        //ShowMessage(UIntToStr(ProxyInfo^.dwAccessType));
      end
  finally
    FreeMem(ProxyInfo);
  end;

  if ProxyEnabled and (ProxyServer <> '') then
  begin
    i := Pos('ftp=', ProxyServer);
    if (i > 0) then
    begin
      Delete(ProxyServer, 1, i + 3);
      j := Pos(';', ProxyServer);
      if (j > 0) then
        ProxyServer := Copy(ProxyServer, 1, j - 1);
    end;
    i := Pos(':', ProxyServer);
    if (i > 0) then
    begin
      ProxyPort := StrToIntDef(Copy(ProxyServer, i + 1, Length(ProxyServer) - i), 0);
      ProxyServer := Copy(ProxyServer, 1, i - 1)
    end
  end;
end;


function InAraay(input : string; var a : exparr) : BOOL;
var
  fnd : Bool;
  i   : Integer;
begin
  fnd:=False;

  for i := 0 to Length(a) - 1 do
    begin
      if Pos(LowerCase(input, loUserLocale), LowerCase(a[i], loUserLocale)) > 0 then fnd:=True;
    end;

  Result:=fnd;
end;


function Explode(var input : string; c : char):exparr;
var
  i, g      : integer;
  a         : exparr;
begin
  i:=0;

  while pos(c, input) <> 0 do
    begin
      g:= pos(c, input);

      SetLength(a, i + 1);
      a[i]:= copy(input, 1, g-1);

      delete(input, 1, g);
      inc(i);
    end;

  SetLength(a, i + 1);

  a[i]:= input;
  explode:= a;
end;

function FillDocEx(var AdvOutlookList: TAdvOutlookList; var ArrOutlookList : TOtGr) : bool;
var
  i, k            : Integer;
  olg             : TOutlookGroup;
  sl              : TStrings;
begin
  Result:=False;

  AdvOutlookList.BeginUpdate;
  try
    AdvOutlookList.ClearGroups;

    for i := 0 to Length(ArrOutlookList) - 1 do
      begin
        olg:=AdvOutlookList.AddGroup(ArrOutlookList[i].Caption);

        if ArrOutlookList[i].Items <> nil then
            begin
              for k := 0 to Length(ArrOutlookList[i].Items) - 1 do
                begin
                  sl:=AdvOutlookList.AddItem(olg);
                  sl.Assign(ArrOutlookList[i].Items[k]);
                end;
            end;
      end;

      AdvOutlookList.CollapseAll;
  finally
    AdvOutlookList.EndUpdate;
  end;

    Result:=True;
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

function FullDirectoryCopy(SourceDir, TargetDir: string; StopIfNotAllCopied,
  OverWriteFiles: Boolean): Boolean;
var
  SR    : TSearchRec;
  I     : Integer;
begin
  Result := False;

  SourceDir := IncludeTrailingBackslash(SourceDir);
  TargetDir := IncludeTrailingBackslash(TargetDir);

  if not DirectoryExists(SourceDir) then
      Exit;
  if not ForceDirectories(TargetDir) then
      Exit;

  I := FindFirst(SourceDir + '*', faAnyFile, SR);
  try
    while I = 0 do
      begin
        if (SR.Name <> '') and (SR.Name <> '.') and (SR.Name <> '..') then
        begin
          if SR.Attr = faDirectory then
            Result := FullDirectoryCopy(SourceDir + SR.Name, TargetDir + SR.NAME,
              StopIfNotAllCopied, OverWriteFiles)
          else
            if not (not OverWriteFiles and FileExists(TargetDir + SR.Name)) then
              Result := CopyFile(Pchar(SourceDir + SR.Name), Pchar(TargetDir +
              SR.Name), False)
            else
            Result := True;
          if not Result and StopIfNotAllCopied then
              exit;
        end;
        I := FindNext(SR);
      end;
  finally
    SysUtils.FindClose(SR);
  end;
end;

function CheckAccessDir(Dir : string) : bool;
begin
  if not DirectoryExists(Dir) then
      begin
        try
          TDirectory.CreateDirectory(Dir);
          Result:=True;
        except on E : Exception do
          begin
            MessageDlg('Невозможно создать директорию: ' + Dir + ' ' + E.Message, mtError, [mbOK], 0);
            Result:=False;
          end;
        end;
      end
    else
      begin
        Result:=True;
      end;
end;

function ExtractZip(ZipMaster: TZipMaster19; SourceF : string; Dest : string; UseP : string) : bool;
begin
  if not FileExists(SourceF) then
  begin
    MessageDlg('Файл отсутствует: ' + SourceF, mtError, [mbOK], 0);
    Result:=false;
    Exit;
  end
    else
      begin
        ZipMaster.ZipFilename:= SourceF;
      end;

  if not DirectoryExists(Dest) then
  begin
    MessageDlg('Директория не существует: ' + Dest, mtError, [mbOK], 0);
    Result:=false;
    Exit;
  end;

  with ZipMaster do
    begin
      ExtrBaseDir := Dest;
      ExtrOptions := ExtrOptions + [ExtrDirNames];
      ExtrOptions := ExtrOptions + [ExtrOverwrite];

      Password:= UseP;

      try
        if Extract = 0 then
            Result:=True
          else
            Result:=False;
      except on E : Exception do
        begin
          MessageDlg('Ошибка при извлечении; Неустранимая ошибка DLL в основном блоке ' + E.Message, mtError, [mbOK], 0);
          Result:=false;
        end;
      end;
    end;
end;

function GetXMLDoc(var XMLDocument: TXMLDocument; FileName : String) : bool;
begin
  try
    XMLDocument:=TXMLDocument.Create(Application);
    XMLDocument.Active := true;
    XMLDocument.LoadFromFile(FileName);

    Result:=True;
  except on E: Exception do
    begin
      MessageDlg('Ошибка загрузки файла: ' + FileName + ' ' + E.Message, mtError, [mbOK], 0);
      Result:=False;
    end;
  end;
end;

function GetFile(var IdFTP: TIdFTP; const FileName : String; FileDest : string) : bool;
begin
  try
    idFTP.Get(FileName, FileDest, True, False);
    Result:=True;
  except on E : Exception do
    begin
      Result:=False;
    end;
  end;
end;

function StreamToHex(Buf: TStream): string;
const
  Convert: array[0..15] of Char = '0123456789ABCDEF';
var
  i, p: integer;
  B: byte;
begin
  SetLength(Result, Buf.Size * 2);
  p := Buf.Position;
  Buf.Position := 0;
  for i := 1 to Buf.Size do
  begin
    Buf.Read(B, 1);
    Result[(i * 2) - 1] := Convert[B shr $4];
    Result[(i * 2)] := Convert[B and $F];
  end;
  Buf.Position := p;
end;

procedure HexToStream(Hex: string; Buf: TStream);
const
  Convert: array['0'..'f'] of SmallInt =
  (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1,
    -1, 10, 11, 12, 13, 14, 15);
var
  i, p: integer;
  B: Byte;
begin
  if Buf.Size < Length(Hex) div 2 then
    Buf.Size := Length(Hex) div 2;
  p := Buf.Position;
  Buf.Position := 0;
  i := 1;
  while i <= Length(Hex) do
  begin
    if not (Hex[i] in ['0'..'f'])
      or not (Hex[i + 1] in ['0'..'f']) then
      Break;
    B := Byte((Convert[Hex[i]] shl 4) + Convert[Hex[i + 1]]);
    Buf.Write(B, 1);
    Inc(i, 2);
  end;
  Buf.Position := p;
end;

function xCompressString(const InString: string; level: TCompressionLevel; StreamType : TZStreamType): string;
var
  S, D : TStringStream;
begin
  S := TStringStream.Create(InString);
  try
    D := TStringStream.Create('');
    try
      CompressStream(S, D, level, StreamType);
      Result := StreamToHex(D);
    finally
      D.Free;
    end;
  finally
    S.Free;
  end;
end;

function DecompressString(const InString: string): string;
var
  S, D : TStringStream;
begin
  S := TStringStream.Create(InString);
  HexToStream(InString, S);
  try
    D := TStringStream.Create('');
    try
      DecompressStream(S, D);
      Result := D.DataString;
    finally
      D.Free;
    end;
  finally
    S.Free;
  end;
end;

function GetUniqueCode(IDClient : string) : string;
var
  md5indy     : TIdHashMessageDigest;
  Base        : string;
  MyTimeDate  : string;
begin
  DateTimeToString(MyTimeDate, 'hh:mm:ss.zzz - dddd d mmmm yyyy', Now);

  Base:=IDClient + MyTimeDate;
  md5indy:=TIdHashMessageDigest5.Create;
  Result:=md5indy.HashStringAsHex(Base);
end;

function OSVersion: string;
var
  Reg: TRegistry;
  bNotNt: Boolean;
  s: string;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  Result := '[Unknown]';

  bNotNt := (Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True)) and
            (Reg.ReadString('Version') <> '')                                 and
            (Reg.ReadString('VersionNumber') <> '');

  if not bNotNt then
    begin
      Reg.OpenKeyReadOnly('\Software\Microsoft\Windows NT\CurrentVersion');
      Result := Reg.ReadString('ProductName');
      s := Reg.ReadString('CSDVersion');
      if s<>'' then Result := Result + '  -  ' + s;
    end
  else
    begin
      Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion', True);
      Result := Reg.ReadString('ProductName');
      s := Reg.ReadString('CSDVersion');
      if s<>'' then Result := Result + '  -  ' + s;
    end; // if
  Reg.Free;
end; // OSVersion

function GetSystemInfo: String;
var Reg: TRegistry;
begin
  Reg:=TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;
  Reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion', false);
  Result:= reg.ReadString('CurrentVersion') +
  ' ' + reg.ReadString('CurrentBuild');
  Reg.free;
end;

function ProcessorName: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  Reg.RootKey := HKEY_LOCAL_MACHINE;

  Result := '<Unknown>';

  if Reg.OpenKeyReadOnly('\HARDWARE\DESCRIPTION\System\CentralProcessor\0') then
  begin
    Result := Trim(Reg.ReadString('ProcessorNameString'));
  end; // if
  Reg.Free;
end; // ProcessorName

function GetTovarData(var VST : TVirtualStringTree; StrCode : string) : PTreeData;
var
  Data    : PTreeData;

  XNode   : PVirtualNode;
begin
  //Data := PTreeData;

  if VST.GetFirst = nil then Result:=Data;

  XNode:=nil;
  repeat
    if XNode = nil then XNode:=VST.GetFirst else XNode:=VST.GetNext(XNode);
    Data:=VST.GetNodeData(XNode);
    if (Data^.Code = StrCode) then
        begin
          Result:=Data;
          exit;
        end;
  until XNode = VST.GetLast();

  Result:=Data;
end;

end.
