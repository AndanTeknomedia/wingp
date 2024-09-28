object fvHostDeleteOption: TfvHostDeleteOption
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Delete vHost'
  ClientHeight = 146
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
  object Label1: TLabel
    Left = 40
    Top = 96
    Width = 190
    Height = 26
    Caption = 
      'Without reloading Nginx, you may need'#13#10'to manually remove root d' +
      'irectory'
  end
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
    Width = 169
    Height = 17
    Caption = 'Attempt delete root directory'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object Button1: TButton
    Left = 240
    Top = 62
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ckHost: TCheckBox
    Left = 40
    Top = 70
    Width = 169
    Height = 17
    Caption = 'Update hosts file'
    Checked = True
    State = cbChecked
    TabOrder = 3
  end
end
