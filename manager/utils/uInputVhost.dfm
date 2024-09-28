object FInputVhost: TFInputVhost
  Left = 0
  Top = 0
  Caption = 'vHost'
  ClientHeight = 342
  ClientWidth = 510
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
    Top = 27
    Width = 51
    Height = 13
    Caption = 'Host name'
  end
  object Label4: TLabel
    Left = 40
    Top = 73
    Width = 69
    Height = 13
    Caption = 'Root directory'
  end
  object Label5: TLabel
    Left = 40
    Top = 96
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label6: TLabel
    Left = 40
    Top = 119
    Width = 44
    Height = 13
    Caption = 'With PHP'
  end
  object Label7: TLabel
    Left = 40
    Top = 142
    Width = 47
    Height = 13
    Caption = 'With IPv6'
  end
  object Label3: TLabel
    Left = 40
    Top = 265
    Width = 429
    Height = 39
    Caption = 
      '* Root directory will be created if not exists.'#13#10'* Update hosts ' +
      'need this program to be ran under Administrator Privilege.'#13#10'* Up' +
      'date hosts file may be interfering with Windows Defender, Antivi' +
      'rus, or other issues.'
  end
  object Label8: TLabel
    Left = 314
    Top = 27
    Width = 116
    Height = 13
    Caption = 'must not already in use!'
  end
  object Label9: TLabel
    Left = 314
    Top = 48
    Width = 3
    Height = 13
  end
  object Label10: TLabel
    Left = 314
    Top = 50
    Width = 106
    Height = 13
    Caption = 'not fully implemented.'
  end
  object eHost: TEdit
    Left = 152
    Top = 24
    Width = 156
    Height = 21
    TabOrder = 0
    OnChange = eHostChange
    OnKeyPress = eHostKeyPress
  end
  object ck443: TCheckBox
    Left = 207
    Top = 95
    Width = 242
    Height = 17
    Caption = 'Also Listen At Port 443'
    TabOrder = 5
  end
  object eRoot: TButtonedEdit
    Left = 152
    Top = 70
    Width = 297
    Height = 21
    Images = fMain.ilWin
    RightButton.ImageIndex = 67
    RightButton.Visible = True
    TabOrder = 3
    OnRightButtonClick = eRootRightButtonClick
  end
  object eAlias: TEdit
    Left = 152
    Top = 47
    Width = 156
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 1
    Text = 'www'
  end
  object cbPHP: TComboBox
    Left = 152
    Top = 116
    Width = 156
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 6
    Text = 'Enable PHP (FastCGI)'
    Items.Strings = (
      'Enable PHP (FastCGI)'
      'Don'#39't Enable PHP')
  end
  object cbIp6: TComboBox
    Left = 152
    Top = 139
    Width = 156
    Height = 21
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 7
    Text = 'IPv4 Only'
    Items.Strings = (
      'IPv4 Only'
      'IPv4 and IPv6')
  end
  object ePort: TEdit
    Left = 152
    Top = 93
    Width = 49
    Height = 21
    MaxLength = 4
    NumbersOnly = True
    TabOrder = 4
    Text = '80'
  end
  object ckIndex: TCheckBox
    Left = 152
    Top = 168
    Width = 225
    Height = 17
    Caption = 'Generate Default Index File'
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object btnSave: TButton
    Left = 152
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 10
    OnClick = btnSaveClick
  end
  object Button2: TButton
    Left = 233
    Top = 224
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 11
    OnClick = Button2Click
  end
  object ckhosts: TCheckBox
    Left = 152
    Top = 191
    Width = 145
    Height = 17
    Caption = 'Update hosts file'
    Checked = True
    State = cbChecked
    TabOrder = 9
  end
  object ckALias: TCheckBox
    Left = 40
    Top = 49
    Width = 97
    Height = 17
    Caption = 'Alias(es)'
    Enabled = False
    TabOrder = 2
  end
end
