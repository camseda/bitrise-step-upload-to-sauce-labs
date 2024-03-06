#!/usr/bin/env bash
set -eo pipefail

if [[ -z $sauce_app_name ]]; then
  echo "SAUCE_APP_NAME environment variable must be set for this workflow!"
  exit 1
fi

if [[ -z $artifact_path ]]; then
  artifact_path=$(if [[ $sauce_app_name =~ ".apk" ]]; then
    echo $BITRISE_APK_PATH;
  elif [[ $sauce_app_name =~ ".aab" ]]; then
    echo $BITRISE_AAB_PATH; 
  elif [[ $sauce_app_name =~ ".ipa" ]]; then
    echo $BITRISE_IPA_PATH;
  elif [[ $sauce_app_name =~ ".zip" ]]; then
    echo $BITRISE_XCARCHIVE_ZIP_PATH;
  else
    echo "Your application name does not contain a valid extension (.apk, .aab, .ipa, or .zip).";
    echo "Please update your sauce_app_name input value, or set your own artifact_path.";
    exit 1;
  fi)
fi

if [[ -z $data_center_endpoint ]]; then
  data_center_endpoint="https://api.us-west-1.saucelabs.com/v1/storage/upload"
fi

curl --location --request POST \
  --url "$data_center_endpoint" \
  --user "$sauce_username:$sauce_access_key" \
  --form "payload=@$artifact_path"\
  --form "name=$sauce_app_name" \
  --fail