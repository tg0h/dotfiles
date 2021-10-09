function std(){
  # download face picture from argus s3 bucket and open it
  # std <facePath>
#TODO: use redis?

  local s3path
  while getopts 'p:' opt; do
    case "$opt" in
      p) s3path="$OPTARG" ;;
    esac
  done
  shift $(($OPTIND - 1))

  # the zsh t modifier gets the basename
  local filename=$s3path:t

  aws s3 cp s3://$ARGUS_S3_FACE/$s3path /tmp/
  open /tmp/$filename
}
function stl(){
  # aws s3 ls
  aws s3 ls
}
