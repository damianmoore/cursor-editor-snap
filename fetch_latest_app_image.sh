#!/bin/bash

# Get the latest version number and download URL of Cursor
response=$(curl 'https://www.cursor.com/api/dashboard/get-download-link' -H 'accept: */*' -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8' -H 'content-type: application/json' -H 'origin: https://www.cursor.com' -H 'priority: u=1, i' -H 'referer: https://www.cursor.com/' -H 'sec-ch-ua: "Not;A=Brand";v="24", "Chromium";v="128"' -H 'sec-ch-ua-mobile: ?0' -H 'sec-ch-ua-platform: "Linux"' -H 'sec-fetch-dest: empty' -H 'sec-fetch-mode: cors' -H 'sec-fetch-site: same-origin' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0.0.0 Safari/537.36' --data-raw '{"platform":5}')
download_link=$(echo "$response" | grep -oP 'https:\/\/.*?\.AppImage')
version=$(echo "$response" | sed -n 's/.*cursor-\([0-9.]*\).*/\1/p')

echo "Downloading Cursor $version AppImage from $download_link"

# Download the AppImage to cursor-latest.AppImage
# curl -o cursor-latest.AppImage "$download_link"

# Update snapcraft.yaml with the new version
sed -i "s/version: '0.0.0'/version: '$version'/" snap/snapcraft.yaml


# Make the AppImage executable
chmod +x cursor-latest.AppImage

# Extract the AppImage to the squashfs-root directory
./cursor-latest.AppImage --appimage-extract

# Make the extracted directories executable by non-root users (once snap is installed)
find squashfs-root -type d -exec chmod +x {} \;
