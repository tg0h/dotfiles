function asid(){
  # userName is case sensitive zzz
  aws iam list-mfa-devices --user-name $1 | bat
}

function asiu(){
  # unset env vars
  unset AWS_DEFAULT_PROFILE
  unset AWS_PROFILE
  unset AWS_EB_PROFILE

  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}

function asiel(){
  # list aws env vars
  env | rg AWS_
}

