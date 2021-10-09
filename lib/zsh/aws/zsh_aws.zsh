function as(){
  asiu #unset all the variables set by asst
  local profile
  case $1 in
    d)
      export AWS_DEFAULT_REGION=ap-southeast-1
      #stores cloudwatch cache log name
      . $XDG_CONFIG_HOME/aws/aws.argus.develop.env
      # argus ssh and rds settings
      . $XDG_CONFIG_HOME/argus/env/argus.develop.env
      . $XDG_CONFIG_HOME/abs/argus.develop.env
      asp adev
      ;;
    s)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.argus.staging.env #TODO: duplication?
      . $XDG_CONFIG_HOME/argus/env/argus.staging.env
      . $XDG_CONFIG_HOME/abs/argus.staging.env
      asp adev
      ;;
    p)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.argus.production.env
      . $XDG_CONFIG_HOME/argus/env/argus.production.env
      . $XDG_CONFIG_HOME/abs/argus.production.env
      asp aprod
      ;;

    as)
      export AWS_DEFAULT_REGION=ap-southeast-2
      . $XDG_CONFIG_HOME/aws/aws.argus.au.staging.env
      . $XDG_CONFIG_HOME/argus/env/argusAu.staging.env
      . $XDG_CONFIG_HOME/abs/argus.au.staging.env
      asp aastg
      ;;
    ap)
      export AWS_DEFAULT_REGION=ap-southeast-2
      . $XDG_CONFIG_HOME/aws/aws.argus.au.production.env
      . $XDG_CONFIG_HOME/argus/env/argusAu.production.env
      # . ~/.abs/argus.au.production.env
      asp aaprod
      ;;

    od)
      export AWS_DEFAULT_REGION=ap-southeast-1
      #stores cloudwatch cache log name
      . $XDG_CONFIG_HOME/aws/aws.optimax.develop.env
      # argus ssh and rds settings
      . $XDG_CONFIG_HOME/argus/env/optimax.develop.env
      . $XDG_CONFIG_HOME/abs/optimax.develop.env
      asp odev
      ;;
    os)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.optimax.staging.env #TODO: duplication?
      . $XDG_CONFIG_HOME/argus/env/optimax.staging.env
      . $XDG_CONFIG_HOME/abs/optimax.staging.env
      asp odev
      ;;
    op)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.optimax.production.env
      . $XDG_CONFIG_HOME/argus/env/optimax.production.env
      . $XDG_CONFIG_HOME/abs/optimax.production.env
      asp oprod
      ;;

    cd)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.certify.develop.env
      . $XDG_CONFIG_HOME/certify/certify.develop.env
      asp cdev
      ;;
    cs)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.certify.develop.env
      . $XDG_CONFIG_HOME/certify/certify.staging.env
      asp cdev
      ;;
    cp)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.certify.production.env
      . $XDG_CONFIG_HOME/certify/certify.production.env
      asp cprod
      ;;
    sb)
      export AWS_DEFAULT_REGION=ap-southeast-1
      . $XDG_CONFIG_HOME/aws/aws.sandbox.env
      asp sb
      ;;
    cvs)
      export AWS_DEFAULT_REGION=ap-southeast-1
      asp cvs
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
