#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "./build-package.sh source|any|all|binary|full [args]"
  exit 1
fi

BUILD=$1
shift

VERSION=`dpkg-parsechangelog --show-field Version | cut -f1 -d'-'`
DEBPATH=build

./clean.sh

#tar Jcvf hellodeb_${VERSION}.orig.tar.xz hellodeb.c
wget https://github.com/litespeedtech/lsmcd/archive/refs/tags/v1.4.38.tar.gz
tar -zxf v1.4.38.tar.gz
mv v1.4.38.tar.gz lsmcd_${VERSION}.orig.tar.xz

mkdir ${DEBPATH}
cp -r lsmcd-1.4.38/* ${DEBPATH}

cp -r debian ${DEBPATH}

cd ${DEBPATH}
dpkg-buildpackage --build=$BUILD "$@"
cd ..