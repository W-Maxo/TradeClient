object AddForm: TAddForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1074' '#1079#1072#1082#1072#1079
  ClientHeight = 217
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 315
    Height = 217
    Align = alClient
    BevelOuter = bvNone
    Color = 16643823
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.0.1.0'
    BorderColor = 13087391
    Caption.Color = 16643823
    Caption.ColorTo = 15784647
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = 5978398
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = 15784647
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = 16643823
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 5978398
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 16643823
    StatusBar.ColorTo = 15784647
    StatusBar.GradientDirection = gdVertical
    Styler = MainForm.AdvPanelStyler1
    FullHeight = 0
    object RzLabel2: TRzLabel
      Left = 17
      Top = 247
      Width = 65
      Height = 13
      Caption = #1050#1086#1084#1077#1085#1090#1072#1088#1080#1081':'
      Transparent = True
    end
    object RzGroupBox1: TRzGroupBox
      Left = 8
      Top = 8
      Width = 297
      Height = 174
      TabOrder = 0
      Transparent = True
      object RzLabel1: TRzLabel
        Left = 97
        Top = 89
        Width = 39
        Height = 13
        Caption = #1050#1086#1083'-'#1074#1086':'
        Transparent = True
      end
      object RzStatusPane1: TRzStatusPane
        Left = 9
        Top = 146
        Width = 280
        BorderWidth = 0
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Alignment = taCenter
        Caption = #1057#1091#1084#1084#1072': '
      end
      object RzStatusPane2: TRzStatusPane
        Left = 4
        Top = 130
        Width = 293
        BorderWidth = 0
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Alignment = taCenter
        Caption = #1057#1090#1086#1080#1084#1086#1089#1090#1100': '
      end
      object rzstspn1: TRzStatusPane
        Left = 4
        Top = 112
        Width = 293
        BorderWidth = 0
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Alignment = taCenter
        Caption = '######'
      end
      object RzSpinEdit1: TRzSpinEdit
        Left = 142
        Top = 85
        Width = 68
        Height = 21
        AllowBlank = True
        AllowKeyEdit = True
        CheckRange = True
        Max = 10000.000000000000000000
        Min = 1.000000000000000000
        Value = 1.000000000000000000
        TabOrder = 0
        OnChange = RzSpinEdit1Change
        OnKeyPress = RzSpinEdit1KeyPress
      end
      object RzMemo1: TRzMemo
        Left = 8
        Top = 14
        Width = 281
        Height = 65
        Color = clInfoBk
        ReadOnly = True
        TabOrder = 1
      end
    end
    object AdvGlowButton1: TAdvGlowButton
      Left = 56
      Top = 188
      Width = 113
      Height = 25
      Caption = #1054#1050
      Images = MainForm.SystemImages
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 1
      OnClick = AdvGlowButton1Click
      Appearance.BorderColor = 14727579
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.Color = 15653832
      Appearance.ColorTo = 16178633
      Appearance.ColorChecked = 7915518
      Appearance.ColorCheckedTo = 11918331
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 15586496
      Appearance.ColorMirrorTo = 16245200
      Appearance.ColorMirrorHot = 5888767
      Appearance.ColorMirrorHotTo = 10807807
      Appearance.ColorMirrorDown = 946929
      Appearance.ColorMirrorDownTo = 5021693
      Appearance.ColorMirrorChecked = 10480637
      Appearance.ColorMirrorCheckedTo = 5682430
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
    end
    object AdvGlowButton2: TAdvGlowButton
      Left = 175
      Top = 188
      Width = 89
      Height = 25
      Caption = #1054#1090#1084#1077#1085#1072
      Images = MainForm.SystemImages
      ModalResult = 2
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 2
      Appearance.BorderColor = 14727579
      Appearance.BorderColorHot = 10079963
      Appearance.BorderColorDown = 4548219
      Appearance.Color = 15653832
      Appearance.ColorTo = 16178633
      Appearance.ColorChecked = 7915518
      Appearance.ColorCheckedTo = 11918331
      Appearance.ColorDisabled = 15921906
      Appearance.ColorDisabledTo = 15921906
      Appearance.ColorDown = 7778289
      Appearance.ColorDownTo = 4296947
      Appearance.ColorHot = 15465983
      Appearance.ColorHotTo = 11332863
      Appearance.ColorMirror = 15586496
      Appearance.ColorMirrorTo = 16245200
      Appearance.ColorMirrorHot = 5888767
      Appearance.ColorMirrorHotTo = 10807807
      Appearance.ColorMirrorDown = 946929
      Appearance.ColorMirrorDownTo = 5021693
      Appearance.ColorMirrorChecked = 10480637
      Appearance.ColorMirrorCheckedTo = 5682430
      Appearance.ColorMirrorDisabled = 11974326
      Appearance.ColorMirrorDisabledTo = 15921906
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
    end
    object RzMemo2: TRzMemo
      Left = 16
      Top = 263
      Width = 281
      Height = 36
      Color = clInfoBk
      TabOrder = 3
    end
  end
end
