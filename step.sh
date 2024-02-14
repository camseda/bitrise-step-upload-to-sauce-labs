#!/usr/bin/env bash
set -eo pipefail

if [[ -z $SAUCE_LABS_APP_NAME ]]; then
  echo "SAUCE_LABS_APP_NAME environment variable must be set for this workflow!"
  exit 1
fi

curl --location --request POST \
  --url "https://api.us-west-1.saucelabs.com/v1/storage/upload" \
  --user "$SAUCE_LABS_USERNAME:$SAUCE_LABS_ACCESS_KEY" \
  --form 'payload=@$upload_path' \
  --form 'name="'$SAUCE_LABS_APP_NAME'"' \
  --fail
