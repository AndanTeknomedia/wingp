object fvHostOption: TfvHostOption
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Create vHost'
  ClientHeight = 114
  ClientWidth = 351
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ckNginx: TCheckBox
    Left = 40
    Top = 24
    Width = 145
    Height = 17
    Caption = 'Reload Nginx'
    Checked = True
    State = cbChecked
    TabOrder = 0
    OnClick = ckNginxClick
  end
  object ckPage: TCheckBox
    Left = 40
    Top = 47
    Width = 145
    Height = 17
    Caption = 'Open Default Page'
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object Button1: TButton
    Left = 232
    Top = 39
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = Button1Click
  end
end
