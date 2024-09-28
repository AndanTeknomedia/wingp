unit uInputVhost;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Samples.Spin, superobject, fileCtrl;

type
  TFInputVhost = class(TForm)
    eHost: TEdit;
    ck443: TCheckBox;
    eRoot: TButtonedEdit;
    eAlias: TEdit;
    cbPHP: TComboBox;
    cbIp6: TComboBox;
    ePort: TEdit;
    ckIndex: TCheckBox;
    btnSave: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ckhosts: TCheckBox;
    ckALias: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure eHostChange(Sender: TObject);
    procedure eRootRightButtonClick(Sender: TObject);
    procedure eHostKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    _modeEdit: Boolean;
    procedure clearInputs;
  public
    { Public declarations }
    function New: ISuperObject;
    function Edit(aHost: ISuperObject): Boolean;
    procedure Show(aHost: ISuperObject);
  end;

var
  FInputVhost: TFInputVhost;

implementation

{$R *.dfm}

uses umain;

{ TFInputVhost }

procedure TFInputVhost.btnSaveClick(Sender: TObject);
var
  i: integer;

begin
  self.Tag := mrNone;
  if eHost.Text = '' then
  begin
    MessageDlg('Host name must be specified!', mtError, [mbOK],0);
    if ehost.CanFocus then eHost.SetFocus;
    exit;
  end;
  if eRoot.Text = '' then
  begin
    MessageDlg('Root directory must be specified!', mtError, [mbOK],0);
    if eRoot.CanFocus then eRoot.SetFocus;
    exit;
  end;
  i := StrToIntDef(ePort.Text,0);
  if (i<=0) or (i>9999) then
  begin
    MessageDlg('Port must be in range 1 to 9999', mtError, [mbOK],0);
    if ePort.CanFocus then ePort.SetFocus;
    exit;
  end;
  if not DirectoryExists(eRoot.Text) then
  begin
    try
      ForceDirectories(eRoot.Text);
      self.Tag := mrOK;
      close;
    except
      self.tag := mrNone;
    end;
  end
  else
  begin
    self.Tag := mrOK;
    close;
  end;
end;

procedure TFInputVhost.Button2Click(Sender: TObject);
begin
  Tag := mrCancel;
  close;
end;

procedure TFInputVhost.clearInputs;
begin
  eHost.Clear;
  eAlias.Clear;
  eRoot.Clear;
  ePort.Text := '80';
  ck443.Checked := false;
  cbPHP.ItemIndex := 0;
  cbIp6.ItemIndex := 0;
  ckIndex.Checked := true;
  ckhosts.Checked := false;
  ckALias.Checked := false;
end;

function TFInputVhost.Edit(aHost: ISuperObject): Boolean;
begin
  Result := false;
end;

procedure TFInputVhost.eHostChange(Sender: TObject);
var
  s: string;
begin
  s := eHost.Text;
  if s.StartsWith('www', true) then
    eAlias.Text := s
  else
    eAlias.Text := 'www.'+s;
end;

procedure TFInputVhost.eHostKeyPress(Sender: TObject; var Key: Char);
const
  AllowedChars: set of char =
    ['a'..'z', 'A'..'Z', '0'..'9','.','-',#8];
begin
  if not (key in AllowedChars) then
    key := #0;
end;

procedure TFInputVhost.eRootRightButtonClick(Sender: TObject);
var
  dir: String;
begin
  dir := ExtractFilePath(Application.ExeName)+'vhosts';
  if SelectDirectory('Root Directory', '',
    dir,
    [sdNewFolder, sdNewUI, sdValidateDir, sdShowEdit], self) then
  begin
    eRoot.Text := ExcludeTrailingPathDelimiter(dir);
  end;
end;

function TFInputVhost.New: ISuperObject;
var
  f: TFInputVhost;
begin
  Result := so;
  Result.B['ok'] := false;
  clearInputs();
  ckhosts.Enabled := IsUserAnAdmin();
  ckhosts.Checked := ckhosts.Enabled;

  _modeEdit := false;
  Tag := mrNone;

  ShowModal;
  if Tag = mrOk then
  begin
    Result.S['name'] := eHost.Text;

    Result.S['root'] := String(eRoot.Text).replace('\','/');

    Result.ForcePath('alias', stArray);
    if ckALias.Checked then
      Result.A['alias'].S[0]:=eAlias.Text;

    Result.I['port'] := StrToInt(ePort.Text);
    if ck443.Checked then
      Result.S['port443'] := 'yes'
    else
      Result.S['port443'] := 'no';

    if cbPHP.ItemIndex = 0 then
      Result.S['usePhp'] := 'yes'
    else
      Result.S['usePhp'] := 'no';

    if cbIp6.ItemIndex = 0 then
      Result.S['ipv6'] := 'no'
    else
      Result.S['ipv6'] := 'yes';

    if ckIndex.Checked then
      Result.S['defaultIndex'] := 'yes'
    else
      Result.S['defaultIndex'] := 'no';
    Result.B['updateHostsFile'] := ckhosts.Enabled and ckhosts.Checked;

    Result.B['ok'] := true;
  end;
end;

procedure TFInputVhost.Show(aHost: ISuperObject);
begin

end;

end.
