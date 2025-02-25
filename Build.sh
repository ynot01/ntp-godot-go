goVersion=1.24.0

rm -rf ./addons
mkdir ./addons
mkdir ./addons/time

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install build-essential -y
sudo apt-get install gcc-mingw-w64-x86-64 -y
wget https://go.dev/dl/go${goVersion}.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzf ./go${goVersion}.linux-amd64.tar.gz
rm ./go${goVersion}.linux-amd64.tar.gz

/usr/local/go/bin/go version

echo "---STARTING BUILD PROCESS---"
cp ./graphics/library.gdextension ./addons/time/time.gdextension
echo "building windows amd64"
CGO_ENABLED=1 CC=x86_64-w64-mingw32-gcc GOOS=windows GOARCH=amd64 /usr/local/go/bin/go build -o ./addons/time/windows_amd64.dll -buildmode=c-shared
echo "building linux amd64"
CGO_ENABLED=1 GOOS=linux GOARCH=amd64 /usr/local/go/bin/go build -o ./addons/time/linux_amd64.so -buildmode=c-shared