<p align="center">
      <img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/manager/wingp-logo.png?raw=true">	
  
<br>
  <b>Wingp</b> is a mix of Windows, Nginx, PHP (FastCGI) Stack for PHP Developer on Windows.
</p>


# Download
Latest release can be downloaded from [https://github.com/AndanTeknomedia/wingp/releases/latest](https://github.com/AndanTeknomedia/wingp/releases/latest).

Or you can clone the project and run from there
```bash
C:\App>git clone https://github.com/AndanTeknomedia/wingp.git
```

To build Wingp Stack Manager, go [here](#building-from-source)

# Installation

Go to Wingp main directory and run **wingpstack.exe**

Follow [usage manual](#usage-manual) for more information on how to use it.

**wingpstack.exe** must be run with under administrator privilege to be able to deal Windows with *hosts* file.

# Features

- Installing and Managing Nginx Service
- Installing and Managing PHP (FastCGI) Service
- Creating and Managing Virtual Hosts

## Screenshots

<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Main-Window.png?raw=true">
	<br>Wingp Stack Manager Main Window
</p>
<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Serving.png?raw=true">
	<br>Wingp Stack Manager Serving Nginx and PHP
</p>
<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Creating-New-Virtual-Host.png?raw=true">
	<br>Wingp Virtual Host Creation
</p>
<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Virtual-Host-Up-and-Running.png?raw=true">
	<br>Wingp With Nginx Serving Virtual Host
</p>
<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-coolme.io.png?raw=true">
	<br>Virtual Host Served On Wingp
</p>
<p align="center">
	<img alt="Wingp" height="250" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Status-Tray-Icon.png?raw=true">
	<br>Wingp Sistem Tray Status
</p>		

# Usage Manual

## Installing and Controlling Services

Wingp uses [WinSW (Windows Service Wrapper)](https://github.com/winsw/winsw) to install and manage services. At first services installation (both Nginx and PHP), Wingp copies `.\WinSW.exe` to `.\daemon\php` directory and `.daemon\nginx` directory generate WinSW configuration XML file in both directories: `svc-nginx.xml` and `svc-php.xml` for Nginx and PHP, respectively.

### Nginx Service

- To install Nginx service, click on menu Nginx &raquo; Install Nginx.
- To start Nginx service, click on menu Nginx &raquo; Start Nginx.
- To stop Nginx service, click on menu Nginx &raquo; Stop Nginx.
- To Uninstall Nginx service, click on menu Nginx &raquo; Uninstall Nginx. Nginx service must be stopped first.
### PHP Service

- To install Nginx service, click on menu PHP &raquo; Install PHP.
- To start PHP service, click on menu PHP &raquo; Start PHP.
- To stop PHP service, click on menu PHP &raquo; Stop PHP.
- To Uninstall PHP service, click on menu PHP &raquo; Uninstall PHP. PHP service must be stopped first.


## Updating Nginx and PHP

Wingp comes with **nginx-1.26.2 for Windows** and **PHP-7.4.32 (x64, thread safe)** included.
In case you want to update them, follow instructions below.

### Updating Nginx


To update Nginx:

- Stop and then uninstall Nginx service.
- Delete the content of Nginx directory (i.e. `.\daemon\nginx-1.26.2`).
- Extract and copy new Nginx files into the directory.
- Edit Nginx configuration file `.\daemon\nginx-1.26.2\conf\nginx.conf` and this following line after default server block: `include ../../../vhosts/nginx-*.conf;`
- Re-Install Nginx service.

### Updating PHP

To update PHP:

- Stop and then uninstall PHP service.
- Delete the content of php directory (i.e. `.\daemon\php`).
- Extract and copy new PHP files into the directory.
- Duplicate `php.ini-production` and rename the copy to `php.ini` and edit it as necessary.
- Re-Install PHP service.

## Updating The Stack Manager

To update the stack manager, i.e. **wingpstack.exe** just obtain this file [here]("https://github.com/AndanTeknomedia/wingp/blob/main/wingpstack.exe?raw=true) and overwrite the existing one &mdash; close it if running.

## Managing VHosts

### Adding VHost

### Deleting VHost

### Editing VHost

## Tray Icon

Use menu Manager &raquo; Minimize To Tray to hide main window and continue running on Windows sistem tray.
<p align="center">
<img alt="Wingp" height="150" 
	src="https://github.com/AndanTeknomedia/wingp/blob/main/screenshots/Wingp-Stack-Manager-Status-Tray-Icon.png?raw=true">
</p>
To restore the main window, right click on the tray icon and click Restore.

:exclamation: Closing the main window will quit the application.

## Advanced Topic

### Manually Edit Virtual Host Configuration File

### Editing Nginx Configuration File

Please follow official documentation [here](https://nginx.org/en/docs/beginners_guide.html#conf_structure).

Wingp needs this line in Nginx server block to enable virtual hosts:
````
include ../../../vhosts/nginx-*.conf;
````

### Editing PHP Configuration File

Wingp doesn't need any specific configuration in `php.ini` file. Feel free to edit it as necessary. These [directives](https://www.php.net/manual/en/ini.list.php) may help.

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
