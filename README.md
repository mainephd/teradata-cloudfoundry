# Python Teradata ODBC Connectivity

## Vendor Dependencies
Run `script/install-dependencies` which will create the below folders in repository directory.

```
vendor/
```
### Teradata ODBC drivers

This project requires that the Teradata drivers be downloaded from [The Teradata Developer Portal](http://downloads.teradata.com/download/connectivity/odbc-driver/linux). Once you have the download you will need to install the driver using a CentOS using the following instructions.

```
mkdir -p /app/install
mkdir -p /app/vendored
yum install -y ksh
mv tdodbc1510__linux_indep.15.10.01.03-1.tar.gz /app/install/
cd /app/install/
tar xf tdodbc1510__linux_indep.15.10.01.03-1.tar.gz
tar xf TeraGSS_linux_x64__linux_indep.15.10.02.08-1.tar.gz
tar xvf tdicu1510__linux_indep.15.10.01.02-1.tar.gz
tar xvf tdodbc1510__linux_indep.15.10.01.03-1.tar.gz

#Install GSS
cd TeraGSS
rpm --prefix=/app/vendored -i TeraGSS_linux_x64-15.10.02.08-1.noarch.rpm

cd ..

#Install TDICU using the setup wrapper script
cd tdicu1510

------------------------------------
Install mode chosen is - Interactive
------------------------------------

 Please enter an installation directory (default: "/opt"): /app/vendored

 < "/app/vendored", entered by user, will be used as the installation directory. >

Installing tdicu1510-15.10.01.02-1.noarch.rpm in "/app/vendored"...
Preparing...                          ################################# [100%]
Updating / installing...
   1:tdicu1510-15.10.01.02-1          ################################# [100%]
Running /app/vendored/teradata/client/15.10/bin/setactiverel.sh ...
Updating /etc/csh.login and /etc/profile...

cd ..

#Install the TDODBC Drivers using the defaults
cd tdodbc1510
./setup_wrapper.sh

# Bundle up the installed dependencies into a tar file
cd /app/vendored
tar cf teradata.tar teradata/
```

## Cloud Foundry Deployment
Simply run `cf push` once the dependencies have been downloaded and changed the
name of the application in the [manifest](manifest.yml). The [startapp.sh](script/statapp.sh)
is where the bulk of the work happens. This script is invoked by the configuration in
the [Procfile](Procfile).
