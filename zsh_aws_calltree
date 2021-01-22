function ctlist(){
  aws events list-rules | jq -r '.Rules[] | .Name'
}

function ctfilter(){
  aws events list-rules | jq -r '.Rules[] | .Name' | rg $1
}

# TODO: how to remove target and delete rule in a single function?
# delete the cloudwatch rule target before deleting it
function ctdelt(){
   # to use, run this command: ctfilter 2020 | ctdelt
   parallel aws events remove-targets --rule {} --ids 1
   # parallel aws events delete-rule --name {}
}

# delete the cloudwatch rule after deleting the cloudwatch rule target
function ctdelr(){
   # parallel aws events remove-targets --rule {} --ids 1
   parallel aws events delete-rule --name {}
}
