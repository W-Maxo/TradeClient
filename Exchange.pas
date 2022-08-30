unit Exchange;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdCustomTransparentProxy, IdConnectThroughHttpProxy, IdIOHandlerSocket,
  IdSocks, DateUtils, Registry, IdMultipartFormData, IdHTTP, IdCookieManager,
  EncdDecd, JwaWinCrypt, idURI, MyTypes, Utils, IdHashMessageDigest, idHash;

const
  PROV_RSA_AES = 24;
  ALG_SID_AES_128 = 14;
  CALG_AES_128 = ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK or ALG_SID_AES_128;

  xKey          = 'CFB3F031-A7D5-4295-908F-AD10E3A735FC';
  PageLink      = 'http://eurasia-lgc.by/Filer.php';
  DownloadLink  = 'http://eurasia-lgc.by/Filer.php?ref=';
  ansFileK      = '08d63777c29e6040a723a7433169ca02';
  zFileP        = '71d7c290c91fef27fd1fc8bdd80a8261';

function PreDownload(xKey, SettingsID, SettingsDir, SettingsCl : string;
                      var idHttp: TIdHTTP; var FileVersions : TFileVersions;
                      var AnsArr : exparr; ExeFileVer, ExeMD5 : string) : integer;
function DownloadFile(Url, FName : string; var idHttp: TIdHTTP): Boolean;
function SendReqToServer(xKey, SettingsID, SettingsDir, ToSendText : string; var idHttp: TIdHTTP) : integer;
function DownloadAnsFile(Url, FName : string; var idHttp: TIdHTTP; var stream : TMemoryStream): Boolean;
function DeleteAnsFile(Url, FName : string; var idHttp: TIdHTTP): Boolean;
function MD5File(const fileName : string) : string;

implementation

function ds_encrypt(input, key: AnsiString): AnsiString;
var
  hProv: HCRYPTPROV;
  hKey: HCRYPTKEY;
  keyBlob: record
    keyHeader: BLOBHEADER;
    keySize: DWORD;
    keyData: array[0..15] of Byte;
  end;
  keyLen: Integer;
  cryptMode, padMode, dataLen: DWORD;

  function AlignUp(dwValue, dwAlignment: DWORD): DWORD; register;
  asm
     dec edx
     add eax,edx
     not edx
     and eax,edx
  end;

