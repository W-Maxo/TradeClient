unit WaitL;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, RzTreeVw;

type
  TWaitForm = class(TForm)
    tv1: TRzTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WaitForm: TWaitForm;

implementation

{$R *.dfm}

end.
