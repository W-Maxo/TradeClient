program TradeClient;

uses
  Forms,
  Windows,
  SysUtils,
  Dialogs,
  Messages,
  Main in 'Main.pas' {MainForm},
  Splash in 'Splash.pas' {SplashForm},
  AddUnit in 'AddUnit.pas' {AddForm},
  Settings in 'Settings.pas' {SettingsForm},
  Utils in 'Utils.pas',
  LoadDoc in 'LoadDoc.pas',
  MyTypes in 'MyTypes.pas',
  About in 'About.pas' {AboutForm},
  RequisitionClass in 'RequisitionClass.pas',
  Clients in 'Clients.pas',
  Update in 'Update.pas' {UpdateForm},
  MyConst in 'MyConst.pas',
  WaitUnit in 'WaitUnit.pas' {Form1},
  WaitL in 'WaitL.pas' {WaitForm},
  Exchange in 'Exchange.pas';

{$R *.res}

{$SETPEFLAGS IMAGE_FILE_RELOCS_STRIPPED}

var
  xTargetWnd  : THandle;

function EnumWindowsProc(h: HWND; lParam: LPARAM): BOOL; stdcall;
var
  CN  : array [0..1023] of Char;
  CNC : array [0..1023] of Char;
begin
  if IsWindowVisible(h) then
    begin
      GetWindowText(h, @CN, 1024);
      GetClassName(h, @CNC, 1024);

      if (AnsiStrPos(CN, 'Mannol Trade') <> '') and (AnsiStrPos(CNC, 'TMainForm') <> '') then
          begin
            xTargetWnd:=h;
          end;
    end;

  Result := True;
end;

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

begin
  if IsRun('{7341DC8D-0BDE-4D23-BE75-DEC4ABF8A7E8}') then
      begin
        Windows.EnumWindows(@EnumWindowsProc, 0);

        if xTargetWnd <> 0 then
            begin
              ShowWindow(xTargetWnd, SW_RESTORE);
              SetForegroundWindow(xTargetWnd);
            end;

        Halt(0);
      end;

  FormatSettings.DecimalSeparator:=',';

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Mannol Trade';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddForm, AddForm);
  Application.CreateForm(TUpdateForm, UpdateForm);
  Application.CreateForm(TWaitForm, WaitForm);
  Application.Run;
end.
