object FApdate: TFApdate
  Left = 696
  Top = 130
  Width = 340
  Height = 352
  Caption = '  IDICT : Add or Edit Data'
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    324
    314)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 17
    Top = 40
    Width = 42
    Height = 13
    Caption = 'Istilah'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 17
    Top = 88
    Width = 71
    Height = 13
    Caption = 'Perngetian'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel
    Left = 14
    Top = 184
    Width = 72
    Height = 13
    Caption = 'Penjelasan'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Image1: TImage
    Left = -90
    Top = -3
    Width = 422
    Height = 28
    Anchors = [akLeft, akTop, akRight]
    Stretch = True
  end
  object Label6: TLabel
    Left = 8
    Top = 6
    Width = 209
    Height = 14
    Caption = 'Add New Word or Edit If Wrong'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object t_ist: TEdit
    Left = 16
    Top = 56
    Width = 297
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 176
    Top = 278
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Simpan'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 248
    Top = 278
    Width = 65
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Close'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object t_art: TMemo
    Left = 16
    Top = 104
    Width = 297
    Height = 65
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      't_art')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object t_penj: TMemo
    Left = 16
    Top = 200
    Width = 297
    Height = 65
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      't_penj')
    ScrollBars = ssVertical
    TabOrder = 2
  end
end
