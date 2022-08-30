object SplashForm: TSplashForm
  Left = 0
  Top = 0
  Caption = 'SplashForm'
  ClientHeight = 356
  ClientWidth = 533
  Color = clBtnFace
  TransparentColor = True
  TransparentColorValue = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzFormShape1: TRzFormShape
    Left = 0
    Top = 0
    Width = 533
    Height = 356
    AutoSize = True
    ExplicitWidth = 420
    ExplicitHeight = 291
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 8
    Width = 169
    Height = 17
    TabOrder = 0
    Visible = False
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 16
    Top = 32
  end
end
