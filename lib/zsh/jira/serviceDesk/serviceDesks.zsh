function sdd(){
  local result
  result=$(rcache "$@" 'jira/sdd.604800' '_sdd')

  local jqQuery=$(cat <<-EOF
  include "pad"; .values[] | "\(.id| tostring | lpad(2;" ")) - \(.projectName)"
EOF
)
  # echo $result
  jq --raw-output -L "~/.config/jq" $jqQuery <<< $result | rg 'Argus|Optimax' | sort -r
}

function _sdd(){
    https -b -a $JIRA_SECRET $JIRA_API_SD_URL/servicedesk
}
