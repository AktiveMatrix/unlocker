#!/usr/bin/env bash
#set -x

echo Building release executables
if ! [ $# -eq 1 ] ; then
  echo "Product version not found" >&2
  exit 1
fi

mkdir -p ./dist/iso
mkdir -p ./dist/linux
mkdir -p ./dist/windows
mkdir -p ./dist/templates

pushd ./commands/check
echo "Building check"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/check.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/check
rm rsrc_windows_amd64.syso
popd

pushd ./commands/relock
echo "Building relock"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/relock.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/relock
rm rsrc_windows_amd64.syso
popd

pushd ./commands/unlock
echo "Building unlock"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/unlock.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/unlock
rm rsrc_windows_amd64.syso
popd

pushd ./commands/hostcaps
echo "Building hostcaps"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/hostcaps.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/hostcaps
rm rsrc_windows_amd64.syso
popd

cp -v LICENSE ./dist
cp -v *.md ./dist
cp -vr ./cpuid/* ./dist
cp -vr ./iso ./dist
cp -vr ./templates ./dist
