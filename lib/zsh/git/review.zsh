# REVIEW functions ============================================================
REVIEW_BASE=master
gfiles(){
  git diff --name-only $(git merge-base HEAD $REVIEW_BASE)
}

gstats(){
  git diff --stat $(git merge-base HEAD $REVIEW_BASE)
}

greview(){
  #-p - open files in tabs in vim
  #+ run the command in vim
  vim -p $(gfiles) +"tabdo Gdiff $REVIEW_BASE" +"let g:gitgutter_diff_base = '$REVIEW_BASE'"
}

greviewone(){
  vim -p +"tabdo Gdiff $REVIEW_BASE" +"let g:gitgutter_diff_base = '$REVIEW_BASE'"
}
# REVIEW functions ============================================================
