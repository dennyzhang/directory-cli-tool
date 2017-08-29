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
## Updated: Time-stamp: <2017-08-28 20:29:09>
##-------------------------------------------------------------------
folder_name=${1?}

tar_file_name="/tmp/$(basename "$folder_name").tar.gz"

echo "tar -zcvf $tar_file_name $folder_name"
tar -zcvf "$tar_file_name" "$folder_name"

echo "Upload $tar_file_name"
curl -H "Max-Downloads: 1" -H "Max-Days: 1" \
     --upload-file "$tar_file_name" "https://transfer.sh/$(basename "$folder_name").tar.gz"
## File : transfer_folder_by_http.sh ends
