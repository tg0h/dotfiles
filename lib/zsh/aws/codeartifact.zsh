function asca(){
  # get the authorization token to build the officer app
  aws codeartifact get-authorization-token --domain certis \
    --domain-owner 051642344985 --query authorizationToken \
    --output text | cat
}
