as(){
  local profile
  case $1 in
    d)
      export AWS_DEFAULT_REGION=ap-southeast-1
      #stores cloudwatch cache log name
      . ~/.aws/aws.argus.develop.env

      # argus ssh and rds settings
      . ~/.argus/argus.develop.env

      . ~/.abs/argus.develop.env
      asp adev
      ;;
    s)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.argus.develop.env
      . ~/.argus/argus.staging.env
      . ~/.abs/argus.staging.env
      asp adev
      ;;
    p)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.argus.production.env
      . ~/.argus/argus.production.env
      . ~/.abs/argus.production.env
      asp aprod
      ;;

    as)
      export AWS_DEFAULT_REGION=ap-southeast-2
      . ~/.aws/aws.argus.au.staging.env
      . ~/.argus/argusAu.staging.env
      # . ~/.abs/argus.au.staging.env
      asp aastg
      ;;
    ap)
      export AWS_DEFAULT_REGION=ap-southeast-2
      . ~/.aws/aws.argus.au.production.env
      . ~/.argus/argusAu.production.env
      # . ~/.abs/argus.au.production.env
      asp aaprod
      ;;

    cd)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.certify.develop.env
      . ~/.certify/certify.develop.env
      asp cdev
      ;;
    cs)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.certify.develop.env
      . ~/.certify/certify.staging.env
      asp cdev
      ;;
    cp)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.certify.production.env
      . ~/.certify/certify.production.env
      asp cprod
      ;;

    sb)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . ~/.aws/aws.sandbox.env
      asp sb
      ;;
    *)
      echo "${fg[red]} no profile found ${reset_color}"
  esac
}

function aws-toggle() {
  if (( ${+POWERLEVEL9K_AWS_SHOW_ON_COMMAND} )); then
    # by removing this var, we always show the aws prompt
    unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND
  else
    POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|as'
  fi
  p10k reload
  if zle; then
    zle push-input
    zle accept-line
  fi
}

zle -N aws-toggle
bindkey '^A' aws-toggle
