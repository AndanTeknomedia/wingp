unit uAddPhpOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Winapi.shellAPi;

type
  TFaddPhpVersion = class(TForm)
    odZIP: TOpenDialog;
    Label1: TLabel;
    eZip: TButtonedEdit;
    Label2: TLabel;
    eURL: TButtonedEdit;
    Button1: TButton;
    Button2: TButton;
    procedure eZipRightButtonClick(Sender: TObject);
    procedure eURLRightButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function isValidPhpZip(const ZipFile: String): Boolean;
  end;

var
  FaddPhpVersion: TFaddPhpVersion;

implementation

{$R *.dfm}

uses KaZip;

procedure TFaddPhpVersion.Button1Click(Sender: TObject);
begin
  if not FileExists(eZip.Text) then
  begin
    MessageDlg('File not found!', mtError, [mbOK], 0);
    if eZip.CanFocus then eZip.SetFocus;
    exit;
  end;
  if not isValidPhpZip(eZip.Text) then
  begin
    MessageDlg('This file is not PHP Zip file!', mtError, [mbOK], 0);
    if eZip.CanFocus then eZip.SetFocus;
    exit;
  end;
  Tag := mrOk;
  Close;
end;

procedure TFaddPhpVersion.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFaddPhpVersion.eURLRightButtonClick(Sender: TObject);
begin
  ShellExecute(handle, 'open', PChar(eURL.Text), nil, nil, SW_SHOWNORMAL);
end;

procedure TFaddPhpVersion.eZipRightButtonClick(Sender: TObject);
begin
  if odZIP.Execute(handle) then
  begin
    if not isValidPhpZip(odZIP.FileName) then
      MessageDlg('This file is not PHP Zip file!', mtError, [mbOK], 0)
    else
      eZip.Text := odZIP.FileName;
  end;
end;

function TFaddPhpVersion.isValidPhpZip(const ZipFile: String): Boolean;
var
  zk: TKAZip;
begin
  Result := False;
  if not FileExists(ZipFile) then
    exit;
  zk := TKAZip.Create(self);
  try
    zk.Open(ZipFile);
    if zk.IsZipFile then
    begin
      Result :=
        (zk.FileNames.IndexOf('php-cgi.exe') > -1) and
        (zk.FileNames.IndexOf('php-win.exe') > -1) and
        (zk.FileNames.IndexOf('php.exe') > -1) and
        (zk.FileNames.IndexOf('php.ini-production') > -1) and
        (1=1);
    end;
    zk.Close;
  finally
    zk.Free;
  end;
end;

end.
