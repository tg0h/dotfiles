function rapi(){
  # call jira api /rest/$1
  
  https -b -a $JIRA_SECRET $JIRA_API_URL/$1
}

function rapir(){
  # call jira api v3 /rest/api/3
  https -b -a $JIRA_SECRET $JIRA_API_URL/api/3/issue/$1
}
