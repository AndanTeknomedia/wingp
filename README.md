<p align="center">
      <img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/manager/wingp-logo.png?raw=true">	
  
<br>
  <b>Wingp</b> is a mix of Windows, Nginx, PHP (FastCGI) Stack for PHP Developer on Windows.
</p>


# Download
Latest release can be downloaded from [https://github.com/AndanTeknomedia/wingp/releases/latest](https://github.com/AndanTeknomedia/wingp/releases/latest).

To Build

# Installation

**wingpstack.exe** must be run with under administrator privilege to be able to deal Windows with *hosts* file.

# Usage Manual

# Features

- Installing and Managing Nginx Service
- Installing and Managing PHP (FastCGI) Service
- Creating and Managing Virtual Hosts

## Screenshots

<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Main-Window.png?raw=true">
	Wingp Stack Manager Main Window
</p>

## Installing and Controlling Services

### Nginx Service

### PHP Service

## Updating Nginx and PHP

### Updating Nginx

### Updating PHP

## Updating The Stack Manager

To update the stack manager, i.e. **wingpstack.exe** just obtain this file [here]("https://github.com/AndanTeknomedia/wingp/blob/main/wingpstack.exe?raw=true) and overwrite the existing one &mdash; close it if running.

## Managing VHosts

### Adding VHost

### Deleting VHost

### Editing VHost

## Advanced Topic

### Manually Edit Virtual Host Configuration File

### Editing Nginx Configuration File

### Editing PHP Configuration File

### Windows *hosts* File

# Windows Firewall

# Uninstallation

**Important!** You may want to copy (backup) your virtual host root directories before uninstalling Wingp.

Follow these steps to uninstall Wingp:

1. On Wingp main window, stop both Nginx and PHP Service &mdash; skip if already stopped. Wait until their statuses changed.

2. Unintstall both services. Wait until their statuses changed to "Not Installed". Check Windows Service Manager to ensure they both removed.

3. Close Wingp and remove `wingp` directory along with its contents.

**You may also wanto to stop and remove Nginx and PHP services manually:**
1. Close Wingp. Then open *Command Prompot* with administative privilege, i.e. Run As Administrator.
2. Navigate to PHP directoy `wingp\daemon\php`.
- Stop PHP service by typing `svc-php stop`
- Remove PHP service by typing `svc-php uninstall` 

2. Navigate to Nginx directoy `wingp\daemon\nginx`.
- Stop Nginx service by typing `svc-Nginx stop`
- Remove Nginx service by typing `svc-Nginx uninstall` 

3. Close the terminal and remove `wingp` directory along with its contents.


# Used Tools

Wingp was build using various tools available. The Wingp Manager (wingp.exe) itself was compiled using Delphi XE8 (with Indy 10). Delphi XE2 and higher versions may also compile, but not yet tested.

- Nginx for Windows &raquo; [https://github.com/nginx/nginx/](https://github.com/nginx/nginx/)
- PHP &raquo; [https://php.net](https://php.net)
- WinSW (Windows Service Wrapper) &raquo; [https://github.com/winsw/winsw](https://github.com/winsw/winsw)
- hostsedit &mdash; Windows hosts file editor &raquo; [https://github.com/OnlyDeLtA/HostsEdit](https://github.com/OnlyDeLtA/HostsEdit)
- Notepad2 &raquo; [https://www.flos-freeware.ch/notepad2.html](https://www.flos-freeware.ch/notepad2.html)

# Used Libraries

- Windows Service Manager for Delphi &raquo; [DelphiVault.Windows.ServiceManager](https://github.com/carmas123/delphi-vault/blob/master/Source/DelphiVault.Windows.ServiceManager.pas)
- SuperObject for Delphi &amp; FPC &raquo; [https://github.com/pult/SuperObject.Delphi](https://github.com/pult/SuperObject.Delphi)

# Building From Source

- Close wingpstack.exe if it is running.
- Open `manager\wingpstack.dproj` in Delphi.
- On Project Manager panel, right click on Release and click Make. Output exe will be placed at Wingp's root directory.
