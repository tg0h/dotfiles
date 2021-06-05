function ctlist(){
  aws events list-rules | jq -r '.Rules[] | .Name'
}

function ctfilter(){
  aws events list-rules | jq -r '.Rules[] | .Name' | rg $1
}

# TODO: how to remove target and delete rule in a single function?
# delete the cloudwatch rule target before deleting it
# run ctfilter ... | ctdelt, then run
# run ctfilter ... | ctdelr
function ctdelt(){
   # examples:
   # ctfilter 2020 | ctdelt
   # ctfilter 202103 | ctdelt
   parallel aws events remove-targets --rule {} --ids 1
   # parallel aws events delete-rule --name {}
}

# delete the cloudwatch rule after deleting the cloudwatch rule target
function ctdelr(){
   # examples:
   # ctfilter 2020 | ctdelr
   # ctfilter 202103 | ctdelr
   # parallel aws events remove-targets --rule {} --ids 1
   # to use, run this command: ctfilter 2020 | ctdelr
   parallel aws events delete-rule --name {}
}
