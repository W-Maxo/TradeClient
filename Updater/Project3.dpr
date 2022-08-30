program Project3;

uses
  Windows, SysUtils, ShellAPI{, Dialogs};

{$R *.res}
{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED}

function IsRun(id : String) : Boolean;
var
  Mutex  : integer;
begin
  Result := False;
  Mutex := CreateMutex(nil , True, PChar(id));
  if GetLastError <> 0 then
  begin
    CloseHandle(Mutex);
    Result := True;
  end;
end;

procedure StartProcess(FileName : string);
var
  ShellInfo: TShellExecuteInfo;
begin
  FillChar( ShellInfo, SizeOf( TShellExecuteInfo ), 0 );
  ShellInfo.cbSize := SizeOf( TShellExecuteInfo );
  ShellInfo.fMask := SEE_MASK_NOCLOSEPROCESS or SEE_MASK_FLAG_NO_UI or SEE_MASK_FLAG_DDEWAIT;
  ShellInfo.Wnd := HWnd_Desktop;
  ShellInfo.lpVerb := PChar('Open');
  ShellInfo.lpFile := PChar(FileName);
  ShellInfo.lpParameters := PChar('');
  ShellInfo.lpDirectory := PChar(ExtractFileDir(ParamStr(0)) + '\');
  ShellInfo.nShow := SW_NORMAL;

  if ShellExecuteEx( @ShellInfo ) then
  begin

  end;
end;

var
  Sr          : string;
  Ds          : string;

begin
  while IsRun('{7341DC8D-0BDE-4D23-BE75-DEC4ABF8A7E8}') do
    begin
      Sleep(250);
    end;

    Sr:=ExtractFileDir(ParamStr(0)) + '\Temp\' + ExtractFileName(ParamStr(1));
    Ds:=ExtractFileDir(ParamStr(0)) + '\' + ExtractFileName(ParamStr(1));

    //Sr:=ExtractFileDir(ParamStr(0)) + '\Temp\' + 'TradeClient.exe';
    //Ds:=ExtractFileDir(ParamStr(0)) + '\'+'TradeClient.exe';

    //ShowMessage(ParamStr(1));
    //ShowMessage(DS);

    if FileExists(Sr) then
        begin
          if FileExists(Ds + '.old') then DeleteFile(Ds + '.old');

          if FileExists(Ds) then RenameFile(Ds, Ds + '.old');

          CopyFile(PChar(Sr), PChar(Ds), False);

          StartProcess(Ds);
        end;
end.
