#!/usr/bin/env bash
set -e

# Setup the path to the install location of the teradata drivers
export TERADATA_INSTALL_DIR=/app/vendored/teradata/client/15.10

# Setup the environment for the Teradata drivers
. ${TERADATA_INSTALL_DIR}/etc/ttu_1510_bash.env

# Install the ODBC drivers for the vcap user
cp ${TERADATA_INSTALL_DIR}/odbc_64/odbcinst.ini ~/.odbcinst.ini
cp ${TERADATA_INSTALL_DIR}/odbc_64/odbc.ini ~/.odbc.ini
# Setting up sym links for include directory and lib directory since the cf cli
# removes sym links.
# https://github.com/cloudfoundry/cli/issues/634
# https://github.com/cloudfoundry/cli/issues/108
# https://github.com/cloudfoundry/cli/blob/3ce3f3857de21435d986f51b74f474ac8267520a/cf/app_files/app_files.go#L95-L97
ln -s ${TERADATA_INSTALL_DIR}/lib64 ${TERADATA_INSTALL_DIR}/odbc_64/lib
ln -s ${TERADATA_INSTALL_DIR}/include ${TERADATA_INSTALL_DIR}/odbc_64/include
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicudatatd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicudatatd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicudatatd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicudatatd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicui18ntd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicui18ntd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicui18ntd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicui18ntd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicuiotd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicuiotd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicuiotd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicuiotd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/libiculetd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libiculetd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libiculetd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libiculetd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/libiculxtd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libiculxtd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libiculxtd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libiculxtd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicuuctd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicuuctd.so
ln -s ${TERADATA_INSTALL_DIR}/lib64/libicuuctd.so.52.1 ${TERADATA_INSTALL_DIR}/lib64/libicuuctd.so.52
ln -s ${TERADATA_INSTALL_DIR}/lib64/ddtrc27.so ${TERADATA_INSTALL_DIR}/lib64/odbctrac.so

# Setting the permissions correctly on the .genuine_TTU file since cf needs the file to have be readable while pushing.
# the libraries complain when they are not
chmod 4111 ${TERADATA_INSTALL_DIR}/.genuine_TTU

# Start the application
python teradatatest-connect.py
