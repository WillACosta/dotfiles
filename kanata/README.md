## Kanata Remapping

Kanata is a remapping tool that provides an easier way to remap a keyboard keys without the need of a specific software for this (e.g. qmk, via, etc).

> Important
> Kanata doesn't provide a way to start it in background, so we'll need a workaround for this. We can add the command to a terminal startup session or something similar.

1. You need to install the necessary Karabiner drivers version for your current SO, match both of them with the supported version, more details in the tools section.

2. Install the necessary versions for MacOS Sequoia.

## Tools

- [Karabiner Drivers — MacOS](https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice)
- [Kanata](https://github.com/jtroo/kanata/)

## Instalation

```
chmod +x kanata_macos_arm64
sudo ./kanata_macos_arm64 --cfg <cfg_file>`
```
