unit uvhostOption;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  THostCreationOption  = (scoReloadNginx, scoOpenDefaultPage);
  THostCreationOptions = set of THostCreationOption;
  TfvHostOption = class(TForm)
    ckNginx: TCheckBox;
    ckPage: TCheckBox;
    Button1: TButton;
    procedure ckNginxClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetvHostOptions(var options: THostCreationOptions): Boolean;

implementation

{$R *.dfm}

function GetvHostOptions(var options: THostCreationOptions): Boolean;
var
  F: TfvHostOption;
begin
  Result := false;
  f := TfvHostOption.Create(Application);
  try
    f.ckNginx.Checked := scoReloadNginx in options;
    f.ckPage.Checked := scoOpenDefaultPage in options;
    f.ckNginxClick(F.ckNginx);
    f.ShowModal;
    options := [];
    if F.ckNginx.Checked then
    begin
      Include(options, scoReloadNginx);
      if F.ckPage.Checked then
        Include(options, scoOpenDefaultPage);
    end;
    Result := true;
  finally
    f.Free;
  end;
end;

procedure TfvHostOption.Button1Click(Sender: TObject);
begin
  CLose;
end;

procedure TfvHostOption.ckNginxClick(Sender: TObject);
begin
  ckPage.Enabled := ckNginx.Checked;
end;

end.
