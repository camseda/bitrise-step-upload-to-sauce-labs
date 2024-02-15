#!/usr/bin/env bash
set -eo pipefail

if [[ -z $SAUCELABS_APP_NAME ]]; then
  echo "SAUCE_LABS_APP_NAME environment variable must be set for this workflow!"
  exit 1
fi

curl --location --request POST \
  --url "https://api.us-west-1.saucelabs.com/v1/storage/upload" \
  --user "$saucelabs_username:$saucelabs_access_key" \
  --form "payload=@$upload_path"\
  --form "name=$saucelabs_app_name" \
  --fail