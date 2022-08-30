unit Settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, RzPanel, StdCtrls, RzLabel, Mask, RzEdit,
  AdvGlowButton, RzButton, RzRadChk, RzStatus;

type
  TSettingsForm = class(TForm)
    AdvPanel1: TAdvPanel;
    RzGroupBox1: TRzGroupBox;
    AddressEdit: TRzEdit;
    PortEdit: TRzNumericEdit;
    RzGroupBox2: TRzGroupBox;
    IDUserEdit: TRzEdit;
    PasswordEdit: TRzMaskEdit;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    SrvPassEdit: TRzMaskEdit;
    SrvUserEdit: TRzEdit;
    RzStatusPane1: TRzStatusPane;
    RzStatusPane2: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzStatusPane4: TRzStatusPane;
    RzStatusPane5: TRzStatusPane;
    RzStatusPane6: TRzStatusPane;
    DirEdit: TRzEdit;
    RzStatusPane7: TRzStatusPane;
    PassiveCheckBox: TRzCheckBox;
    procedure FormShow(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure AddressEditChange(Sender: TObject);
    procedure SrvUserEditChange(Sender: TObject);
    procedure SrvPassEditChange(Sender: TObject);
    procedure IDUserEditChange(Sender: TObject);
    procedure PasswordEditChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

uses Main;

{$R *.dfm}

procedure TSettingsForm.AddressEditChange(Sender: TObject);
begin
  if AddressEdit.Text = '' then RzStatusPane1.Blinking:=True
      else
        RzStatusPane1.Blinking:=False;
end;

procedure TSettingsForm.AdvGlowButton1Click(Sender: TObject);
var
  fl : bool;
begin
  fl:=False;

  if AddressEdit.Text = '' then
    begin
      AddressEdit.OnChange(Sender);
      fl:=True;
    end;
  if SrvUserEdit.Text = '' then
    begin
      SrvUserEdit.OnChange(Sender);
      fl:=True;
    end;
  if SrvPassEdit.Text = '' then
      begin
        SrvPassEdit.OnChange(Sender);
        fl:=True;
      end;
  if IDUserEdit.Text = '' then
      begin
        IDUserEdit.OnChange(Sender);
        fl:=True;
      end;
  if PasswordEdit.Text = '' then
      begin
        PasswordEdit.OnChange(Sender);
        fl:=True;
      end;

  if not fl then
      ModalResult:=mrOK;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  AddressEdit.Text:=MainForm.IdFTP1.Host;
  PortEdit.Value:=MainForm.IdFTP1.Port;
  PassiveCheckBox.Checked:=MainForm.IdFTP1.Passive;

  SrvUserEdit.Text:=MainForm.IdFTP1.Username;
  SrvPassEdit.Text:=MainForm.IdFTP1.Password;

  DirEdit.Text:=MainForm.fDir;
end;

procedure TSettingsForm.IDUserEditChange(Sender: TObject);
begin
  if IDUserEdit.Text = '' then RzStatusPane5.Blinking:=True
      else
        RzStatusPane5.Blinking:=False;
end;

procedure TSettingsForm.PasswordEditChange(Sender: TObject);
begin
  if PasswordEdit.Text = '' then RzStatusPane6.Blinking:=True
      else
        RzStatusPane6.Blinking:=False;
end;

procedure TSettingsForm.SrvPassEditChange(Sender: TObject);
begin
  if SrvPassEdit.Text = '' then RzStatusPane4.Blinking:=True
      else
        RzStatusPane4.Blinking:=False;
end;

procedure TSettingsForm.SrvUserEditChange(Sender: TObject);
begin
  if SrvUserEdit.Text = '' then RzStatusPane3.Blinking:=True
      else
        RzStatusPane3.Blinking:=False;
end;

end.
