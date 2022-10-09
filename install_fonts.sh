#!/bin/bash

FONTS_PATH=/home/$SUDO_USER/.fonts


DOWNLOAD_PATH=/home/$SUDO_USER/fonts-downloads/
DOWNLOAD_FILE_NAME=fonts_archive.zip
WGET_ERRORS_LOG=wget_log.txt

WGET_URL="https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip"


mkdir "$DOWNLOAD_PATH"
cd "$DOWNLOAD_PATH"	


echo "Downloding fonts archive..."
wget "$WGET_URL" -O "$DOWNLOAD_FILE_NAME" > "$WGET_ERRORS_LOG" 2>&1

STATUS=`grep -E "ERROR|failed" "$WGET_ERRORS_LOG"`

if [ ! -z "$STATUS" ]
then	
	echo "Wget ERROR: $STATUS"
	exit 0
fi


echo "Unzip downloaded archive..."
unzip -o "$DOWNLOAD_FILE_NAME" > /dev/null 2>&1


mkdir "$FONTS_PATH" > /dev/null 2>&1


echo "Copy fonts to target save path..."
cp ttf/*.ttf "$FONTS_PATH"


echo "Scan all fonts on host..."
fc-cache -f -v > /dev/null 2>&1


chown -hR $SUDO_USER "$FONTS_PATH"

cd ..
rm -Rf "$DOWNLOAD_PATH"


echo "Install fonts succeeded!"
