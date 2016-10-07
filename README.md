# Python Teradata ODBC Connectivity

## Vendor Dependencies
Run `script/install-dependencies` which will create the below folders in repository directory.

```
vendor/
```

## Cloud Foundry Deployment
Simply run `cf push` once the dependencies have been downloaded and changed the
name of the application in the [manifest](manifest.yml). The [startapp.sh](script/statapp.sh)
is where the bulk of the work happens. This script is invoked by the configuration in
the [Procfile](Procfile). 
