object AboutForm: TAboutForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1054' '#1055#1088#1086#1075#1088#1072#1084#1084#1077
  ClientHeight = 325
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShortCut = FormShortCut
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 290
    Height = 325
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
    object AdvGlowButton1: TAdvGlowButton
      Left = 88
      Top = 295
      Width = 113
      Height = 25
      Caption = #1054#1050
      Images = MainForm.SystemImages
      ModalResult = 1
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      TabOrder = 0
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
    object RzGroupBox1: TRzGroupBox
      Left = 8
      Top = 0
      Width = 273
      Height = 289
      TabOrder = 1
      Transparent = True
      object RzStatusPane1: TRzStatusPane
        Left = 7
        Top = 76
        Width = 258
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Alignment = taCenter
        Caption = '########'
      end
      object RzStatusPane2: TRzStatusPane
        Left = 9
        Top = 94
        Width = 256
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        Alignment = taCenter
        Caption = '########'
      end
      object AdvReflectionLabel1: TAdvReflectionLabel
        Left = 0
        Top = 15
        Width = 273
        Height = 73
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        HTMLText.Strings = (
          
            '<FONT face="Verdana"  size="20"  ><B><P align="center">Mannol Tr' +
            'ade </P></B></FONT>')
        ParentFont = False
        ReflectionOpacityStart = 50
        ReflectionSize = 20
        ReflectionAxis = -60
        URLColor = clBlue
        Version = '1.5.1.0'
      end
      object rzstspn2: TRzStatusPane
        Left = 0
        Top = 228
        Width = 273
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        Alignment = taCenter
        Caption = #1042#1072#1096' '#1087#1077#1088#1089#1086#1085#1072#1083#1100#1085#1099#1081' '#1084#1077#1085#1077#1076#1078#1077#1088':'
      end
      object rzstspn3: TRzStatusPane
        Left = 0
        Top = 244
        Width = 273
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        Alignment = taCenter
        Caption = '##########'
      end
      object rzstspn4: TRzStatusPane
        Left = 1
        Top = 261
        Width = 273
        FrameStyle = fsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsItalic]
        ParentFont = False
        Alignment = taCenter
        Caption = '##########'
      end
      object RzGroupBox2: TRzGroupBox
        Left = 8
        Top = 112
        Width = 257
        Height = 110
        TabOrder = 0
        Transparent = True
        object RzURLLabel1: TRzURLLabel
          Left = 0
          Top = 88
          Width = 257
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = 'mailto:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          Transparent = True
        end
        object RzStatusPane3: TRzStatusPane
          Left = 1
          Top = 9
          Width = 256
          FrameStyle = fsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsItalic]
          ParentFont = False
          Alignment = taCenter
          Caption = '#######'
        end
        object RzStatusPane4: TRzStatusPane
          Left = -1
          Top = 24
          Width = 258
          FrameStyle = fsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          ParentFont = False
          Alignment = taCenter
          Caption = '########'
        end
        object RzStatusPane5: TRzStatusPane
          Left = -1
          Top = 40
          Width = 258
          FrameStyle = fsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          ParentFont = False
          Alignment = taCenter
          Caption = '########'
        end
        object rzstspn1: TRzStatusPane
          Left = -1
          Top = 54
          Width = 258
          FrameStyle = fsNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsItalic]
          ParentFont = False
          Alignment = taCenter
          Caption = '########'
        end
        object lbl1: TRzURLLabel
          Left = 1
          Top = 74
          Width = 256
          Height = 13
          Alignment = taCenter
          AutoSize = False
          Caption = '##########'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHotLight
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsUnderline]
          ParentFont = False
          Transparent = True
        end
      end
    end
  end
end