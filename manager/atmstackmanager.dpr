program atmstackmanager;

uses
  Vcl.Forms,
  umain in 'umain.pas' {fMain},
  superdate in 'superobject\superdate.pas',
  superdbg in 'superobject\superdbg.pas',
  superobject in 'superobject\superobject.pas',
  supertimezone in 'superobject\supertimezone.pas',
  supertypes in 'superobject\supertypes.pas',
  DelphiVault.Windows.ServiceManager in 'utils\DelphiVault.Windows.ServiceManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
