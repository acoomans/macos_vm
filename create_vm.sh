#!/bin/bash -x -e

brew cask install virtualbox virtualbox-extension-pack

VM="macOS"
DISK="$VM.vdi"
OS="MacOS_64" # VBoxManage list ostypes
ISO="$HOME/Desktop/macos.iso"
SIZE="25000"
RAM="4096"
VRAM="128"

VBoxManage createvm --name "$VM" --ostype "$OS" --register

VBoxManage createhd --filename "$VM.vdi" --size $SIZE --variant standard
VBoxManage storagectl "$VM" --name "SATA Controller" --add sata --hostiocache on
VBoxManage storageattach "$VM" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --nonrotational on --medium "$DISK"
VBoxManage storageattach "$VM" --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium "$ISO"

VBoxManage modifyvm "$VM" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
VBoxManage modifyvm "$VM" --cpus 2
VBoxManage modifyvm "$VM" --chipset ich9
VBoxManage modifyvm "$VM" --pae on
VBoxManage modifyvm "$VM" --firmware efi
VBoxManage modifyvm "$VM" --rtcuseutc on
VBoxManage modifyvm "$VM" --usbxhci on
VBoxManage modifyvm "$VM" --memory $RAM 
VBoxManage modifyvm "$VM" --vram $VRAM
VBoxManage modifyvm "$VM" --boot1 dvd --boot2 disk
VBoxManage modifyvm "$VM" --mouse usbtablet --keyboard usb
VBoxManage modifyvm "$VM" --audiocontroller hda --audiocodec stac9221
#VBoxManage modifyvm "$VM" --nic1 bridged --bridgeadapter1 e1000g0

VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemFamily"       "MacBook Pro"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct"      "MacBookPro11,2"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemSerial"       "SERIAL_NUMBER"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemUuid"         "F5C6D3CD-6B21-46EB-8DD2-F66AEA06FF86"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemVendor" 			"Apple Inc."
VBoxManage setextradata "$VM" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" 			"1.0"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/DeviceKey" 						"ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
VBoxManage setextradata "$VM" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 		0
VBoxManage setextradata "$VM" "VBoxInternal2/EfiGraphicsResolution"											"1920×1200"
VBoxManage setextradata "$VM" "VBoxInternal2/EfiGopMode"																5
