# https://docs.atlassian.com/jira-software/REST/7.3.1/
# $JIRA_URL is defined in zsh_jira.plug.zsh
# $JIRA_SECRET is defined in the env file

func jb(){
  https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board 
}

func je(){
  local boardId=1 #Argus

  https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/epic
}

func je(){
  boardId=1 #Argus

  https -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board/$boardId/epic
}
