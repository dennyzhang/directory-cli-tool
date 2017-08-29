#!/bin/bash -e
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT 
##   https://raw.githubusercontent.com/DennyZhang/devops_public/master/LICENSE
##
## File : transfer_file_by_http.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## Read more: https://www.dennyzhang.com/transfer_cli
## --
## Created : <2017-08-28>
## Updated: Time-stamp: <2017-08-28 20:40:35>
##-------------------------------------------------------------------
if [ -z "$TRANSFER_FULL_PATH" ]; then
    echo "ERROR: Need to provide TRANSFER_FULL_PATH"
fi

[ -n "$MAX_DAYS" ] || MAX_DAYS="1"
[ -n "$MAX_DOWNLOAD" ] || MAX_DOWNLOAD="1"

# TODO: support both file and folder
parent_folder_name="$(dirname "$TRANSFER_FULL_PATH")"
folder_name="$(basename "$TRANSFER_FULL_PATH")"
tar_file_name="/tmp/${folder_name}.tar.gz"

cd "$parent_folder_name"
echo "tar -zcvf $tar_file_name $folder_name"
tar -zcvf "$tar_file_name" "$folder_name"

echo "Upload $tar_file_name"
curl -H "Max-Downloads: $MAX_DOWNLOAD" -H "Max-Days: $MAX_DAYS" \
     --upload-file "$tar_file_name" "https://transfer.sh/${folder_name}.tar.gz"

echo ""
## File : transfer_file_by_http.sh ends
