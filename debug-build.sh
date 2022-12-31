#!/usr/bin/env bash
#set -x

echo Building debug executables
if ! [ $# -eq 1 ] ; then
  echo "Product version not found: x.y.z (e.g. 1.2.3)" >&2
  exit 1
fi

mkdir -p ./dist/iso
mkdir -p ./dist/linux
mkdir -p ./dist/macos
mkdir -p ./dist/windows
mkdir -p ./dist/templates

pushd ./commands/check
echo "Building check"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/check.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/check
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/check
rm rsrc_windows_amd64.syso
popd

pushd ./commands/relock
echo "Building relock"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/relock.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/relock
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/relock
rm rsrc_windows_amd64.syso
popd

pushd ./commands/unlock
echo "Building unlock"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/unlock.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/unlock
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/unlock
rm rsrc_windows_amd64.syso
popd

pushd ./commands/dumpsmc
echo "Building dumpsmc"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/dumpsmc.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/dumpsmc
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/dumpsmc
rm rsrc_windows_amd64.syso
popd

pushd ./commands/patchgos
echo "Building patchgos"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/patchgos.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/patchgos
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/patchgos
rm rsrc_windows_amd64.syso
popd

pushd ./commands/patchsmc
echo "Building patchsmc"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/patchsmc.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/patchsmc
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/patchsmc
rm rsrc_windows_amd64.syso
popd

pushd ./commands/patchvmkctl
echo "Building patchvmkctl"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/patchvmkctl.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/patchvmkctl
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/patchvmkctl
rm rsrc_windows_amd64.syso
popd

pushd ./commands/hostcaps
echo "Building hostcaps"
go-winres make --arch amd64 --product-version $1 --file-version $1
env GOOS=windows GOARCH=amd64 go build -o ../../dist/windows/hostcaps.exe
env GOOS=linux GOARCH=amd64 go build -o ../../dist/linux/hostcaps
env GOOS=darwin GOARCH=amd64 go build -o ../../dist/macos/hostcaps
rm rsrc_windows_amd64.syso
popd

cp -v LICENSE ./dist
cp -v *.md ./dist
cp -vr ./cpuid/* ./dist
cp -vr ./iso ./dist
cp -vr ./templates ./dist
