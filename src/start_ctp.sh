#!/bin/bash
#
CTP_SOURCE="../currentClient/installed"
CTP_FOLDER="./CTP"
#
#configuration (required: https://stedolan.github.io/jq/download/)
config_file="pipeline_config.json"
name="$( jq -r '.name' "$config_file" )"
site="$( jq -r '.site' "$config_file" )"
name_upper=`echo "$name" | tr '[:lower:]' '[:upper:]'` 
site_upper=`echo "$site" | tr '[:lower:]' '[:upper:]'` 
CONFIG_FOLDER="../site_configurations/$name_upper/$site_upper"
#
# delete config and data folder
rm -rf "$CTP_FOLDER"
cp -R $CTP_SOURCE $CTP_FOLDER
rm "$CTP_FOLDER/config.xml"
#
# copy config folders
cp "$CONFIG_FOLDER/config.xml" "$CTP_FOLDER/config.xml"
cp -R "$CONFIG_FOLDER/ctpConfig/" "$CTP_FOLDER/ctpConfig"
#
cd "$CTP_FOLDER"
java -Xmx1024m -Xms512m -jar libraries/CTP.jar