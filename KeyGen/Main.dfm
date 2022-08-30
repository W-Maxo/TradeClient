object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Trading agent Key Generator'
  ClientHeight = 552
  ClientWidth = 782
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object RzPanel1: TRzPanel
    Left = 398
    Top = 0
    Width = 384
    Height = 552
    Align = alRight
    BorderOuter = fsFlat
    TabOrder = 0
    object rzstspn1: TRzStatusPane
      Left = 6
      Top = 10
      Width = 75
      FrameStyle = fsNone
      Alignment = taRightJustify
      Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072':'
    end
    object RzGroupBox1: TRzGroupBox
      Left = 6
      Top = 351
      Width = 259
      Height = 194
      Caption = #1057#1077#1088#1074#1077#1088':'
      TabOrder = 0
      Transparent = True
      object RzStatusPane1: TRzStatusPane
        Left = 3
        Top = 17
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1040#1076#1088#1077#1089' '#1089#1077#1088#1074#1077#1088#1072':'
      end
      object RzStatusPane2: TRzStatusPane
        Left = 3
        Top = 49
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1055#1086#1088#1090':'
      end
      object RzStatusPane3: TRzStatusPane
        Left = 4
        Top = 140
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1048#1084#1103':'
      end
      object RzStatusPane4: TRzStatusPane
        Left = 3
        Top = 166
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100':'
      end
      object RzStatusPane7: TRzStatusPane
        Left = 4
        Top = 102
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1044#1080#1088#1077#1082#1090#1086#1088#1080#1103':'
      end
      object AddressEdit: TRzEdit
        Left = 110
        Top = 16
        Width = 140
        Height = 21
        TabOrder = 0
      end
      object PortEdit: TRzNumericEdit
        Left = 110
        Top = 48
        Width = 52
        Height = 21
        TabOrder = 1
        DisplayFormat = ',0;(,0)'
        Value = 21.000000000000000000
      end
      object SrvPassEdit: TRzMaskEdit
        Left = 111
        Top = 166
        Width = 139
        Height = 21
        TabOrder = 2
      end
      object SrvUserEdit: TRzEdit
        Left = 110
        Top = 135
        Width = 140
        Height = 21
        TabOrder = 3
      end
      object DirEdit: TRzEdit
        Left = 110
        Top = 101
        Width = 140
        Height = 21
        TabOrder = 4
      end
      object PassiveCheckBox: TRzCheckBox
        Left = 53
        Top = 75
        Width = 109
        Height = 15
        Caption = #1055#1072#1089#1089#1080#1074#1085#1099#1081' '#1088#1077#1078#1080#1084
        Checked = True
        State = cbChecked
        TabOrder = 5
        Transparent = True
      end
    end
    object RzGroupBox2: TRzGroupBox
      Left = 9
      Top = 33
      Width = 368
      Height = 122
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
      TabOrder = 1
      Transparent = True
      object RzStatusPane5: TRzStatusPane
        Left = 1
        Top = 17
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = 'ID '#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103':'
      end
      object RzStatusPane6: TRzStatusPane
        Left = 1
        Top = 42
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1055#1072#1088#1086#1083#1100':'
      end
      object RzStatusPane10: TRzStatusPane
        Left = 2
        Top = 68
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1048#1084#1103':'
      end
      object RzStatusPane11: TRzStatusPane
        Left = 2
        Top = 95
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1060#1072#1084#1080#1083#1080#1103':'
      end
      object IDUserEdit: TRzEdit
        Left = 107
        Top = 16
        Width = 252
        Height = 21
        TabOrder = 0
      end
      object PasswordEdit: TRzMaskEdit
        Left = 108
        Top = 41
        Width = 251
        Height = 21
        TabOrder = 1
      end
      object RzEdit2: TRzEdit
        Left = 107
        Top = 67
        Width = 252
        Height = 21
        TabOrder = 2
      end
      object RzMaskEdit2: TRzMaskEdit
        Left = 108
        Top = 94
        Width = 251
        Height = 21
        TabOrder = 3
      end
    end
    object RzGroupBox3: TRzGroupBox
      Left = 9
      Top = 161
      Width = 368
      Height = 184
      Caption = #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1082#1086#1084#1087#1072#1085#1080#1080':'
      TabOrder = 2
      Transparent = True
      object RzStatusPane8: TRzStatusPane
        Left = 2
        Top = 18
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
      end
      object RzStatusPane9: TRzStatusPane
        Left = 1
        Top = 45
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1090#1077#1083'. :'
      end
      object RzStatusPane12: TRzStatusPane
        Left = 1
        Top = 72
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = #1040#1076#1088#1077#1089'  :'
      end
      object RzStatusPane13: TRzStatusPane
        Left = 1
        Top = 99
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = 'e-mail :'
      end
      object RzStatusPane14: TRzStatusPane
        Left = 1
        Top = 126
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = 'URL:'
      end
      object RzStatusPane15: TRzStatusPane
        Left = 1
        Top = 153
        FrameStyle = fsNone
        Alignment = taRightJustify
        Caption = 'Fax:'
      end
      object RzEdit1: TRzEdit
        Left = 108
        Top = 17
        Width = 252
        Height = 21
        TabOrder = 0
      end
      object RzMaskEdit1: TRzMaskEdit
        Left = 108
        Top = 44
        Width = 251
        Height = 21
        TabOrder = 1
      end
      object RzMaskEdit3: TRzMaskEdit
        Left = 107
        Top = 71
        Width = 251
        Height = 21
        TabOrder = 2
      end
      object RzMaskEdit4: TRzMaskEdit
        Left = 107
        Top = 98
        Width = 251
        Height = 21
        TabOrder = 3
      end
      object RzMaskEdit5: TRzMaskEdit
        Left = 107
        Top = 125
        Width = 251
        Height = 21
        TabOrder = 4
      end
      object RzMaskEdit6: TRzMaskEdit
        Left = 107
        Top = 152
        Width = 251
        Height = 21
        TabOrder = 5
      end
    end
    object RzGroupBox4: TRzGroupBox
      Left = 271
      Top = 351
      Width = 106
      Height = 112
      Caption = #1044#1086#1089#1090#1091#1087':'
      TabOrder = 3
      object RzCheckBox1: TRzCheckBox
        Left = 16
        Top = 16
        Width = 57
        Height = 15
        Caption = #1058#1086#1074#1072#1088#1099
        State = cbUnchecked
        TabOrder = 0
      end
      object RzCheckBox2: TRzCheckBox
        Left = 16
        Top = 37
        Width = 56
        Height = 15
        Caption = #1047#1072#1082#1072#1079#1099
        State = cbUnchecked
        TabOrder = 1
      end
      object RzCheckBox3: TRzCheckBox
        Left = 16
        Top = 58
        Width = 50
        Height = 15
        Caption = #1044#1086#1083#1075#1080
        State = cbUnchecked
        TabOrder = 2
      end
      object RzCheckBox4: TRzCheckBox
        Left = 16
        Top = 79
        Width = 65
        Height = 15
        Caption = #1055#1088#1086#1076#1072#1078#1080
        State = cbUnchecked
        TabOrder = 3
      end
    end
    object RzBitBtn1: TRzBitBtn
      Left = 278
      Top = 469
      Width = 99
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      TabOrder = 4
      OnClick = RzBitBtn1Click
    end
    object edt1: TRzEdit
      Left = 80
      Top = 9
      Width = 289
      Height = 21
      TabOrder = 5
    end
  end
  object rzpnl1: TRzPanel
    Left = 0
    Top = 0
    Width = 398
    Height = 552
    Align = alClient
    BorderOuter = fsFlat
    TabOrder = 1
    object lstLisr: TAdvOutlookList
      AlignWithMargins = True
      Left = 4
      Top = 36
      Width = 390
      Height = 512
      Margins.Top = 35
      Align = alClient
      Columns = <
        item
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end
        item
          Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072
          Width = 120
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end
        item
          Caption = 'ID'
          Width = 120
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end
        item
          Caption = #1048#1084#1103
          Width = 75
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end
        item
          Caption = #1060#1072#1084#1080#1083#1080#1103
          Width = 75
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end
        item
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          HeaderFont.Charset = DEFAULT_CHARSET
          HeaderFont.Color = clWindowText
          HeaderFont.Height = -11
          HeaderFont.Name = 'Tahoma'
          HeaderFont.Style = []
        end>
      Color = clWhite
      DragDropSetting = ddDisabled
      GroupItemHeight = 0
      GroupShowCount = False
      HeaderDragDrop = ddDisabled
      HideSelection = False
      LookUp.Method = lmDirect
      GroupColumnDisplay = gdHidden
      ProgressAppearance.CompleteColor = clLime
      ProgressAppearance.Level1Perc = 30
      ProgressAppearance.Level2Perc = 60
      PreviewSettings.Font.Charset = DEFAULT_CHARSET
      PreviewSettings.Font.Color = clBlue
      PreviewSettings.Font.Height = -11
      PreviewSettings.Font.Name = 'MS Sans Serif'
      PreviewSettings.Font.Style = []
      SelectionOptions = [soRightClickSelect]
      GroupFont.Charset = DEFAULT_CHARSET
      GroupFont.Color = 12150839
      GroupFont.Height = -11
      GroupFont.Name = 'Tahoma'
      GroupFont.Style = []
      GroupCountFont.Charset = DEFAULT_CHARSET
      GroupCountFont.Color = clBlack
      GroupCountFont.Height = -11
      GroupCountFont.Name = 'Tahoma'
      GroupCountFont.Style = []
      ShowHint = True
      ShowNodes = False
      SortSettings.SortGroups = False
      TabOrder = 0
      TabStop = True
      URLSettings.FontStyle = [fsUnderline]
      Version = '1.7.1.0'
      OnSelectionChange = lstLisrSelectionChange
    end
  end
  object RzRegIniFile1: TRzRegIniFile
    Left = 160
    Top = 272
  end
  object RzPropertyStore1: TRzPropertyStore
    Properties = <
      item
        Component = IDUserEdit
        PropertyName = 'Text'
      end
      item
        Component = PasswordEdit
        PropertyName = 'Text'
      end
      item
        Component = RzEdit2
        PropertyName = 'Text'
      end
      item
        Component = RzMaskEdit2
        PropertyName = 'Text'
      end
      item
        Component = RzEdit1
        PropertyName = 'Text'
      end
      item
        Component = RzMaskEdit1
        PropertyName = 'Text'
      end
      item
        Component = RzMaskEdit3
        PropertyName = 'Text'
      end
      item
        Component = RzMaskEdit4
        PropertyName = 'Text'
      end
      item
        Component = AddressEdit
        PropertyName = 'Text'
      end
      item
        Component = PortEdit
        PropertyName = 'Value'
      end
      item
        Component = PassiveCheckBox
        PropertyName = 'Checked'
      end
      item
        Component = DirEdit
        PropertyName = 'Text'
      end
      item
        Component = SrvUserEdit
        PropertyName = 'Text'
      end
      item
        Component = SrvPassEdit
        PropertyName = 'Text'
      end
      item
        Component = RzCheckBox1
        PropertyName = 'Checked'
      end
      item
        Component = RzCheckBox2
        PropertyName = 'Checked'
      end
      item
        Component = RzCheckBox3
        PropertyName = 'Checked'
      end
      item
        Component = RzCheckBox4
        PropertyName = 'Checked'
      end
      item
        Component = RzMaskEdit5
        PropertyName = 'Text'
      end
      item
        Component = RzMaskEdit6
        PropertyName = 'Text'
      end>
    RegIniFile = RzRegIniFile1
    Left = 160
    Top = 224
  end
  object RzFormState1: TRzFormState
    RegIniFile = RzRegIniFile1
    Left = 160
    Top = 320
  end
  object SaveDialog1: TSaveDialog
    Left = 160
    Top = 176
  end
end
