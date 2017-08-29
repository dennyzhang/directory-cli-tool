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
## Updated: Time-stamp: <2017-08-28 20:35:00>
##-------------------------------------------------------------------
folder_full_path=${1?}
max_download=${2:-"1"}
max_days=${3:-"1"}

parent_folder_name="$(dirname "$folder_full_path")"
folder_name="$(basename "$folder_full_path")"
tar_file_name="/tmp/${folder_name}.tar.gz"

cd "$parent_folder_name"
echo "tar -zcvf $tar_file_name $folder_name"
tar -zcvf "$tar_file_name" "$folder_name"

echo "Upload $tar_file_name"
curl -H "Max-Downloads: $max_download" -H "Max-Days: $max_days" \
     --upload-file "$tar_file_name" "https://transfer.sh/${folder_name}.tar.gz"

echo ""
## File : transfer_folder_by_http.sh ends
