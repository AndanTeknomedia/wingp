program wingpstack;

uses
  Vcl.Forms,
  umain in 'umain.pas' {fMain},
  superdate in 'superobject\superdate.pas',
  superdbg in 'superobject\superdbg.pas',
  superobject in 'superobject\superobject.pas',
  supertimezone in 'superobject\supertimezone.pas',
  supertypes in 'superobject\supertypes.pas',
  DelphiVault.Windows.ServiceManager in 'utils\DelphiVault.Windows.ServiceManager.pas',
  uInputVhost in 'utils\uInputVhost.pas' {FInputVhost},
  uvhostDeleteOption in 'utils\uvhostDeleteOption.pas' {fvHostDeleteOption},
  uvhostOption in 'utils\uvhostOption.pas' {fvHostOption},
  KaZip in 'kazip\KaZip.pas',
  zipusekazip in 'kazip\zipusekazip.pas',
  uAddPhpOptions in 'utils\uAddPhpOptions.pas' {FaddPhpVersion};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Wingp Stack Manager';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TFaddPhpVersion, FaddPhpVersion);
  Application.Run;
end.
