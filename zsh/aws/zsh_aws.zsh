as(){
  local profile
  case $1 in
    d)
      . ~/.aws/aws.argus.develop.env
      . ~/.argus/argus.develop.env
      asp adev
      ;;
    s)
      . ~/.aws/aws.argus.develop.env
      . ~/.argus/argus.staging.env
      asp adev
      ;;
    p)
      . ~/.aws/aws.argus.production.env
      . ~/.argus/argus.production.env
      asp aprod
      ;;

    as)
      . ~/.aws/argusAu.staging.env
      . ~/.argus/argusAu.staging.env
      asp aastg
      ;;
    ap)
      . ~/.aws/argusAu.production.env
      . ~/.argus/argusAu.production.env
      asp aaprod
      ;;

    cd)
      . ~/.aws/aws.certify.develop.env
      . ~/.certify/certify.develop.env
      asp cdev
      ;;
    cs)
      . ~/.aws/aws.certify.develop.env
      . ~/.certify/certify.staging.env
      asp cdev
      ;;
    cp)
      . ~/.aws/aws.certify.production.env
      . ~/.certify/certify.production.env
      asp cprod
      ;;

    sb)
      . ~/.aws/aws.sandbox.env
      asp sb
      ;;
    *)
      echo "${fg[red]} no profile found ${reset_color}"
  esac
}

