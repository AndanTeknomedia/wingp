unit uvhostDeleteOption;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  THostDeleteOption  = (sdoReloadNginx, sdoRemoveRootDir, sdoUpdateHostsFile);
  THostDeleteOptions = set of THostDeleteOption;
  TfvHostDeleteOption = class(TForm)
    ckNginx: TCheckBox;
    ckPage: TCheckBox;
    Button1: TButton;
    Label1: TLabel;
    ckHost: TCheckBox;
    procedure ckNginxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetvHostDeleteOptions(var options: THostDeleteOptions): Boolean;

implementation

{$R *.dfm}

function GetvHostDeleteOptions(var options: THostDeleteOptions): Boolean;
var
  F: TfvHostDeleteOption;
begin
  Result := false;
  f := TfvHostDeleteOption.Create(Application);
  try
    f.ckNginx.Checked := sdoReloadNginx in options;
    f.ckPage.Checked := sdoRemoveRootDir in options;
    f.ckNginxClick(F.ckNginx);
    f.ckHost.Checked := sdoUpdateHostsFile in options;
    f.ShowModal;
    options := [];
    if F.ckNginx.Checked then
    begin
      Include(options, sdoReloadNginx);
      if F.ckPage.Checked then
        Include(options, sdoRemoveRootDir);
    end;
    if f.ckHost.Checked then
      Include(options, sdoUpdateHostsFile);
    Result := true;
  finally
    f.Free;
  end;
end;

procedure TfvHostDeleteOption.Button1Click(Sender: TObject);
begin
  CLose;
end;

procedure TfvHostDeleteOption.ckNginxClick(Sender: TObject);
begin
  ckPage.Enabled := ckNginx.Checked;
end;

end.
