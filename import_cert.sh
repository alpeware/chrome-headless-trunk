#!/bin/bash

# Script that listen for changes in 'certificates' subdir of 'BASEDIR'
# and updates the NSSDB when PEM encoded certificates are updated.

if [ -z "$1" ]; then
  echo "Usage: import_cert.sh BASEDIR"
  exit 1
fi

BASEDIR=$1
CERTS=$BASEDIR/certificates
NSSDB=$BASEDIR/.pki/nssdb

echo "Looking for CA certificate in $CERTS"

mkdir -p $CERTS
mkdir -p $NSSDB

function add_cert {
  file=$1
  basename=$(basename $file)
  certname=${basename%%.*}
  suffix=${basename##*.}

  if [ "pem" = "$suffix" ]; then
    if certutil -d sql:$NSSDB -A -t "CT,C,C" -n $certname -i $file; then
      echo "Certificate $pem imported"
    fi
  fi
}

certutil -d sql:$NSSDB --empty-password -N -f /dev/null 2> /dev/null
echo "Keystore created"

for pem in `ls $CERTS/*.pem 2> /dev/null`; do
  add_cert $pem
done

while true; do
  pem=`inotifywait -q -e create -e modify -e moved_to --format '%w%f' $CERTS`
  add_cert $pem
done
