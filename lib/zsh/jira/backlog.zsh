function rabl(){
  # move issues to backlog
  https --print=HhBb -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/issues
  
  #need to post request body with array of issues to move to backlog

  }
