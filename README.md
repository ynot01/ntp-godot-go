# NTP in Godot

A small GDExtension (4.3+) for interfacing with NTP servers

## Usage

`NTP.now()` will return the current UTC time in milliseconds as reported by the NTP server

## Download

### [Latest release here](https://github.com/ynot01/ntp-godot-go/releases/latest/download/addons.zip)

## Building

Run `./Build.ps1` or `./Build.sh`

Dependencies will be downloaded automatically

Copy the resultant `./addons/` folder to your Godot project

## Testing

Run `gd build` then `gd test`

The project in `./graphics/` will be used to test the extension

## Technologies

- [Go](https://go.dev/dl)

  - [beevik/ntp](https://github.com/beevik/ntp)

- [Godot](https://godotengine.org/download)

  - [grow-graphics/gd](https://github.com/grow-graphics/gd)