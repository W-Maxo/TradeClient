unit Update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, ComCtrls, RzListVw, AdvGlowButton;

type
  TUpdateForm = class(TForm)
    AdvPanel1: TAdvPanel;
    RzListView1: TRzListView;
    AdvGlowButton2: TAdvGlowButton;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure AdvGlowButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UpdateForm: TUpdateForm;

implementation

uses Main;

{$R *.dfm}

procedure TUpdateForm.AdvGlowButton2Click(Sender: TObject);
begin
  Hide;
  Close;
end;

procedure TUpdateForm.Timer1Timer(Sender: TObject);
begin
  Hide;
  Close;

  if not UpdateForm.Visible then Timer1.Enabled:=False;
end;

end.