begin
  if (Length(input) = 0) then
    raise Exception.Create('[INPUT] parameter not specified.');

  if (Length(key) = 0) then
    raise Exception.Create('[KEY] parameter not specified.');

  if not CryptAcquireContext(hProv, nil, nil, PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
    RaiseLastOSError();

  try
    FillChar(keyBlob, SizeOf(keyBlob), 0);
    with keyBlob do
      begin
        keyHeader.bType := PLAINTEXTKEYBLOB;
        keyHeader.bVersion := CUR_BLOB_VERSION;
        keyHeader.aiKeyAlg := CALG_AES_128;
        keySize := 16;

        if (Length(key) < 16) then
          keyLen := Length(key)
        else
          keyLen := 16;

        Move(key[1], keyData[0], keyLen);
      end;

    if not CryptImportKey(hProv, @keyBlob, SizeOf(keyBlob), 0, 0, hKey) then
      RaiseLastOSError();

    try
      cryptMode := CRYPT_MODE_CBC;
      if not CryptSetKeyParam(hKey, KP_MODE, @cryptMode, 0) then
        RaiseLastOSError();

      padMode := PKCS5_PADDING;
      if not CryptSetKeyParam(hKey, KP_PADDING, @padMode, 0) then
        RaiseLastOSError();

      Result := input;
      dataLen := Length(Result);
      SetLength(Result, AlignUp(Length(Result) + 1, 16));

      if not CryptEncrypt(hKey, 0, True, 0, @Result[1], dataLen, Length(Result)) then
        RaiseLastOSError();

    finally
      CryptDestroyKey(hKey);
    end;

  finally
    CryptReleaseContext(hProv, 0);
  end;
end;

function ds_decrypt(input, key: AnsiString): AnsiString;
var
  hProv: HCRYPTPROV;
  hKey: HCRYPTKEY;
  keyBlob: record
    keyHeader: BLOBHEADER;
    keySize: DWORD;
    keyData: array[0..15] of Byte;
  end;
  keyLen: Integer;
  cryptMode, padMode, dataLen: DWORD;
begin
  if (Length(input) = 0) then
    raise Exception.Create('[INPUT] parameter not specified.');

  if (Length(key) = 0) then
    raise Exception.Create('[KEY] parameter not specified.');

  if not CryptAcquireContext(hProv, nil, nil, PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
    RaiseLastOSError();

  try
    FillChar(keyBlob, SizeOf(keyBlob), 0);
    with keyBlob do
    begin
      keyHeader.bType := PLAINTEXTKEYBLOB;
      keyHeader.bVersion := CUR_BLOB_VERSION;
      keyHeader.aiKeyAlg := CALG_AES_128;
      keySize := 16;

      if (Length(key) < 16) then
        keyLen := Length(key)
      else
        keyLen := 16;

      Move(key[1], keyData[0], keyLen);
    end;

    if not CryptImportKey(hProv, @keyBlob, SizeOf(keyBlob), 0, 0, hKey) then
      RaiseLastOSError();

    try
      cryptMode := CRYPT_MODE_CBC;
      if not CryptSetKeyParam(hKey, KP_MODE, @cryptMode, 0) then
        RaiseLastOSError();

      padMode := PKCS5_PADDING;
      if not CryptSetKeyParam(hKey, KP_PADDING, @padMode, 0) then
        RaiseLastOSError();

      Result := input;
      dataLen := Length(Result);

      if not CryptDecrypt(hKey, 0, True, 0, @Result[1], dataLen) then
        RaiseLastOSError();

      SetLength(Result, dataLen);

    finally
      CryptDestroyKey(hKey);
    end;

  finally
    CryptReleaseContext(hProv, 0);
  end;
end;

function EncryptString(input, key: string): string;
var
  EncString, base64String : string;
begin
  EncString:=ds_encrypt(input, StrToMD5Str(key));

  base64String:=EncodeString(EncString);

  base64String := StringReplace(base64String, #10, '', [rfReplaceAll, rfIgnoreCase]);
  base64String := StringReplace(base64String, #13, '', [rfReplaceAll, rfIgnoreCase]);

  Result:=base64String;
end;

 function MD5File(const fileName : string) : string;
 var
   idmd5  : TIdHashMessageDigest5;
   fs     : TFileStream;
   hash   : T4x4LongWordRecord;
 begin
   idmd5 := TIdHashMessageDigest5.Create;
   fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite) ;
   try
     result := idmd5.HashBytesAsHex(idmd5.HashStream(fs)) ;
   finally
     fs.Free;
     idmd5.Free;
   end;
 end;

function PreDownload(xKey, SettingsID, SettingsDir, SettingsCl : string;
                      var idHttp: TIdHTTP; var FileVersions : TFileVersions;
                      var AnsArr : exparr; ExeFileVer, ExeMD5 : string) : integer;
var
   data         : TIdMultiPartFormDataStream;
   base64String, EncString, Dir : string;
   Input        : TStringStream;
   LItem        : TIdFormDataField;
   SK, ResText  : string;
   Response     : TStringStream;
   GetResponse  : TStringStream;
   ResArr       : exparr;
   i            : Integer;
   names        : string;
   temp         : string;
   fStream      : TMemoryStream;
   Sl           : TStringList;
   AnsFList     : string;
begin
  SK := StrToMD5Str(xKey);

  Response := TStringStream.Create;
  GetResponse := TStringStream.Create;

  data := TIdMultipartFormDataStream.Create;
   try
     data.AddFormField('TAData', utf8encode(EncryptString(SettingsID, SK)), 'UTF-8').ContentTransfer := '8bit';
     data.AddFormField('TACl', utf8encode(EncryptString(SettingsCl, SK)), 'UTF-8').ContentTransfer := '8bit';

     Dir:=SettingsDir;

     if Length(Dir) > 0 then
        begin
         if Dir[1] = '/' then Delete(Dir, 1, 1);
         if Dir[Length(Dir)] = '/' then Delete(Dir, Length(Dir), 1);

         data.AddFormField('TADir', utf8encode(EncryptString(Dir, SK)), 'UTF-8').ContentTransfer := '8bit';
        end;

     try
        Sl:=TStringList.Create;
        try
          Sl.Add('Client=' + SettingsCl);
          Sl.Add('TimeDate=' + FormatDateTime('yyyy.mm.dd hh:nn.ss', Now));
          Sl.Add('OSVersion=' + OSVersion);
          Sl.Add('SystemInfo=' + GetSystemInfo);
          Sl.Add('ProcessorName=' + ProcessorName);
          Sl.Add('ExeFileVer=' + ExeFileVer);
          Sl.Add('ExeMD5=' + ExeMD5);
          data.AddFormField('TInf', utf8encode(EncryptString(Sl.Text, SK)), 'UTF-8').ContentTransfer := '8bit';
        finally
          Sl.Free;
        end;
     finally
     end;

     ResText:='';

     idhttp.Post(TIdURI.URLEncode(PageLink), data, Response);

     if idhttp.ResponseCode = 200 then
     begin


        ResText := idHttp.Response.RawHeaders.GetText;;

        ResText := Response.DataString;

        if Copy(ResText, 0, 3) = 'NOK' then
          begin
            MessageDlg('Ваш ключ не прошел проверку. Обновление невозможно.', mtError, [mbOK], 0);
            Result:=0;
          end;

        if Copy(ResText, 0, 5) = 'RESOK' then
          begin
            ResArr:=Explode(ResText, '@');

            names := LowerCase(StrToMD5Str(xKey + 'TradeClient.exe'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  temp:= Copy(ResArr[i], 34, Length(ResArr[i]) - 33);
                  FileVersions.ExeFile:= Copy(temp, 0, Pos('=', temp) - 1);
                  FileVersions.ExeFileSize:= StrToInt64Def(Copy(temp, Pos('=', temp) + 1, Length(temp) - Pos('=', temp)), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Info.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.InfoFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.InfoFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Splash.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.SplashFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.SplashFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

//            names := LowerCase(StrToMD5Str(xKey + 'Tovars.zip'));
//            for i := 1 to Length(ResArr) - 1 do
//            begin
//               if names = Copy(ResArr[i], 0, 32) then
//               begin
//                  FileVersions.TvFile:= Copy(ResArr[i], 34, 14);
//                  FileVersions.TvFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
//                  Break;
//               end;
//            end;

             names := LowerCase(StrToMD5Str(xKey + 'SDP.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.SDP:= Copy(ResArr[i], 34, 14);
                  FileVersions.SDPFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Stock_rest.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.Rest:= Copy(ResArr[i], 34, 14);
                  FileVersions.RestFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Disc.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.Disc:= Copy(ResArr[i], 34, 14);
                  FileVersions.DiscFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Arrearage_Cr.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.ArrFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.ArrFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Clients_Cr.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.ClientsFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.ClientsFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Sales_Cr.zip'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.SalesFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.SalesFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            names := LowerCase(StrToMD5Str(xKey + 'Ts.xml'));
            for i := 1 to Length(ResArr) - 1 do
            begin
               if names = Copy(ResArr[i], 0, 32) then
               begin
                  FileVersions.TpSalesFile:= Copy(ResArr[i], 34, 14);
                  FileVersions.TpSalesFileSize:= StrToInt64Def(Copy(ResArr[i], 49, Length(ResArr[i]) - 48), 0);
                  Break;
               end;
            end;

            for i := 1 to Length(ResArr) - 1 do
            begin
               if ansFileK = Copy(ResArr[i], 0, 32) then
               begin
                  AnsFList:= Copy(ResArr[i], 34, Length(ResArr[i]) - 33);
                  if Length(AnsFList) > 0 then
                    begin
                      AnsArr:=Explode(AnsFList, '~');
                    end;
                  Break;
               end;
            end;
          end;
     end;
     Result:=1;
   finally
     data.Free;
     Response.Free;
     GetResponse.Free;
   end;
end;

function DownloadFile(Url, FName : string; var idHttp: TIdHTTP): Boolean;
var
  stream : TMemoryStream;
begin
  try
    stream := TMemoryStream.Create;
    idHttp.get(TIdURI.URLEncode(Url), stream);

    if (idHttp.ResponseCode = 200) and (idHttp.Response.ContentType = 'application/octet-stream') then
       begin
          stream.SaveToFile(FName);
          FreeAndNil(stream);

          Result:= True;
       end
    else
      begin
        FreeAndNil(stream);
        Result:= False;
      end;
  except
    FreeAndNil(stream);
    Result:= False;
  end;
end;

function DownloadAnsFile(Url, FName : string; var idHttp: TIdHTTP; var stream : TMemoryStream): Boolean;
begin
  try
    idHttp.get(TIdURI.URLEncode(Url + FName), stream);

    if (idHttp.ResponseCode = 200) and (idHttp.Response.ContentType = 'application/octet-stream') then
       begin
          stream.Position:=0;
          Result:= True;
       end
    else
      begin
        Result:= False;
      end;
  except
    Result:= False;
  end;
end;

function DeleteAnsFile(Url, FName : string; var idHttp: TIdHTTP): Boolean;
begin
  try
    idHttp.get(TIdURI.URLEncode(Url + FName + '&del=1'));

    if (idHttp.ResponseCode = 200) and (idHttp.Response.ContentType = 'application/octet-stream') then
       begin
          Result:= True;
       end
    else
      begin
        Result:= False;
      end;
  except
    Result:= False;
  end;
end;

function SendReqToServer(xKey, SettingsID, SettingsDir, ToSendText : string; var idHttp: TIdHTTP) : integer;
var
   data         : TIdMultiPartFormDataStream;
   base64String,  Dir : string;
   LItem        : TIdFormDataField;
   SK, ResText  : string;
   Response     : TStringStream;
   GetResponse  : TStringStream;
   ResArr       : exparr;
   i            : Integer;
   names        : string;
   temp         : string;
   fStream     : TMemoryStream;
   Sl          : TStringList;
begin
  SK := StrToMD5Str(xKey);

  Response := TStringStream.Create;
  GetResponse := TStringStream.Create;

  data := TIdMultipartFormDataStream.Create;
   try
     data.AddFormField('TAData', utf8encode(EncryptString(SettingsID, SK)), 'UTF-8').ContentTransfer := '8bit';

     Dir:=SettingsDir;

     if Length(Dir) > 0 then
        begin
         if Dir[1] = '/' then Delete(Dir, 1, 1);
         if Dir[Length(Dir)] = '/' then Delete(Dir, Length(Dir), 1);

         data.AddFormField('TADir', utf8encode(EncryptString(Dir, SK)), 'UTF-8').ContentTransfer := '8bit';
        end;

     ToSendText:=utf8encode(ToSendText);
     data.AddFormField('TAREQ', utf8encode(EncryptString(EncodeString(ToSendText), SK)), 'UTF-8').ContentTransfer := '8bit';

     ResText:='';

     idhttp.Post(TIdURI.URLEncode(PageLink), data, Response);

     if idhttp.ResponseCode = 200 then
     begin
        ResText := Response.DataString;

        //ShowMessage(ResText);

        if Copy(ResText, 0, 3) = 'NOK' then
          begin
            MessageDlg('Ваш ключ не прошел проверку. Невозможно отправить заказ.', mtError, [mbOK], 0);
            Result:=0;
          end;

        if Copy(ResText, 0, 6) = 'SENDOK' then
          begin
            Result:=1;
            Exit;
          end;
     end;
     Result:=0;
   finally
     data.Free;
     Response.Free;
     GetResponse.Free;
   end;
end;

end.
