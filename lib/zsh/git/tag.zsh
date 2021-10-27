function gtp(){
  # prune tags
  # delete local tags that don't belong in remote
  # https://git-scm.com/docs/git-fetch
  git fetch origin --prune --prune-tags
}
function gtd (){
  # delete local tags with git tag -d <tagName>
  # gtd <tagName>
  git tag -d $1
}

function gtdd (){
  # delete remote tags with git push --delete origin
  # gtdd <tagName>
  # this uses the same base git command that gbrmd etc uses
  # git tag -l | rg '^v' | xargs -I {} git push --delete --dry-run origin {}
  
  git push --delete origin $1
}

function gtaf(){
  # overwrite a tag
  # gtaf <tagName> <tag annotation>
  
  git tag -f -a $1 -m $2
}
function gta (){
  # add an annotated git tag with git tag -a
  # optionally support a message with -m
  # gta <tagName>
  # gta <tagName> <tag annotation>
  git tag -a $1 -m $2
}

