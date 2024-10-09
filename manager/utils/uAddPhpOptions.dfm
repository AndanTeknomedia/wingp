object FaddPhpVersion: TFaddPhpVersion
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Add PHP Version'
  ClientHeight = 174
  ClientWidth = 589
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
    Left = 32
    Top = 18
    Width = 82
    Height = 13
    Caption = 'Add From Zip File'
  end
  object Label2: TLabel
    Left = 32
    Top = 92
    Width = 131
    Height = 13
    Caption = 'Download From Official Site'
  end
  object eZip: TButtonedEdit
    Left = 32
    Top = 37
    Width = 385
    Height = 21
    Images = fMain.ilWin
    RightButton.Hint = 'Browse...'
    RightButton.ImageIndex = 67
    RightButton.Visible = True
    TabOrder = 1
    OnRightButtonClick = eZipRightButtonClick
  end
  object eURL: TButtonedEdit
    Left = 32
    Top = 111
    Width = 385
    Height = 21
    Images = fMain.ilWin
    RightButton.Hint = 'Go...'
    RightButton.ImageIndex = 17
    RightButton.Visible = True
    TabOrder = 3
    Text = 'https://windows.php.net/downloads/releases/archives/'
    OnRightButtonClick = eURLRightButtonClick
  end
  object Button1: TButton
    Left = 464
    Top = 18
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 464
    Top = 49
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
  object odZIP: TOpenDialog
    DefaultExt = 'zip'
    Filter = 'PHP Archive Zip (*.zip)|*.zip|All Files(*.*)|*.*'
    FilterIndex = 0
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Select PHP Zip Archive'
    Left = 280
    Top = 64
  end
end
