#!/bin/bash -e
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://raw.githubusercontent.com/DennyZhang/devops_public/master/LICENSE
##
## File : transfer_folder_by_http.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## Read more: https://www.dennyzhang.com/transfer_cli
## --
## Created : <2017-08-28>
## Updated: Time-stamp: <2017-08-28 20:38:28>
##-------------------------------------------------------------------
if [ -z "$FOLDER_FULL_PATH" ]; then
    echo "ERROR: Need to provide FOLDER_FULL_PATH"
fi

[ -n "$MAX_DAYS" ] || MAX_DAYS="1"
[ -n "$MAX_DOWNLOAD" ] || MAX_DOWNLOAD="1"

parent_folder_name="$(dirname "$FOLDER_FULL_PATH")"
folder_name="$(basename "$FOLDER_FULL_PATH")"
tar_file_name="/tmp/${folder_name}.tar.gz"

cd "$parent_folder_name"
echo "tar -zcvf $tar_file_name $folder_name"
tar -zcvf "$tar_file_name" "$folder_name"

echo "Upload $tar_file_name"
curl -H "Max-Downloads: $MAX_DOWNLOAD" -H "Max-Days: $MAX_DAYS" \
     --upload-file "$tar_file_name" "https://transfer.sh/${folder_name}.tar.gz"

echo ""
## File : transfer_folder_by_http.sh ends
