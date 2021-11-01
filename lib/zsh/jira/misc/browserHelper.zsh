function fa(){
  # fa 2805 opens ARG-2805 in jira in firefox
  open -a firefox https://certisgroup.atlassian.net/browse/ARG-$1
}

function ff(){
  # ff <arg> opens ACF-<arg> in jira in firefox
  open -a firefox https://certisgroup.atlassian.net/browse/ACF-$1
}

function fo(){
  # fo <arg> opens OTXSC-<arg> in jira in firefox
  open -a firefox https://certisgroup.atlassian.net/browse/OTXSC-$1
}
