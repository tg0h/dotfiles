function rapve(){
  local name description startDate releaseDate archived released versionId

  while getopts 'n:d:s:e:ar' opt; do
    case "$opt" in
      n) name="$OPTARG";;
      d) description="$OPTARG";;
      s) startDate=$OPTARG;;
      e) releaseDate=$OPTARG;;
      a) archived="true";;
      r) released="true";;
    esac
  done
  shift $(($OPTIND - 1))

  versionId=$1

  name=${name:+name=\'$name\'}
  description=${description:+description=\'$description\'}
  startDate=${startDate:+startDate=$startDate}
  releaseDate=${releaseDate:+releaseDate=$releaseDate}
  archived=${archived:+"archived:=true"}
  released=${released:+"released:=true"}

  # --headers - print only response headers
  eval "https --pretty all --headers -a $JIRA_SECRET PUT $JIRA_API_URL/api/3/version/$versionId \
    $name $description $startDate $releaseDate $archived $released" | rg HTTP
}
