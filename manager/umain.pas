unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList,
  DelphiVault.Windows.ServiceManager, Vcl.Grids, Vcl.ValEdit;

type
  TfMain = class(TForm)
    MainMenu1: TMainMenu;
    tray1: TTrayIcon;
    ActionManager1: TActionManager;
    PageControl1: TPageControl;
    tsNginx: TTabSheet;
    Server1: TMenuItem;
    VHosts1: TMenuItem;
    PHP1: TMenuItem;
    acInstallNginx: TAction;
    acUnistallNginx: TAction;
    acStartNginx: TAction;
    acStopNginx: TAction;
    acRestartNginx: TAction;
    acEditNginxConf: TAction;
    acMinimize: TAction;
    acQuit: TAction;
    acInstallPHP: TAction;
    acUninstallPHP: TAction;
    acStartPHP: TAction;
    acStopPHP: TAction;
    acRestartPHP: TAction;
    acEditPHPIni: TAction;
    acAddVHost: TAction;
    acDeleteVHosts: TAction;
    acEditHostsFile: TAction;
    Manager1: TMenuItem;
    acMinimize1: TMenuItem;
    acQuit1: TMenuItem;
    acInstallNginx1: TMenuItem;
    acUnistallNginx1: TMenuItem;
    N1: TMenuItem;
    acStartNginx1: TMenuItem;
    acStopNginx1: TMenuItem;
    acRestartNginx1: TMenuItem;
    acEditNginxConf1: TMenuItem;
    N2: TMenuItem;
    tsPHP: TTabSheet;
    ilWin: TImageList;
    acInstallPHP1: TMenuItem;
    acUninstallPHP1: TMenuItem;
    N3: TMenuItem;
    acStartPHP1: TMenuItem;
    acStopPHP1: TMenuItem;
    acRestartPHP1: TMenuItem;
    N4: TMenuItem;
    acEditPHPIni1: TMenuItem;
    acAddVHost1: TMenuItem;
    acDeleteVHosts1: TMenuItem;
    acEditHostsFile1: TMenuItem;
    ValueListEditor1: TValueListEditor;
    tsVhosts: TTabSheet;
    pmTray: TPopupMenu;
    acTrayRestore: TAction;
    ShowMonitor1: TMenuItem;
    acRefresh: TAction;
    procedure acMinimizeExecute(Sender: TObject);
    procedure acTrayRestoreExecute(Sender: TObject);
    procedure acQuitExecute(Sender: TObject);
    procedure tray1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
  private
    { Private declarations }
    SvcNginxState,
    SvcPhpState : TServiceState;
    SvcNginxInfo,
    SvcPhpInfo: TServiceInfo;

    fSCM: TServiceManager;

    procedure ProcessSCMData;

    function isSvcNginxInstalled: Boolean;
    function isSvcPhpInstalled: Boolean;

  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

procedure TfMain.acMinimizeExecute(Sender: TObject);
begin
  tray1.Visible := true;
  self.Hide;
end;

procedure TfMain.acQuitExecute(Sender: TObject);
begin
  tray1.Visible := false;
  Application.Terminate;
end;

procedure TfMain.acRefreshExecute(Sender: TObject);
begin
  fSCM.RebuildServicesList;
  ProcessSCMData;
end;

procedure TfMain.acTrayRestoreExecute(Sender: TObject);
begin
  self.Show;
  tray1.Visible := false;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  fSCM := TServiceManager.Create;
  fSCM.Active := true;
  ProcessSCMData;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  fSCM.Free;
end;

function TfMain.isSvcNginxInstalled: Boolean;
begin

end;

function TfMain.isSvcPhpInstalled: Boolean;
begin

end;

procedure TfMain.ProcessSCMData;
begin
  lanjut...
end;

procedure TfMain.tray1DblClick(Sender: TObject);
begin
  acTrayRestore.Execute;
end;

end.
