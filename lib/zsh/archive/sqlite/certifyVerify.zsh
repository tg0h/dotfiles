function clt(){
  # cognito whiteLisT
  # clt [-s|-e|-n] -r <reason> <userId> <userId2> ...
  # or pass userIds via stdin
  # cat <file> | clt [-s\-n\-e]
  # rg -o means --only-matching
  # eg bat timfix_2021-11-09T1339_emailFix.csv | rg -o 'SG\d+' | clt -e -r 'ignore email delete'
  # -s - add a whitelist record with type STAT2
  # -n - add a whitelist record with type NUM
  # -e - add a whitelist record with type EMAIL

  local type pipe reason sql prefix

  if [[ -p /dev/stdin ]]
  then
    pipe=$(cat -)
    # echo "PIPE=$PIPE"
  fi
  # echo $pipe

  while getopts 'sner:' opt; do
    case "$opt" in
      s) type="Stat2";;
      n) type="Num";;
      e) type="Email";;
      r) reason=$OPTARG;;
      # p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  # prefix="${prefix:-SG}"- # add trailing - to prefix, eg ARG- in ARG-1234
  users=${pipe:-$@} # get from pipe, else get from args
  # echo users are $users

  for user in ${=users}; do
    if [[ $user != SG* ]]; then  # use globbing to detect substring -
      # echo user is $user
      user=SG$user
    else
    fi
    sql=$(cat <<-EOF
  insert into errorwhitelist_type
         (
          GlobalId,
          Type,
          Reason,
          CreateDate
         )
  VALUES (
          '$user',
          '$type',
          '$reason',
          datetime('now','localtime')
         );
EOF
)
# sqlite3 cognito_verify.sqlite3 "insert into errorwhitelist_type (GlobalId,Type,Reason,CreateDate) VALUES ('SG1234','STAT2','a reason',datetime('now','localtime'));"
sqlite3 $_CERTIFY_VERIFY_DB $sql
done
}

function cltg(){
  # clt get
  # get top 20 rows from error whitelist
  # cltg 1234 - search for user 1234 in the whitelist

  sql=$(cat <<-EOF
      select * from errorwhitelist_type where GlobalId like '%$1%'order by ID desc limit 30
EOF
)
[[ -n $_CERTIFY_VERIFY_DB ]] && sqlite3 $_CERTIFY_VERIFY_DB $sql
}

function cltd(){
  # certify whitelist delete
  # cltd [-s|-n|-e] <userId> <userId> ...

  local type pipe reason sql prefix

  if [[ -p /dev/stdin ]]
  then
    pipe=$(cat -)
    # echo "PIPE=$PIPE"
  fi
  # echo $pipe

  while getopts 'sne' opt; do
    case "$opt" in
      s) type="Stat2";;
      n) type="Num";;
      e) type="Email";;
      # p) prefix=$OPTARG;;
    esac
  done
  shift $(($OPTIND - 1))

  users=${pipe:-$@} # get from pipe, else get from args
  # echo users are $users

  for user in ${=users}; do
    if [[ $user != SG* ]]; then  # use globbing to detect substring -
      # echo user is $user
      user=SG$user
    fi

    sql=$(cat <<-EOF
      delete from errorwhitelist_type where GlobalId = '$user' and type = '$type'
EOF
)

  echo deleting user $user and type $type from db 
  # [[ -n $_CERTIFY_VERIFY_DB ]] && sqlite3 $_CERTIFY_VERIFY_DB $sql
done
}
