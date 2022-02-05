function rapvc(){
  local name description startDate projectId

  while getopts 'n:d:s:' opt; do
    case "$opt" in
      n) name="$OPTARG";;
      d) description="$OPTARG";;
      s) startDate=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  name=${name:+name=\'$name\'}
  description=${description:+description=\'$description\'}
  startDate=${startDate:+startDate=$startDate}
  projectId="projectId:=10759"

  eval "https -pBb -a $JIRA_SECRET POST $JIRA_API_URL/api/3/version $name $description $startDate $projectId"

}
