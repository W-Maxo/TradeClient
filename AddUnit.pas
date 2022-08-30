unit AddUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, AdvPanel, RzPanel, StdCtrls, Mask, RzEdit, RzSpnEdt,
  RzLabel, RzStatus, AdvGlowButton;

type
  TAddForm = class(TForm)
    AdvPanel1: TAdvPanel;
    RzGroupBox1: TRzGroupBox;
    RzSpinEdit1: TRzSpinEdit;
    RzLabel1: TRzLabel;
    RzStatusPane1: TRzStatusPane;
    RzMemo1: TRzMemo;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    RzMemo2: TRzMemo;
    RzLabel2: TRzLabel;
    RzStatusPane2: TRzStatusPane;
    rzstspn1: TRzStatusPane;
    procedure RzSpinEdit1Change(Sender: TObject);
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure RzSpinEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    Cost    : double;
    Code    : integer;

    Cost1   : Double;
    Cost2   : Double;

    MinR    : Integer;

    Add     : BOOL;
  end;

var
  AddForm: TAddForm;

implementation

uses Main;

{$R *.dfm}

procedure TAddForm.AdvGlowButton1Click(Sender: TObject);
begin
  if RzSpinEdit1.Text = '' then Exit;
  if RzSpinEdit1.Value < 0 then  Exit;

  if Add then
      begin
        if RzSpinEdit1.Value = 0 then  Exit;
        if (RzSpinEdit1.IntValue mod MinR) > 0 then
            begin
              while (RzSpinEdit1.IntValue mod MinR) > 0 do RzSpinEdit1.IntValue := RzSpinEdit1.IntValue + 1;
              Exit;
            end;

        MainForm.MainRequests.AddTovarInSelReq(Code, RzSpinEdit1.IntValue, Cost1, Cost2, RzMemo2.Text);
      end
    else
      begin
         if RzSpinEdit1.IntValue > 0 then
              begin
                if (RzSpinEdit1.IntValue mod MinR) > 0 then
                    begin
                      while (RzSpinEdit1.IntValue mod MinR) > 0 do RzSpinEdit1.IntValue := RzSpinEdit1.IntValue + 1;
                      Exit;
                    end;

                MainForm.MainRequests.CheckAndEditTv(RzSpinEdit1.IntValue);
              end
            else
              MainForm.MainRequests.CheckAndDeleteTv;
      end;

  //MainForm.edtSearchChange(Sender);

  ModalResult:=mrOk;
end;

procedure TAddForm.FormShortCut(var Msg: TWMKey; var Handled: Boolean);
begin
  if Msg.CharCode = 13 then
      AdvGlowButton1.Click;
  if Msg.CharCode = 27 then
      AdvGlowButton2.Click;;
end;

procedure TAddForm.FormShow(Sender: TObject);
begin
  RzSpinEdit1.Increment:=MinR;
  RzSpinEdit1.Min:=MinR;

  if MinR > 1 then  rzstspn1.Caption:= 'Минимальное кол-во для заказа: ' + IntToStr(MinR)
      else
        rzstspn1.Caption:= '';

  if Add then
      begin
        RzSpinEdit1.Min:=MinR;
        RzSpinEdit1.Value:=MinR;
        Caption := 'Добавить в заказ';
      end
    else
      begin
        RzSpinEdit1.Min:=0;
        Caption := 'Изменение количества';
      end;

  RzSpinEdit1.SelectAll;
end;

procedure TAddForm.RzSpinEdit1Change(Sender: TObject);
begin
  if (Length(RzSpinEdit1.Text) > 0) and not Add then
      begin
        if RzSpinEdit1.Text[1] = '0' then RzSpinEdit1.Text:=IntToStr(RzSpinEdit1.IntValue);

        //if (RzSpinEdit1.IntValue = 0) and (Key = '0') then Key := #0;

        RzSpinEdit1.SelStart:=Length(RzSpinEdit1.Text);
      end;

  if MainForm.Cash = 0 then
      begin
        FormatSettings.CurrencyString := ' Бел. руб.';
        Cost:=Cost1;
      end
    else
      begin
        FormatSettings.CurrencyString := ' USD';
        Cost:=Cost2;
      end;

  RzStatusPane1.Caption:='Сумма: ' + FloatToStrF(RzSpinEdit1.Value * Cost, ffCurrency, 10, 2);
end;

procedure TAddForm.RzSpinEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key <> #8 then
    begin
      case Key of
        '0'..'9': key := key;
        else
          Key := #0;
      end;
    end;

  if Add then
      begin
        if (key = '0') and (RzSpinEdit1.SelStart = 0) then Key := #0;
      end
    else
      begin
        if Length(RzSpinEdit1.Text) > 0 then
            begin
              //if RzSpinEdit1.Text[1] = '0' then RzSpinEdit1.Text:=IntToStr(RzSpinEdit1.IntValue);

              if (RzSpinEdit1.IntValue = 0) and (Key = '0') then Key := #0;

               //RzSpinEdit1.SelStart:=Length(RzSpinEdit1.Text);
            end;
      end;
end;

end.
