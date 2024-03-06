#!/usr/bin/env bash
set -eo pipefail

if [ -z $artifact_path ] && [ -n "$sauce_app_name" ]; then
  artifact_path=$(if [[ $sauce_app_name =~ ".apk" ]]; then
    echo $BITRISE_APK_PATH;
  elif [[ $sauce_app_name =~ ".aab" ]]; then
    echo $BITRISE_AAB_PATH; 
  elif [[ $sauce_app_name =~ ".ipa" ]]; then
    echo $BITRISE_IPA_PATH;
  elif [[ $sauce_app_name =~ ".zip" ]]; then
    echo $BITRISE_XCARCHIVE_ZIP_PATH;
  else
    echo "Your 'sauce_app_name' either does not contain a valid extension (.apk, .aab, .ipa, or .zip).";
    echo "or does not match the build that was produced in this workflow";
    echo "Please update your 'sauce_app_name' value or set your own artifact_path.";
    exit 1;
  fi)
fi

if [[ -z $artifact_path ]] && [[ -z $sauce_app_name ]]; then
  artifact_path=$(if [[ -n "$BITRISE_APK_PATH" ]]; then
    echo $BITRISE_APK_PATH;
  elif [[ -n "$BITRISE_AAB_PATH" ]]; then
    echo $BITRISE_AAB_PATH; 
  elif [[ -n "$BITRISE_IPA_PATH" ]]; then
    echo $BITRISE_IPA_PATH;
  elif [[ -n "$BITRISE_XCARCHIVE_ZIP_PATH" ]]; then
    echo $BITRISE_XCARCHIVE_ZIP_PATH;
  else
    echo "We attempted to find a valid build since 'artifact_path' and 'sauce_app_name' were not provided, but could not find one.";
    echo "Please provide a .apk, .aab, .ipa, or .zip within this workflow or provide a custom 'artifact_path'.";
    exit 1;
  fi)
fi

if [[ -z $data_center_endpoint ]]; then
  data_center_endpoint="https://api.us-west-1.saucelabs.com/v1/storage/upload"
fi

if [[ -z $sauce_app_name ]]; then
  curl --location --request POST \
    --url "$data_center_endpoint" \
    --user "$sauce_username:$sauce_access_key" \
    --form "payload=@$artifact_path"\
    --fail
else
  curl --location --request POST \
    --url "$data_center_endpoint" \
    --user "$sauce_username:$sauce_access_key" \
    --form "payload=@$artifact_path"\
    --form "name=$sauce_app_name" \
    --fail
fi
