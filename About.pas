unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvGlowButton, RzPanel, ExtCtrls, AdvPanel, RzStatus,
  AdvReflectionImage, RzLabel, StdCtrls, RzLine, AdvReflectionLabel{,
  JclSysInfo, JclWin32};

type
  TAboutForm = class(TForm)
    AdvPanel1: TAdvPanel;
    AdvGlowButton1: TAdvGlowButton;
    RzGroupBox1: TRzGroupBox;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    AdvReflectionLabel1: TAdvReflectionLabel;
    RzGroupBox2: TRzGroupBox;
    RzURLLabel1: TRzURLLabel;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane5: TRzStatusPane;
    rzstspn1: TRzStatusPane;
    lbl1: TRzURLLabel;
    rzstspn2: TRzStatusPane;
    rzstspn3: TRzStatusPane;
    rzstspn4: TRzStatusPane;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

uses Main;

{$R *.dfm}

function xGetFileVersion(FileName : String) : String;
var
  Data : Pointer;
  DataSize, InfoSize : Dword;
  Dummy : Cardinal;
  Major1, Major2, Minor1, Minor2 : Integer;
  FileInfo : PVSFixedFileInfo;
begin
  DataSize := GetFileVersionInfoSize(PChar(FileName + #0), Dummy);
  if DataSize > 0 then
  begin
    GetMem(Data, DataSize);
    GetFileVersionInfo(PChar(FileName + #0), 0, DataSize, Data);
    VerQueryValue(Data, '\', Pointer(FileInfo), InfoSize);
    Major1 := FileInfo.dwFileVersionMS shr 16;
    Major2 := FileInfo.dwFileVersionMS and $FFFF;
    Minor1 := FileInfo.dwFileVersionLS shr 16;
    Minor2 := FileInfo.dwFileVersionLS and $FFFF;
    Result := IntToStr(Major1) + '.' + IntToStr(Major2) + '.' + IntToStr(Minor1) + ' build ' + IntToStr(Minor2);
    FreeMem(Data, DataSize);
  end;
end;

function GetBuildTime: TDateTime;
type
 UShort = Word;
 TImageDosHeader = packed record
    e_magic: UShort;                            // магическое число
    e_cblp: UShort;                             // количество байт на последней странице файла
    e_cp: UShort;                               // количество страниц вфайле
    e_crlc: UShort;                             // Relocations
    e_cparhdr: UShort;                          // размер заголовка в параграфах
    e_minalloc: UShort;                         // Minimum extra paragraphsneeded
    e_maxalloc: UShort;                         // Maximum extra paragraphsneeded
    e_ss: UShort;                               // начальное( относительное ) значение регистра SS
    e_sp: UShort;                               // начальное значениерегистра SP
    e_csum: UShort;                             // контрольная сумма
    e_ip: UShort;                               // начальное значение регистра IP
    e_cs: UShort;                               // начальное( относительное ) значение регистра CS
    e_lfarlc: UShort;                           // адрес в файле на таблицу переадресации
    e_ovno: UShort;                             // количество оверлеев
    e_res: array[0..3] of UShort;               // Зарезервировано
    e_oemid: UShort;                            // OEM identifier (for e_oeminfo)
    e_oeminfo: UShort;                          // OEM information; e_oemid specific
    e_res2: array [0..9] of UShort;             // Зарезервировано
    e_lfanew: LongInt;                          // адрес в файле нового .exeзаголовка
  end;

 TImageResourceDirectory = packed record
    Characteristics: DWord;
    TimeDateStamp: DWord;
    MajorVersion: Word;
    MinorVersion: Word;
    NumberOfNamedEntries: Word;
    NumberOfIdEntries: Word;
//  IMAGE_RESOURCE_DIRECTORY_ENTRY DirectoryEntries[];
  end;
  PImageResourceDirectory = ^TImageResourceDirectory;

var
  hExeFile: HFile;
  ImageDosHeader: TImageDosHeader;
  Signature: Cardinal;
  ImageFileHeader: TImageFileHeader;
  ImageOptionalHeader: TImageOptionalHeader;
  ImageSectionHeader: TImageSectionHeader;
  ImageResourceDirectory: TImageResourceDirectory;
  Temp: Cardinal;
  i: Integer;
begin
  hExeFile:=CreateFile(PChar(ParamStr(0)), GENERIC_READ, FILE_SHARE_READ,nil, OPEN_EXISTING, 0, 0);
  try
    ReadFile(hExeFile, ImageDosHeader, SizeOf(ImageDosHeader), Temp, nil);
    SetFilePointer(hExeFile, ImageDosHeader.e_lfanew, nil, FILE_BEGIN);
    ReadFile(hExeFile, Signature, SizeOf(Signature), Temp, nil);
    ReadFile(hExeFile, ImageFileHeader, SizeOf(ImageFileHeader), Temp, nil);
    ReadFile(hExeFile, ImageOptionalHeader, SizeOf(ImageOptionalHeader), Temp, nil);
    for i:=0 to ImageFileHeader.NumberOfSections-1 do
    begin
      ReadFile(hExeFile, ImageSectionHeader, SizeOf(ImageSectionHeader), Temp, nil);
      if StrComp(@ImageSectionHeader.Name, '.rsrc')=0 then Break;
    end;
    SetFilePointer(hExeFile, ImageSectionHeader.PointerToRawData, nil, FILE_BEGIN);
    ReadFile(hExeFile, ImageResourceDirectory, SizeOf(ImageResourceDirectory), Temp, nil);
  finally
    FileClose(hExeFile);
  end;

  Result:=FileDateToDateTime(ImageResourceDirectory.TimeDateStamp);
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  RzStatusPane1.Caption   :=xGetFileVersion(Application.ExeName);
  RzStatusPane2.Caption   :=FormatDateTime('dddddd tt', GetBuildTime);

  RzStatusPane3.Caption   :=MainForm.Settings.CName;
  RzUrlLabel1.Caption     :='mailto:' + MainForm.Settings.Email;

  RzStatusPane4.Caption   :=MainForm.Settings.Address;
  RzStatusPane5.Caption   :='Тел. ' + MainForm.Settings.Tel;
  rzstspn1.Caption        :='Факс. ' + MainForm.Settings.Fax;
  lbl1.Caption            :=MainForm.Settings.URL;

  rzstspn3.Caption        :=MainForm.MainRequests.ClList.ManagerName;
  rzstspn4.Caption        :=MainForm.MainRequests.ClList.ManagerTel;
end;

procedure TAboutForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = 13 then
      Close;
  if Msg.CharCode = 27 then
      Close;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  AdvReflectionLabel1.ReflectionSize:=101;
end;

end.
