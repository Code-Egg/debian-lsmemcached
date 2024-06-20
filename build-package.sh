#!/bin/bash
LSMCD_VERSION='1.4.38'
if [[ $# -lt 1 ]]; then
  echo "./build-package.sh source|any|all|binary|full [args]"
  exit 1
fi

BUILD=$1
shift

VERSION=`dpkg-parsechangelog --show-field Version | cut -f1 -d'-'`
DEBPATH=build

./clean.sh

wget https://github.com/litespeedtech/lsmcd/archive/refs/tags/v${LSMCD_VERSION}.tar.gz
tar -zxf v${LSMCD_VERSION}.tar.gz
tar Jcvf lsmcd_${VERSION}.orig.tar.xz lsmcd-${LSMCD_VERSION} lsmcd.1

mkdir ${DEBPATH}
cp -r lsmcd-${LSMCD_VERSION}/* ${DEBPATH}
cp lsmcd.1 ${DEBPATH}
cp -r debian ${DEBPATH}

cd ${DEBPATH}
dpkg-buildpackage --build=$BUILD "$@"
cd ..