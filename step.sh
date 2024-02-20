#!/usr/bin/env bash
set -eo pipefail

if [[ -z $sauce_app_name ]]; then
  echo "SAUCE_APP_NAME environment variable must be set for this workflow!"
  exit 1
fi

curl --location --request POST \
  --url "https://api.us-west-1.saucelabs.com/v1/storage/upload" \
  --user "$sauce_username:$sauce_access_key" \
  --form "payload=@$upload_path"\
  --form "name=$sauce_app_name" \
  --fail