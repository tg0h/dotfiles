function rab(){
  # list jira boards
  # -a means --auth
  # use basic authentication by default

  # jq
  # -r - raw output
  https --print=HhBb -b -a $JIRA_SECRET $JIRA_URL/rest/agile/1.0/board \
    | jq -r  '.values[] | (.id|tostring) + " - " + .name'
  }
