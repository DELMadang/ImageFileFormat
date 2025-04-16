object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = #51060#48120#51648' '#54252#47607' '#50508#50500#45236#44592
  ClientHeight = 134
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object lbFileFormat: TLabel
    Left = 9
    Top = 67
    Width = 51
    Height = 15
    Caption = #54028#51068' '#54252#47607
  end
  object btnBrowse: TButton
    Left = 8
    Top = 23
    Width = 97
    Height = 25
    Caption = #52286#50500#48372#44592'...'
    TabOrder = 0
    OnClick = btnBrowseClick
  end
  object eFileFormat: TEdit
    Left = 9
    Top = 88
    Width = 268
    Height = 23
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = #47784#46304' '#54028#51068'(*.*)|*.*'
    Left = 200
    Top = 32
  end
end
