#!/bin/bash -e
##-------------------------------------------------------------------
## @copyright 2017 DennyZhang.com
## Licensed under MIT
## https://raw.githubusercontent.com/DennyZhang/devops_public/master/LICENSE
##
## File : transfer_file_by_http.sh
## Author : Denny <denny@dennyzhang.com>
## Description :
## Read more: https://www.dennyzhang.com/transfer_cli
## --
## Created : <2017-08-28>
## Updated: Time-stamp: <2017-08-28 20:48:08>
##-------------------------------------------------------------------
function transfer_folder() {
    local transfer_full_path=${1?}
    local max_days=${2?}
    local max_download=${3?}
    parent_folder_name="$(dirname "$transfer_full_path")"
    folder_name="$(basename "$transfer_full_path")"
    tar_file_name="/tmp/${folder_name}.tar.gz"

    cd "$parent_folder_name"
    echo "tar -zcf $tar_file_name $folder_name"
    tar -zcf "$tar_file_name" "$folder_name"

    echo "Upload $tar_file_name."
    echo "The file can be downloaded only $max_download times. And Valid for $max_days days"
    curl -H "Max-Downloads: $MAX_DOWNLOAD" -H "Max-Days: $MAX_DAYS" \
         --upload-file "$tar_file_name" "https://transfer.sh/${folder_name}.tar.gz"
}

function transfer_file() {
    local transfer_full_path=${1?}
    local max_days=${2?}
    local max_download=${3?}

    echo "Upload $transfer_full_path."
    echo "The file can be downloaded only $max_download times. And Valid for $max_days days"
    curl -H "Max-Downloads: $MAX_DOWNLOAD" -H "Max-Days: $MAX_DAYS" \
         --upload-file "$transfer_full_path" "https://transfer.sh/$(basename "$transfer_full_path")"
}

################################################################################
if [ -z "$TRANSFER_FULL_PATH" ]; then
    echo "ERROR: Need to provide TRANSFER_FULL_PATH"
fi

[ -n "$MAX_DAYS" ] || MAX_DAYS="1"
[ -n "$MAX_DOWNLOAD" ] || MAX_DOWNLOAD="1"

if [ -d "$TRANSFER_FULL_PATH" ]; then
    transfer_folder "$TRANSFER_FULL_PATH" "$MAX_DAYS" "$MAX_DOWNLOAD"
else
    if [ -f "$TRANSFER_FULL_PATH" ]; then
        transfer_file "$TRANSFER_FULL_PATH" "$MAX_DAYS" "$MAX_DOWNLOAD"
    else
        echo "ERROR: $TRANSFER_FULL_PATH is neither a file or a folder"
        exit 1
    fi
fi
echo ""
## File : transfer_file_by_http.sh ends
