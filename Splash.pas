unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, RzForms, pngimage, ComCtrls;

type
  TSplashForm = class(TForm)
    RzFormShape1: TRzFormShape;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplashForm: TSplashForm;

implementation

uses Main;

{$R *.dfm}

procedure TSplashForm.FormCreate(Sender: TObject);
var
  SplashFile : string;
begin
  SplashFile:=ExtractFilePath(Application.ExeName) + 'Data\Splash.png';

  if FileExists(SplashFile) then
      begin
        try
          RzFormShape1.Picture.LoadFromFile(SplashFile);
        except
          ProgressBar1.Position:= 100;
        end;
      end
    else
      ProgressBar1.Position:= 100;
end;

procedure TSplashForm.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position = 100 then  Close;
  ProgressBar1.Position:=ProgressBar1.Position + 5;


end;

end.
