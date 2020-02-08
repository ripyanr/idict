object FSetting: TFSetting
  Left = 707
  Top = 129
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '  IDICT : Setting'
  ClientHeight = 310
  ClientWidth = 345
  Color = clSilver
  Font.Charset = ANSI_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'Verdana'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    345
    310)
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 200
    Width = 329
    Height = 97
    Brush.Style = bsClear
    Pen.Color = clGray
  end
  object Image1: TImage
    Left = 304
    Top = 0
    Width = 41
    Height = 25
    Anchors = [akTop, akRight]
    Stretch = True
  end
  object Image2: TImage
    Left = 0
    Top = 0
    Width = 305
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Stretch = True
  end
  object Label3: TLabel
    Left = 208
    Top = 32
    Width = 65
    Height = 13
    Caption = 'Gaya Huruf'
  end
  object Label2: TLabel
    Left = 144
    Top = 32
    Width = 41
    Height = 13
    Caption = 'Ukuran'
  end
  object Label1: TLabel
    Left = 8
    Top = 32
    Width = 67
    Height = 13
    Caption = 'Nama huruf'
  end
  object Label4: TLabel
    Left = 24
    Top = 208
    Width = 25
    Height = 13
    Caption = 'Text'
  end
  object WARNA: TLabel
    Left = 8
    Top = 184
    Width = 43
    Height = 13
    Caption = 'WARNA'
  end
  object Label7: TLabel
    Left = 24
    Top = 248
    Width = 43
    Height = 13
    Caption = 'BG text'
  end
  object Label8: TLabel
    Left = 184
    Top = 208
    Width = 44
    Height = 13
    Caption = 'BG side'
  end
  object Label9: TLabel
    Left = 184
    Top = 248
    Width = 50
    Height = 13
    Caption = 'BG Form'
  end
  object Label6: TLabel
    Left = 8
    Top = 6
    Width = 189
    Height = 14
    Caption = 'Set Configure for application'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object lstname: TListBox
    Left = 8
    Top = 72
    Width = 129
    Height = 105
    ItemHeight = 13
    TabOrder = 0
    OnClick = lstnameClick
  end
  object tname: TEdit
    Left = 8
    Top = 48
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 7
  end
  object tsize: TEdit
    Left = 144
    Top = 48
    Width = 57
    Height = 21
    ReadOnly = True
    TabOrder = 8
  end
  object lstsize: TListBox
    Left = 144
    Top = 72
    Width = 57
    Height = 105
    ItemHeight = 13
    TabOrder = 1
    OnClick = lstsizeClick
  end
  object lststyle: TListBox
    Left = 208
    Top = 72
    Width = 129
    Height = 105
    ItemHeight = 13
    TabOrder = 2
    OnClick = lststyleClick
  end
  object tstyle: TEdit
    Left = 208
    Top = 48
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 9
  end
  object cb1: TComboBox
    Left = 24
    Top = 264
    Width = 129
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 5
    OnClick = cb1Click
  end
  object cb2: TComboBox
    Left = 184
    Top = 264
    Width = 137
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 6
    OnClick = cb2Click
  end
  object cb3: TComboBox
    Left = 184
    Top = 224
    Width = 137
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 4
    OnClick = cb3Click
  end
  object cbowarna: TComboBox
    Left = 24
    Top = 224
    Width = 129
    Height = 21
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnClick = cbowarnaClick
  end
end
