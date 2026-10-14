# Yfch - A lightweight shorts downloader
### **Warning:** Currently, this script only support **Linux** as it is a **Bash** script.

## Features:
###**Yfch is a lightweight yt-dlp tool for downloading batches of shorts on Linux**
- Download **batches of shorts** for offline vieweing
- Enter **custom search terms****** which it will browse for online
- Download and **organize** your files
- Downloads use **low storage space**

## Notes:
- This script aims to be versatile, but because of youtubes changing infrastructure, some linux distros "stable release" **may fail to have the latest version of yt-dlp available which can cause the script to fail**.

## Prequisites:
###**To run this script**, you need to have the following programs installed on your linux machine
- **yt-dlp**
- **curl**

## Install Dependencies
### Installation command for **Debian / Ubuntu**:
```
sudo apt update && sudo apt install -y curl yt-dlp
```
### Installation command for **Arch Based**:
```
sudo pacman -Syu --needed curl yt-dlp --noconfirm
```

### Installation command for **openSUSE**:
```
sudo zypper refresh && sudo zypper install -y curl yt-dlp
```

## Run the script:
### **Once all the dependencies are installed**, you can run the script in two ways:

**Pull from Internet**
```
bash <(curl -sl https://raw.githubusercontent.com/qzecbum/Yfch-shortsdownloader/refs/heads/main/yfch.sh)
```

**Manual run**

- Download the script:
```
curl -l https://raw.githubusercontent.com/qzecbum/Yfch-shortsdownloader/refs/heads/main/yfch.sh -o yfch.sh
```

- Chmod the script:
```
chmod +x yfch.sh
```

- Run the script:
```
./yfch.sh
```

