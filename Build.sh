goVersion=1.24.0

rm -rf ./addons
mkdir ./addons
mkdir ./addons/time

echo "---INSTALLING DEPENDENCIES---"
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential -y
sudo apt-get install gcc-mingw-w64-x86-64 -y
sudo apt-get install gcc-aarch64-linux-gnu -y

echo "---INSTALLING WINDOWS ARM SUPPORT---"
wget https://github.com/Windows-on-ARM-Experiments/mingw-woarm64-build/releases/download/2024-07-03/aarch64-w64-mingw32-msvcrt-toolchain.tar.gz
sudo tar -C /usr/local -xzf ./aarch64-w64-mingw32-msvcrt-toolchain.tar.gz
rm ./aarch64-w64-mingw32-msvcrt-toolchain.tar.gz

echo "---INSTALLING go---"
wget https://go.dev/dl/go${goVersion}.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzf ./go${goVersion}.linux-amd64.tar.gz
rm ./go${goVersion}.linux-amd64.tar.gz
GOPATH=/usr/local/go
PATH=$PATH:/usr/local/go/bin
go version

echo "---INSTALLING gd---"
go install graphics.gd/cmd/gd@master
PATH=$PATH:~/go/bin

echo "---STARTING BUILD PROCESS---"
cp ./time.gdextension ./addons/time/time.gdextension

echo "building windows amd64"
CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc GOOS=windows GOARCH=amd64 gd build -buildmode=c-shared -buildvcs=false
cp graphics/windows_amd64.dll addons/time/windows_amd64.dll

echo "building windows arm64"
CGO_ENABLED=1 CC=aarch64-w64-mingw32-gcc GOOS=windows GOARCH=arm64 gd build -buildmode=c-shared -buildvcs=false
cp graphics/windows_arm64.dll addons/time/windows_arm64.dll

echo "building linux amd64"
CGO_ENABLED=1 GOOS=linux GOARCH=amd64 gd build -buildmode=c-shared -buildvcs=false
cp graphics/linux_amd64.so addons/time/linux_amd64.so

echo "building linux arm64"
CGO_ENABLED=1 CC=aarch64-linux-gnu-gcc GOOS=linux GOARCH=arm64 gd build -buildmode=c-shared -buildvcs=false
cp graphics/linux_arm64.so addons/time/linux_arm64.so
