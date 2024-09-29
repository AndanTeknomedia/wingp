unit umain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ActnMan,
  Vcl.ActnCtrls, Vcl.ExtCtrls, Vcl.PlatformDefaultStyleActnCtrls,
  System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, System.Threading, System.IOUtils,
  DelphiVault.Windows.ServiceManager, Vcl.Grids, Vcl.ValEdit, Vcl.ButtonGroup,
  Vcl.CategoryButtons, Vcl.Buttons, superObject, Winapi.shellAPi;

const
  VALID_HOSTNAME_CHARS = ['0'..'9', 'a'..'z', 'A'..'Z', '.', '-'];
  VALID_IPV4_CHARS = ['0'..'9', '.'];
  VALID_IPV6_CHARS = ['0'..'9', 'a'..'f', '.'];
  HOSTS_WHITESPACE_CHARS = [' ', #9];
type
  TOnRunExeCallback = TProc<Integer, String>;
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
    vlNginx: TValueListEditor;
    tsVhosts: TTabSheet;
    pmTray: TPopupMenu;
    acTrayRestore: TAction;
    ShowMonitor1: TMenuItem;
    acRefresh: TAction;
    FlowPanel1: TFlowPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Refresh1: TMenuItem;
    vlPHP: TValueListEditor;
    mmNginx: TMemo;
    mmPHP: TMemo;
    FlowPanel2: TFlowPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    lvHosts: TListView;
    acEditVhost: TAction;
    N5: TMenuItem;
    EditvHost1: TMenuItem;
    pmvHosts: TPopupMenu;
    AddvHost1: TMenuItem;
    EditvHost2: TMenuItem;
    DeletevHost1: TMenuItem;
    N6: TMenuItem;
    DeletevHost2: TMenuItem;
    RefreshStatus1: TMenuItem;
    acRefreshvHosts: TAction;
    StatusBar1: TStatusBar;
    N7: TMenuItem;
    miTrayNginx: TMenuItem;
    miTrayPHP: TMenuItem;
    procedure acMinimizeExecute(Sender: TObject);
    procedure acTrayRestoreExecute(Sender: TObject);
    procedure acQuitExecute(Sender: TObject);
    procedure tray1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acInstallNginxExecute(Sender: TObject);
    procedure acUnistallNginxExecute(Sender: TObject);
    procedure acStartNginxExecute(Sender: TObject);
    procedure acStopNginxExecute(Sender: TObject);
    procedure acRestartNginxExecute(Sender: TObject);
    procedure acEditNginxConfExecute(Sender: TObject);
    procedure acInstallPHPExecute(Sender: TObject);
    procedure acUninstallPHPExecute(Sender: TObject);
    procedure acStartPHPExecute(Sender: TObject);
    procedure acStopPHPExecute(Sender: TObject);
    procedure acRestartPHPExecute(Sender: TObject);
    procedure acEditPHPIniExecute(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure acRefreshvHostsExecute(Sender: TObject);
    procedure acAddVHostExecute(Sender: TObject);
    procedure acDeleteVHostsExecute(Sender: TObject);
    procedure acEditVhostExecute(Sender: TObject);
    procedure acEditHostsFileExecute(Sender: TObject);
  private
    { Private declarations }
    RunAsAdmin: Boolean;
    ivHosts: ISuperObject;
    HostsFilePath,
    vHostsConfigPath,
    NginxBasePath,
    PhpBasePath,
    svcNameNginx,
    svcNamePHP: String;
    SvcNginx,
    SvcPhp: TServiceInfo;

    fSCM: TServiceManager;

    procedure ProcessSCMData;

    function  FindService(aSvcId: String): TServiceInfo;
    procedure RestartService(aService : TServiceInfo);
    procedure UpdateNginxUiState(const Installed: Boolean; const AState: TServiceState);
    procedure UpdatePhpUiState(const Installed: Boolean; const AState: TServiceState);

    function  isSvcNginxInstalled: Boolean;
    function  isSvcPhpInstalled: Boolean;

    procedure RunExe(CommandLine, Params: string; OnDone: TOnRunExeCallback = nil);
    function  FindBasePath: Boolean;
    function  UpdateSvcWrapper: Boolean;
    function  FindHostsFilePath: String;
    function  TempFileName: String;
    procedure EnumVHosts;
    procedure PopulateVhostsUI;
    procedure BuildHostFile(aHost: ISuperObject; target: TStringList);
    function  BuildIndexFileContent(Ahost: ISuperObject; target: TstringList):String;
    function  createVhost(aHost: ISuperObject): Boolean;
    function  vHostExists(const aHostName: String): Boolean; overload;
    function  vHostExists(aHost: ISuperObject): Boolean; overload;
    procedure AddToHostsFile(aHost: ISuperObject);
    procedure RemoveFromHostsFile(aHost: ISuperObject);
    procedure FlushDNS;
    procedure UpdateStatusBar(aText: STring);
    procedure DoDeleteVhost(aHost: ISuperObject);
    procedure RemoveDirRecursively(const ADir: String);
    //
    procedure RunCmd(const ACommand: string);

    procedure DisableAllInput;
    procedure RestoreAllInput;

  public
    { Public declarations }

  end;

var
  
  fMain: TfMain;

function IsUserAnAdmin(): BOOL; external shell32;

implementation

{$R *.dfm}

uses uInputVhost, uvhostOption, uvhostDeleteOption;

procedure TfMain.acAddVHostExecute(Sender: TObject);
var
  iHost: ISuperObject;
  f: TFInputVhost;
  vOptions: THostCreationOptions;
  Task: ITask;
  ss: TStringList;
  hostName: string;
begin
  f := TFInputVhost.Create(Application);
  try
    iHost := f.New();
    if iHost.B['ok'] then
    begin
      if vHostExists(iHost) then
      begin
        MessageDlg('Host name already exists!', mtError, [mbOK], 0);
      end
      else
      begin
        iHost.Delete('OK');
        if createVhost(iHost) then
        begin
          ivHosts.A['vhosts'].Add(ihost{.Clone()});
          ss := TStringList.Create;
          try
            ss.Text := ivHosts.AsJSon(true);
            ss.SaveToFile(vHostsConfigPath);
          finally
            ss.Free;
          end;
          //
          vOptions := [scoReloadNginx, scoOpenDefaultPage];
          if GetvHostOptions(vOptions) then
          begin
            // update hosts file
            if iHost.B['updateHostsFile'] then
            begin
              AddToHostsFile(iHost);
              FlushDNS();
            end;
            // reload nginx
            if scoReloadNginx in vOptions then
            begin
              SvcNginx := FindService(svcNameNginx);
              if svcNginx <> nil then
              begin
                if SvcNginx.State = ssRunning then
                begin
                  hostName := iHost.S['name'];
                  task := TTask.Create(procedure
                  begin
                    RestartService(SvcNginx);
                    TThread.Synchronize(TThread.Current, procedure
                    begin
                      ProcessSCMData();
                      // open default page
                      if scoOpenDefaultPage in vOptions then
                      begin
                        ShellExecute(HWND_DESKTOP, 'open', PChar('http://'+HostName), nil, nil, SW_SHOWMAXIMIZED);
                      end;
                    end);
                  end);
                  task.start();
                end;
              end;
            end;
            //
          end;
          //
        end
        else
        begin
          MessageDlg('Cannot create vHost', mtError, [mbOK],0);
        end;
      end;
    end;
    PopulateVhostsUI;
  finally
    f.Free;
  end;
end;

procedure TfMain.acDeleteVHostsExecute(Sender: TObject);
var
  iHost: ISuperObject;
  aName: string;
  i:integer;
  found: Boolean;
  ss: TStringList;
begin
  if lvHosts.Items.Count=0 then
  begin
    MessageDlg('No vHost defined.', mtError, [mbOK],0);
    exit;
  end;
  if lvHosts.SelCount = 0 then
  begin
    MessageDlg('No vHost selected.', mtError, [mbOK],0);
    exit;
  end;
  aName := LowerCase(lvHosts.Selected.Caption);
  found:= false;
  for i := ivHosts.A['vhosts'].Length-1 downto 0 do
  begin
    if aName = LowerCase(ivHosts.A['vhosts'].O[i].S['name']) then
    begin
      iHost := ivHosts.A['vhosts'].O[i];
      DoDeleteVhost(iHost);
      ivHosts.A['vhosts'].Delete(i);
      ss := TStringList.Create;
      try
        ss.Text := ivHosts.AsJSon(true);
        ss.SaveToFile(vHostsConfigPath);
        PopulateVhostsUI();
      finally
        ss.Free;
      end;
      found := true;
      break;
    end;
  end;
end;

procedure TfMain.acEditHostsFileExecute(Sender: TObject);
var
  sei: TShellExecuteInfo;
  runPath,
  tmpFile,
  params: string;
  i: integer;
  ExitCode: Dword;
begin
  runPath := ExtractFilePath(Application.ExeName)+'Notepad2.exe';
  if not FileExists(runPath) then
  begin
    runPath := ExtractFileDir(HostsFilePath);
    runPath := ExtractFileDir(runPath);
    runPath := ExtractFilePath(runPath) +'notepad.exe';
  end;
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_NOCLOSEPROCESS or
    SEE_MASK_FLAG_DDEWAIT or
    SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PChar(runPath);
  sei.lpParameters := PChar(HostsFilePath);
  sei.nShow := SW_SHOWNORMAL;
  ShellExecuteEx(@sei);
end;

procedure TfMain.acEditNginxConfExecute(Sender: TObject);
var
  sei: TShellExecuteInfo;
  runPath,
  tmpFile,
  params: string;
  i: integer;
  ExitCode: Dword;
begin
  runPath := ExtractFilePath(Application.ExeName)+'Notepad2.exe';
  if not FileExists(runPath) then
  begin
    runPath := ExtractFileDir(HostsFilePath);
    runPath := ExtractFileDir(runPath);
    runPath := ExtractFilePath(runPath) +'notepad.exe';
  end;
  params := IncludeTrailingPathDelimiter(NginxBasePath)+
    'conf'+PathDelim+'nginx.conf';

  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_NOCLOSEPROCESS or
    SEE_MASK_FLAG_DDEWAIT or
    SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PChar(runPath);
  sei.lpParameters := PChar(params);
  sei.nShow := SW_SHOWNORMAL;
  ShellExecuteEx(@sei);
end;

procedure TfMain.acEditPHPIniExecute(Sender: TObject);
var
  sei: TShellExecuteInfo;
  runPath,
  tmpFile,
  params: string;
  i: integer;
  ExitCode: Dword;
begin
  runPath := ExtractFilePath(Application.ExeName)+'Notepad2.exe';
  if not FileExists(runPath) then
  begin
    runPath := ExtractFileDir(HostsFilePath);
    runPath := ExtractFileDir(runPath);
    runPath := ExtractFilePath(runPath) +'notepad.exe';
  end;
  params := IncludeTrailingPathDelimiter(PhpBasePath)+
    PathDelim+vlPHP.Values['php.ini File'];

  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_NOCLOSEPROCESS or
    SEE_MASK_FLAG_DDEWAIT or
    SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PChar(runPath);
  sei.lpParameters := PChar(params);
  sei.nShow := SW_SHOWNORMAL;
  ShellExecuteEx(@sei);
end;

procedure TfMain.acEditVhostExecute(Sender: TObject);
begin
  //
end;

procedure TfMain.acInstallNginxExecute(Sender: TObject);
var
  nginxPath: String;
  ss: TStringList;
begin
  //
  SvcNginx := FindService(svcNameNginx);
  if svcNginx <> nil then
  begin
    MessageDlg('Service already installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  nginxPath := IncludeTrailingPathDelimiter(NginxBasePath)+'svc-nginx.exe';

  ss := TStringList.Create;
  try
    ss.Add('<service>');
    ss.Add(format('  <id>%s</id>', [svcNameNginx]));
    ss.Add(format('  <name>%s</name>', [vlNginx.Values['Service Display Name']]));
    ss.Add(format('  <description>%s</description>', [vlNginx.Values['Service Description']]));
    ss.Add('  <!-- Path to the executable, which should be started -->');
    ss.Add('  <executable>%BASE%\nginx.exe</executable>');
    ss.Add('  <stopexecutable>C:\Windows\system32\taskkill.exe</stopexecutable>');
    ss.Add('  <stopargument>/f</stopargument>');
    ss.Add('  <stopargument>/IM</stopargument>');
    ss.Add('  <stopargument>nginx.exe</stopargument>');
    ss.Add('  <logpath>%BASE%\nginx-logs</logpath>');
    ss.Add('  <logmode>roll</logmode>');
    ss.Add('</service>');

    ss.SaveToFile(IncludeTrailingPathDelimiter(NginxBasePath)+'svc-nginx.xml');

    RunExe(nginxPath, 'install', procedure(code: Integer; status: string)
    begin
      MessageDlg('Service installation: '+status, mtInformation, [mbOK], 0);
      ProcessSCMData();
    end);
  finally
    ss.Free;
  end;
end;

procedure TfMain.acInstallPHPExecute(Sender: TObject);
var
  phpExe, svcExe: String;
  configs: String;
  ss: TStringList;
begin
  //
  SvcPhp := FindService(svcNamePHP);
  if SvcPhp <> nil then
  begin
    MessageDlg('Service already installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  phpExe := 'php-cgi.exe';
  svcExe := IncludeTrailingPathDelimiter(PhpBasePath)+'svc-php.exe';
  configs := mmPHP.Text;
  configs := configs.Replace('%svcname%', svcNamePHP);
  configs := configs.Replace('%displayname%', vlPHP.Values['Service Display Name']);
  configs := configs.Replace('%description%', vlPHP.Values['Service Description']);
  configs := configs.Replace('%exepath%', '%BASE%');
  configs := configs.Replace('%exename%', phpExe);
  configs := configs.Replace('%port%', vlPHP.Values['fCGI Gateway Port']);
  configs := configs.Replace('-c%php.ini%', '-c%BASE%\'+vlPHP.Values['php.ini File']);

  ss := TStringList.Create;
  try
    ss.Text := configs;
    ss.SaveToFile(IncludeTrailingPathDelimiter(PhpBasePath)+'svc-php.xml');
    RunExe(svcExe, 'install', procedure(code: Integer; status: string)
    begin
      MessageDlg('Service installation: '+status, mtInformation, [mbOK], 0);
      ProcessSCMData();
    end);
  finally
    ss.Free;
  end;
end;

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
  ProcessSCMData;
end;

procedure TfMain.acRefreshvHostsExecute(Sender: TObject);
begin
  EnumVHosts;
  PopulateVhostsUI;
end;

procedure TfMain.acRestartNginxExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcNginx := FindService(svcNameNginx);
  if svcNginx = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcNginx.ServiceStop(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
    SvcNginx.ServiceStart(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acRestartPHPExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcPhp := FindService(svcNamePHP);
  if SvcPhp = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcPhp.ServiceStop(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
    SvcPhp.ServiceStart(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acStartNginxExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcNginx := FindService(svcNameNginx);
  if svcNginx = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcNginx.ServiceStart(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acStartPHPExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcPhp := FindService(svcNamePHP);
  if SvcPhp = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcPhp.ServiceStart(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acStopNginxExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcNginx := FindService(svcNameNginx);
  if svcNginx = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcNginx.ServiceStop(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acStopPHPExecute(Sender: TObject);
var
  task: ITask;
begin
  SvcPhp := FindService(svcNamePHP);
  if SvcPhp = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  task := TTask.Create(procedure
  begin
    SvcPhp.ServiceStop(true);
    TThread.Synchronize(TThread.Current, procedure
    begin
      ProcessSCMData();
    end);
  end);
  task.start();
end;

procedure TfMain.acTrayRestoreExecute(Sender: TObject);
begin
  self.Show;
  tray1.Visible := false;
end;

procedure TfMain.acUninstallPHPExecute(Sender: TObject);
var
  sPath: String;
begin
  //
  SvcPhp := FindService(svcNamePHP);
  if SvcPhp = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  sPath := IncludeTrailingPathDelimiter(PhpBasePath)+'svc-php.exe';
  RunExe(sPath, 'uninstall', procedure(code: Integer; status: string)
  begin
    MessageDlg('Service uninstallation: '+status, mtInformation, [mbOK], 0);
    ProcessSCMData();
  end);
end;

procedure TfMain.acUnistallNginxExecute(Sender: TObject);
var
  nginxPath: String;
begin
  //
  SvcNginx := FindService(svcNameNginx);
  if svcNginx = nil then
  begin
    MessageDlg('Service not installed.', mtWarning, [mbOK], 0);
    exit;
  end;
  //
  nginxPath := IncludeTrailingPathDelimiter(NginxBasePath)+'svc-nginx.exe';
  RunExe(nginxPath, 'uninstall', procedure(code: Integer; status: string)
  begin
    MessageDlg('Service uninstallation: '+status, mtInformation, [mbOK], 0);
    ProcessSCMData();
  end);
end;

procedure TfMain.BuildHostFile(aHost: ISuperObject; target: TStringList);
begin
  target.Clear;
  target.Add('server {');
  //
  target.Add(format('  listen %d;',[aHost.I['port']]));
  if Ahost.S['port443'] = 'yes' then
    target.Add(format('  listen %d;',[443]));
  if Ahost.S['ipv6'] = 'yes' then
  begin
    target.Add(format('  listen [::]:%d;',[aHost.I['port']]));
    if Ahost.S['port443'] = 'yes' then
      target.Add(format('  listen [::]:%d;',[443]));
  end;
  target.Add('  # ssl_certificate      /usr/local/etc/nginx/ssl/{{host}}.crt;');
  target.Add('  # ssl_certificate_key  /usr/local/etc/nginx/ssl/{{host}}.key;');
  target.Add('  # ssl_ciphers          HIGH:!aNULL:!MD5;');
  // ----
  if ahost.A['alias'].Length = 0 then
    target.Add(format('  server_name %s;', [ahost.S['name']]))
  else
    target.Add(format('  server_name %s %s;', [ahost.S['name'], ahost.A['alias'].S[0]]));

  target.Add('  #document root, relative path doesn''t work!');
  target.Add(format('  root %s;',[aHost.S['root']]));

  target.Add('  add_header X-Frame-Options "SAMEORIGIN";');
  target.Add('  add_header X-XSS-Protection "1; mode=block";');

  if aHost.S['usePhp'] = 'yes' then
  begin
    target.Add('  index index.html index.htm index.php;');
  end
  else
  begin
    target.Add('  index index.html index.htm;');
  end;

  target.Add('  charset utf-8;');

  target.Add('  location = /favicon.ico { access_log off; log_not_found off; }');
  target.Add('  location = /robots.txt  { access_log off; log_not_found off; }');

  target.Add('  #access_log off;');

  if aHost.S['usePhp'] = 'yes' then
  begin
    target.Add('  location / {');
    target.Add('    try_files $uri $uri/ /index.php?$query_string;');
    target.Add('  }');
  end
  else
  begin
    target.Add('  location / {');
    target.Add('    try_files $uri $uri/ =404;');
    target.Add('  }');
  end;

  target.Add('  #PHP Only!');
  target.Add('  #error_page 404 /index.php;');

  // PHP fCGI Params:
  if aHost.S['usePhp'] = 'yes' then
  begin
    target.Add('  location ~ \.php$ {');
    target.Add('    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;');
    target.Add('    fastcgi_split_path_info ^(.+\.php)(/.+)$;');
    target.Add(format('    fastcgi_pass 127.0.0.1:%s;', [vlPHP.Values['fCGI Gateway Port']]));
    target.Add('    fastcgi_index index.php;');
    target.Add('    include fastcgi.conf;');
    target.Add('  }');
  end;
  target.Add('  #protect Apache config files:');
  target.Add('  location ~ /\.(?!well-known).* {');
  target.Add('    deny all;');
  target.Add('  }');
  //
  target.Add('}');
end;

function TfMain.BuildIndexFileContent(Ahost: ISuperObject; target: TstringList): String;
begin
  Target.Clear;
  if aHost.S['usePhp'] = 'yes' then
  begin
    Target.add('<?php');
    Target.add('echo "<h1>Welcome To '+Ahost.S['name']+'</h1>";');
    Target.add('?>');
  end
  else
  begin
    Target.add('<h1>Welcome To '+Ahost.S['name']+'</h1>');
  end;
end;

function TfMain.createVhost(aHost: ISuperObject): Boolean;
var
  vhostContent,
  indexCOntent: TStringList;
  rootDir,
  vhostFile,
  indexFile: String;
begin
  Result := false;
  vhostContent := TStringList.Create;
  try
    indexCOntent := TStringList.Create;
    try
      BuildHostFile(Ahost, vhostContent);
      BuildIndexFileContent(aHost, indexCOntent);
      rootDir := aHost.S['root'];
      rootDir := rootDir.Replace('/','\');
      if not DirectoryExists(rootDir) then
        ForceDirectories(rootDir);
      // create index file:
      if aHost.S['usePhp'] = 'yes' then
        indexFile := IncludeTrailingPathDelimiter(rootDir)+'index.php'
      else
        indexFile := IncludeTrailingPathDelimiter(rootDir)+'index.html';
      if FileExists(indexFile) then
      begin
        if MessageDlg('Index file "'+indexFile+'" already exists.'#13'Overwrite?', mtConfirmation,mbYesNo,0) = mrYes then
        begin
          DeleteFile(indexFile);
          indexCOntent.SaveToFile(indexFile);
        end;
      end
      else
      begin
        indexCOntent.SaveToFile(indexFile);
      end;
      // create vhost file:
      vhostFile := format('nginx-%s.conf', [ahost.S['name']]);
      vhostFile := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+ 'vhosts')+
        vhostFile;
      //save and overwrite:
      DeleteFile(vhostFile);
      vhostContent.SaveToFile(vhostFile);

      Result := true;
    finally
      indexCOntent.Free;
    end;
  finally
    vhostContent.Free;
  end;
end;

procedure TfMain.DisableAllInput;
var
  i: integer;
begin
  for i := 0 to ActionManager1.ActionCount-1 do
  begin
    ActionManager1.Actions[i].Tag := Integer(ActionManager1.Actions[i].Enabled);
    ActionManager1.Actions[i].Enabled := false;
  end;
end;

procedure TfMain.DoDeleteVhost(aHost: ISuperObject);
var
  opts: THostDeleteOptions;
  hostName,
  vHostFile: string;
  RootDir: String;
begin
  opts := [sdoReloadNginx];
  hostName := aHost.S['name'];
  RootDir := aHost.S['root'];
  RootDir := RootDir.Replace('/','\');
  if GetvHostDeleteOptions(opts) then
  begin
    // delete vhosts config
    vHostFile := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+ 'vhosts')+
      format('nginx-%s.conf', [hostName]);
    if FileExists(vHostFile) then
      DeleteFile(vHostFile);
    // remoe entries from hosts file
    if sdoUpdateHostsFile in opts then
    begin
      RemoveFromHostsFile(aHost);
    end;
    // restart nginx:
    if sdoReloadNginx in opts then
    begin
      SvcNginx := FindService(svcNameNginx);
      if svcNginx <> nil then
      begin
        if SvcNginx.State = ssRunning then
        begin
          TTask.Create(procedure
          begin
            RestartService(SvcNginx);
            TThread.Synchronize(TThread.Current, procedure
            begin
              ProcessSCMData();
            end);
          end).start();
        end;
      end;
    end;
    // attempt to remove root dir while Nginx is stopped:
    if sdoRemoveRootDir in opts then
    begin
      RemoveDirRecursively(RootDir);
      // RunCmd(Format('rmdir /s /q "%s"', [RootDir]));
    end;
  end;
end;

procedure TfMain.EnumVHosts;
var
  ss: TStringList;
begin
  if not FileExists(vHostsConfigPath) then
  begin
    ivHosts := so;
    ivHosts.ForcePath('vhosts', stArray);
  end
  else
  begin
    ss := TStringList.Create;
    try
      ss.LoadFromFile(vHostsConfigPath);
      if (ss.Count = 0) or (ss.Text = '') then
        ivHosts := SO
      else
        ivHosts := SO(ss.Text);
      ivHosts.ForcePath('vhosts', stArray);
    finally
      ss.Free;
    end;
  end;
end;

function TfMain.FindBasePath: Boolean;
var
  sr: TSearchRec;
  pth, base: string;
begin
  Result := false;
  base := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+'daemon');
  if FindFirst(
    base+'*.*',
    faDirectory,
    sr
  ) = 0 then
  begin
    repeat
      pth := sr.Name;
      if not pth.StartsWith('.') then
      begin
        pth := base + pth;
        if FileExists(pth+'\nginx.exe') then
        begin
          NginxBasePath := pth;
          continue;
        end;
        if FileExists(pth+'\php-cgi.exe') then
        begin
          PhpBasePath := pth;
          continue;
        end;
      end;
    until FindNext(sr)<>0;
    FindClose(sr);
  end;
  Result := DirectoryExists(NginxBasePath) and DirectoryExists(PhpBasePath);
end;

function TfMain.FindHostsFilePath: String;
var
  p: PChar;
begin
  GetMem(p, MAX_PATH+1);
  GetSystemDirectory(p, MAX_PATH);
  Result := string(p);
  Result := TPath.Combine(Result, 'Drivers');
  Result := TPath.Combine(Result, 'etc');
  Result := TPath.Combine(Result, 'hosts');
  FreeMem(p, MAX_PATH+1);
end;

function TfMain.FindService(aSvcId: String): TServiceInfo;
var
  i: integer;
  si: TServiceInfo;
begin
  Result := nil;
  for i := 0 to fSCM.ServiceCount-1 do
  begin
    si := fSCM.Services[i];
    if LowerCase(si.ServiceName) = LowerCase(aSvcId) then
    begin
      Result := si;
      Break;
    end;
  end;
end;

procedure TfMain.FlushDNS;
begin
  // TTask.Create(procedure
  begin
    WinExec('ipconfig /flushdns', SW_HIDE);
    Sleep(500);
  end
  //).start();
end;

procedure TfMain.FormCreate(Sender: TObject);
begin
  RunAsAdmin := IsUserAnAdmin();
  if RunAsAdmin then
    UpdateStatusBar('This program is running under Administrator privilege.')
  else
    UpdateStatusBar('Better run this program under Administrator privilege.')
  ;
  PageControl1.ActivePage := tsNginx;
  vHostsConfigPath:=
    IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)+'vhosts') +
    'vhosts.conf';
  FindBasePath();
  UpdateSvcWrapper();
  HostsFilePath := FindHostsFilePath();
  fSCM := TServiceManager.Create;
  fSCM.Active := true;
  // ShowMessage(NginxBasePath + #13 + PhpBasePath);
  acRefreshvHosts.Execute;
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

procedure TfMain.PopulateVhostsUI;
var
  iHost: ISuperObject;
  alias, a: string;
  i: integer;
  li: TListItem;
begin
  lvHosts.Items.BeginUpdate;
  try
    lvHosts.Items.Clear;
    for iHost in ivHosts.A['vhosts'] do
    begin
      li := lvHosts.Items.Add;
      li.Caption := iHost.S['name'];
      // alias
      alias := '';
      for i := 0 to iHost.A['alias'].Length-1 do
        alias := alias + ', '+iHost.A['alias'].S[i];
      if alias<>'' then
        delete(alias,1,2);
      li.SubItems.Add(alias);
      // root
      li.SubItems.Add(iHost.S['root']);
      // port
      alias := IntToStr(iHost.I['port']);
      if iHost.S['port443'] = 'yes' then
        alias := alias + ', 443';
      li.SubItems.Add(alias);
      // php
      li.SubItems.Add(iHost.S['usePhp']);
    end;
  finally
    lvHosts.Items.EndUpdate;
  end;
end;

procedure TfMain.ProcessSCMData;
begin
  fSCM.RebuildServicesList;
  // --
  svcNameNginx := vlNginx.Values['Service Name'];
  SvcNginx:= FindService(svcNameNginx);
  if SvcNginx = nil then
  begin
    UpdateNginxUiState(false, ssStopped);
  end
  else
  begin
    UpdateNginxUiState(true, SvcNginx.State)
  end;
  //--
  svcNamePHP := vlPHP.Values['Service Name'];
  SvcPhp:= FindService(svcNamePHP);
  if SvcPhp = nil then
  begin
    UpdatePhpUiState(false, ssStopped);
  end
  else
  begin
    UpdatePhpUiState(true, SvcPhp.State)
  end;
end;

procedure TfMain.RemoveDirRecursively(const ADir: String);
var
  ShOp: TSHFileOpStruct;
begin
  ShOp.Wnd := Self.Handle;
  ShOp.wFunc := FO_DELETE;
  ShOp.pFrom := PChar(ADir);
  ShOp.pTo := nil;
  ShOp.fFlags := FOF_NOCONFIRMATION {FOF_NO_UI};
  SHFileOperation(ShOp);
end;

procedure TfMain.RemoveFromHostsFile(aHost: ISuperObject);
var
  sei: TShellExecuteInfo;
  runPath,
  tmpFile,
  params: string;
  i: integer;
  ExitCode: Dword;
  EntriesRemove: TStringList;
begin
  runPath := ExtractFilePath(Application.ExeName)+'hostsedit.exe';
  if not FileExists(runPath) then
  begin
    MessageDlg('Cannot update hosts file.'#13+'"'+runpath+'" does not exists.', mtError, [mbOK],0);
  end
  else
  begin
    EntriesRemove := TStringList.Create;
    try
      EntriesRemove.Add(aHost.S['name']);
      for i := 0 to aHost.A['alias'].Length-1 do
      begin
        EntriesRemove.Add(aHost.A['alias'].S[i]);
      end;
      // remove
      tmpFile := TempFileName();
      EntriesRemove.SaveToFile(tmpFile);
      params := format('/rm "%s"', [tmpfile]);
      FillChar(sei, SizeOf(sei), 0);
      sei.cbSize := SizeOf(sei);
      sei.Wnd := Handle;
      sei.fMask := SEE_MASK_NOCLOSEPROCESS or
        SEE_MASK_FLAG_DDEWAIT or
        SEE_MASK_FLAG_NO_UI;
      sei.lpVerb := 'runas';
      sei.lpFile := PChar(runPath);
      sei.lpParameters := PChar(params);
      sei.nShow := SW_HIDE;

      if ShellExecuteEx(@sei) then
      begin
        repeat
          GetExitCodeProcess(sei.hProcess, ExitCode);
        until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
        DeleteFile(tmpFile);
        // add them back:
      end
      else
      begin
        RaiseLastOSError();
      end;
    finally
      EntriesRemove.Free;
    end;
  end;
end;

procedure TfMain.RestartService(aService: TServiceInfo);
begin
  aService.ServiceStop(true);
  aService.ServiceStart(true);
end;

procedure TfMain.RestoreAllInput;
var
  i: integer;
begin
  for i := 0 to ActionManager1.ActionCount-1 do
  begin
    ActionManager1.Actions[i].Enabled := Boolean(ActionManager1.Actions[i].Tag);
  end;
end;

procedure TfMain.RunCmd(const ACommand: string);
var
  sei: TShellExecuteInfo;
  sysDir: String;
  p:PChar;
  ExitCode: Dword;
begin
  GetMem(p, MAX_PATH+1);
  GetSystemDirectory(p, MAX_PATH);
  sysDir := string(p);
  FreeMem(p, MAX_PATH+1);
  sysDir := IncludeTrailingPathDelimiter(sysdir)+'cmd.exe';
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.Wnd := Handle;
  sei.fMask := SEE_MASK_NOCLOSEPROCESS or
    SEE_MASK_FLAG_DDEWAIT or
    SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := 'runas';
  sei.lpFile := PChar(sysDir);
  sei.lpParameters := PChar(ACommand);
  sei.nShow := SW_HIDE;
  if ShellExecuteEx(@sei) then
  begin
    repeat
      GetExitCodeProcess(sei.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
  end;
end;

procedure TfMain.RunExe(CommandLine, Params: string; OnDone: TOnRunExeCallback = nil);
var
  WorkDir: string;
  Parameter: PChar;
  Task: ITask;
begin
  if not FileExists(CommandLine) then
  begin
    OnDone(1, 'Path not found');
    exit;
  end;
  WorkDir :=  ExtractFileDir(CommandLine);
  Parameter := PChar('"'+CommandLine + '" '+Params);

  Task := TTask.Create(procedure
  var
    SA: TSecurityAttributes;
    SI: TStartupInfo;
    PI: TProcessInformation;
    StdOutPipeRead,  StdOutPipeWrite: THandle;
    Handle:  Boolean;
  begin
    with SA do
    begin
      nLength :=  SizeOf(SA);
      bInheritHandle := True;
      lpSecurityDescriptor :=  nil;
    end;
    CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
    try
      with SI do
      begin
        FillChar(SI, SizeOf(SI),  0);
        cb := SizeOf(SI);
        dwFlags := STARTF_USESHOWWINDOW or  STARTF_USESTDHANDLES;
        wShowWindow := SW_HIDE;
        hStdInput :=  GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
        hStdOutput :=  StdOutPipeWrite;
        hStdError := StdOutPipeWrite;
      end;
      try
        Handle :=  CreateProcess(nil{PChar( CommandLine )},  Parameter,
          nil, nil, True, 0,  nil,
          PChar(WorkDir), SI, PI);
        if Handle then
        begin
          try
            WaitForSingleObject(pi.hProcess, INFINITE);
          finally
            CloseHandle(PI.hThread);
            CloseHandle(PI.hProcess);
          end;
          TThread.Synchronize(TThread.Current, procedure
          begin
            OnDone(0, 'Done');
          end);
        end
        else
        begin
          TThread.Synchronize(TThread.Current, procedure
          begin
            OnDone(2, 'Cannot create process');
          end);
        end;
      Except on e: exception do
        TThread.Synchronize(TThread.Current, procedure
        begin
          OnDone(3, e.Message);
        end);
      end;
    finally
      CloseHandle(StdOutPipeRead);
    end;
    {
    TThread.Synchronize(TThread.Current, procedure
    begin

    end);
    }
  end);
  Task.Start;
end;

procedure TfMain.SpeedButton13Click(Sender: TObject);
begin
  //
end;

procedure TfMain.SpeedButton14Click(Sender: TObject);
begin
  //
end;

procedure TfMain.SpeedButton15Click(Sender: TObject);
begin
  //
end;

procedure TfMain.SpeedButton18Click(Sender: TObject);
begin
  //
end;

function TfMain.TempFileName: String;
var
  pPath, pName: PChar;
  tmpPath: String;
begin
  GetMem(pPath, MAX_PATH+1);
  GetTempPath(MAX_PATH, pPath);
  tmpPath:= string(pPath);
  FreeMem(pPath);
  Result := IncludeTrailingPathDelimiter(tmpPath)+'tmp-'+
    IntToStr(Random(MaxInt))+'~'+
    IntToStr(Random(MaxInt))+'.tmp';
end;

procedure TfMain.tray1DblClick(Sender: TObject);
begin
  acTrayRestore.Execute;
end;

procedure TfMain.AddToHostsFile(aHost: ISuperObject);
var
  sei: TShellExecuteInfo;
  runPath,
  tmpFile,
  params: string;
  i: integer;
  ExitCode: Dword;
  EntriesRemove,
  EntriesAdd: TStringList;
begin
  runPath := ExtractFilePath(Application.ExeName)+'hostsedit.exe';
  if not FileExists(runPath) then
  begin
    MessageDlg('Cannot update hosts file.'#13+'"'+runpath+'" does not exists.', mtError, [mbOK],0);
  end
  else
  begin
    EntriesRemove := TStringList.Create;
    try
      EntriesAdd := TStringList.Create;
      try
        EntriesAdd.Add('127.0.0.1 '+aHost.S['name']);
        EntriesRemove.Add(aHost.S['name']);
        for i := 0 to aHost.A['alias'].Length-1 do
        begin
          EntriesAdd.Add('127.0.0.1 '+aHost.A['alias'].S[i]);
          EntriesRemove.Add(aHost.A['alias'].S[i]);
        end;
        // remove first
        tmpFile := TempFileName();
        EntriesRemove.SaveToFile(tmpFile);
        params := format('/rm "%s"', [tmpfile]);
        FillChar(sei, SizeOf(sei), 0);
        sei.cbSize := SizeOf(sei);
        sei.Wnd := Handle;
        sei.fMask := SEE_MASK_NOCLOSEPROCESS or
          SEE_MASK_FLAG_DDEWAIT or
          SEE_MASK_FLAG_NO_UI;
        sei.lpVerb := 'runas';
        sei.lpFile := PChar(runPath);
        sei.lpParameters := PChar(params);
        sei.nShow := SW_HIDE;

        if ShellExecuteEx(@sei) then
        begin
          repeat
            GetExitCodeProcess(sei.hProcess, ExitCode);
          until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
          DeleteFile(tmpFile);
          // add them back:
          tmpFile := TempFileName();
          EntriesAdd.SaveToFile(tmpFile);
          params := format('/am "%s"', [tmpfile]);
          FillChar(sei, SizeOf(sei), 0);
          sei.cbSize := SizeOf(sei);
          sei.Wnd := Handle;
          sei.fMask := SEE_MASK_NOCLOSEPROCESS or
            SEE_MASK_FLAG_DDEWAIT or
            SEE_MASK_FLAG_NO_UI;
          sei.lpVerb := 'runas';
          sei.lpFile := PChar(runPath);
          sei.lpParameters := PChar(params);
          sei.nShow := SW_HIDE;
          if ShellExecuteEx(@sei) then
          begin
            repeat
              GetExitCodeProcess(sei.hProcess, ExitCode);
            until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
            DeleteFile(tmpFile);
          end
          else
          begin
            RaiseLastOSError();
          end;
        end
        else
        begin
          RaiseLastOSError();
        end;
        //
      finally
        EntriesAdd.Free;
      end;
    finally
      EntriesRemove.Free;
    end;
  end;
end;

procedure TfMain.UpdateNginxUiState(const Installed: Boolean;
  const AState: TServiceState);
begin
  if not Installed then
  begin
    tsNginx.ImageIndex := 0;
    vlNginx.Values['Service Status'] := 'Not Installed';
    acInstallNginx.Enabled := true;
    acUnistallNginx.Enabled := false;
    acStartNginx.Enabled := false;
    acStopNginx.Enabled := false;
    acRestartNginx.Enabled := false;
  end
  else
  begin
    case AState of
      ssStopped:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Stopped';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := true;
        acStartNginx.Enabled := true;
        acStopNginx.Enabled := false;
        acRestartNginx.Enabled := false;
      end;
      ssStartPending:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Start Pending';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := true;
        acRestartNginx.Enabled := false;
      end;
      ssStopPending:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Stop Pending';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := false;
        acRestartNginx.Enabled := false;
      end;
      ssRunning:
      begin
        tsNginx.ImageIndex := 1;
        vlNginx.Values['Service Status'] := 'Running';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := true;
        acRestartNginx.Enabled := true;
      end;
      ssContinuePending:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Continue Pending';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := true;
        acRestartNginx.Enabled := false;
      end;
      ssPausePending:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Pause Pending';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := false;
        acRestartNginx.Enabled := false;
      end;
      ssPaused:
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Paused';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := true;
        acStartNginx.Enabled := true;
        acStopNginx.Enabled := false;
        acRestartNginx.Enabled := false;
      end
      else
      begin
        tsNginx.ImageIndex := 0;
        vlNginx.Values['Service Status'] := 'Waiting...';
        acInstallNginx.Enabled := false;
        acUnistallNginx.Enabled := false;
        acStartNginx.Enabled := false;
        acStopNginx.Enabled := true;
        acRestartNginx.Enabled := false;
      end;
    end;
  end;
  miTrayNginx.ImageIndex := tsNginx.ImageIndex;
  miTrayNginx.Caption := 'Nginx : '+vlNginx.Values['Service Status'];
end;

procedure TfMain.UpdatePhpUiState(const Installed: Boolean;
  const AState: TServiceState);
begin
  if not Installed then
  begin
    tsPHP.ImageIndex := 0;
    vlPHP.Values['Service Status'] := 'Not Installed';
    acInstallPHP.Enabled := true;
    acUninstallPHP.Enabled := false;
    acStartPHP.Enabled := false;
    acStopPHP.Enabled := false;
    acRestartPHP.Enabled := false;
  end
  else
  begin
    case AState of
      ssStopped:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Stopped';
        acInstallPHP.Enabled := false;
        acUninstallPHP.Enabled := true;
        acStartPHP.Enabled := true;
        acStopPHP.Enabled := false;
        acRestartPHP.Enabled := false;
      end;
      ssStartPending:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Start Pending';
        acInstallPHP.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := true;
        acRestartPHP.Enabled := false;
      end;
      ssStopPending:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Stop Pending';
        acInstallphp.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := false;
        acRestartPHP.Enabled := false;
      end;
      ssRunning:
      begin
        tsPHP.ImageIndex := 1;
        vlPHP.Values['Service Status'] := 'Running';
        acInstallphp.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := true;
        acRestartPHP.Enabled := true;
      end;
      ssContinuePending:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Continue Pending';
        acInstallphp.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := true;
        acRestartPHP.Enabled := false;
      end;
      ssPausePending:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Pause Pending';
        acInstallphp.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := false;
        acRestartPHP.Enabled := false;
      end;
      ssPaused:
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Paused';
        acInstallphp.Enabled := false;
        acUninstallPHP.Enabled := true;
        acStartPHP.Enabled := true;
        acStopPHP.Enabled := false;
        acRestartPHP.Enabled := false;
      end
      else
      begin
        tsPHP.ImageIndex := 0;
        vlPHP.Values['Service Status'] := 'Waiting...';
        acInstallNginx.Enabled := false;
        acUninstallPHP.Enabled := false;
        acStartPHP.Enabled := false;
        acStopPHP.Enabled := true;
        acRestartPHP.Enabled := false;
      end;
    end;
  end;
  miTrayPHP.ImageIndex := tsPHP.ImageIndex;
  miTrayPHP.Caption := 'PHP    : '+vlPHP.Values['Service Status'];
end;

procedure TfMain.UpdateStatusBar(aText: STring);
begin
  StatusBar1.Panels[1].Text := aText;
end;

function TfMain.UpdateSvcWrapper: Boolean;
var
  wrFile, wrName: string;
begin
  wrFile := ExtractFilePath(Application.ExeName)+'WinSW.exe';
  wrName := IncludeTrailingPathDelimiter (NginxBasePath)+'svc-nginx.exe';
  if not FileExists(wrName) then
    CopyFile(PChar(wrFile), PChar(wrName), true);
  wrName := IncludeTrailingPathDelimiter (PhpBasePath)+'svc-php.exe';
  if not FileExists(wrName) then
    CopyFile(PChar(wrFile), PChar(wrName), true);
end;

function TfMain.vHostExists(aHost: ISuperObject): Boolean;
begin
  Result := vHostExists(aHost.S['name']);
end;

function TfMain.vHostExists(const aHostName: String): Boolean;
var
  iHost: ISuperObject;
  n: string;
begin
  Result := false;
  n := LowerCase(aHostName);
  for iHost in ivHosts.A['vhosts'] do
  begin
    if n = LowerCase(iHost.S['name']) then
    begin
      Result := true;
      break;
    end;
  end;
end;

end.
