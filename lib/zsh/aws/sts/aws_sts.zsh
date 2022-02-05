function asst(){
  # aws sts get-session-token

  local token=$(authy fuzz sandbox | rg --only-matching '\d{6}')
  echo -e $fg[green] got authy token: $fg[cyan]$token

  local data=$(aws sts get-session-token --serial-number arn:aws:iam::051642344985:mfa/***REMOVED*** --token-code $token --profile sb)
  local accessKey=$(jq --raw-output '.Credentials.AccessKeyId' <<< $data)
  local secret=$(jq --raw-output '.Credentials.SecretAccessKey' <<< $data)
  local token=$(jq --raw-output '.Credentials.SessionToken' <<< $data)

  echo -e $fg[green] setting aws env vars '...'

  export AWS_ACCESS_KEY_ID=$accessKey
  export AWS_SECRET_ACCESS_KEY=$secret
  export AWS_SESSION_TOKEN=$token
}

function assi(){
  # aws sts get caller identity
  aws sts get-caller-identity | bat
}
