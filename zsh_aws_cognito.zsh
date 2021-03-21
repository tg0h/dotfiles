# TODO: awslogs get  sns/ap-southeast-1/474132418168/DirectPublishToPhoneNumber -s '9/1/2020 00:00' -e '9/1/2020 02:00' > certify_sms_publish

## switch env
cerp () {
  if [[ -z "$1" ]]
  then
    echo $_CERTIFY_PROFILE
    return
  fi

  _setCertifyProfile $1
}

function _setCertifyProfile() {
  local certify_profile
  case $1 in
    d) certify_profile="development"
      . ~/dotfiles/certify.develop.env
      asp cd #switch to aws cd profile using the zsh aws plugin
      ;;
    s) certify_profile="staging"
      . ~/dotfiles/certify.staging.env
      asp cd
      ;;
    p) certify_profile="production"
      . ~/dotfiles/certify.production.env
      asp cp #switch to aws cp profile using the zsh aws plugin
      ;;
  esac

  export _CERTIFY_PROFILE=$certify_profile
}

##certify
ccon() { sqlite3 $_CERTIFY_VERIFY_DB }
czc() { cd $_CERTIFY_COGNITO_LOCAL_FOLDER }
czu() { cd $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER }
czr() { cd $_CERTIFY_S3_BUCKET_SAP_SYNC_REPORTS_LOCAL_FOLDER }
czrr() { cd $_CERTIFY_VERIFY_REPORT_FOLDER }

#get user details
function cget() {
# examples:
# note that options MUST come before user id
# cget -p HK 125387 # search for user HK125387
# cget 125387 # search for user SG125387
# cget -s 125387 # search for user SG125387

  local userPrefix="SG" #default
  local summary="" #if summary, do not print s3 folder and sync results

  #note that there is no colon after s, which indicates that s does not expect a value to be supplied
  while getopts 'p:s' opt; do
    case "$opt" in
      p) userPrefix=$OPTARG ;;
      s) summary=true;;
    esac
  done
  shift $(($OPTIND - 1))
  local userName=$userPrefix$1

  # TODO: add colour to fields
  # aws cognito-idp admin-get-user --user-pool-id $_CERTIFY_POOL_ID --username "SG$1" | jq '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | {Username,employee_id: $fields."custom:employee_id",name: $fields.name,given_name: $fields.given_name,family_name: $fields.family_name,"employment_status>>>>>>>>>>>>>>>>>>>>": $fields."custom:employment_status",join_date: $fields."custom:join_date",UserStatus,phone_number_verified: $fields.phone_number_verified,"phone_number>>>>>>>>>>>>>>>>>>>>": $fields.phone_number, email_verified: $fields.email_verified, "email>>>>>>>>>>>>>>>>>>>>": $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserCreateDate,UserLastModifiedDate}'
  aws cognito-idp admin-get-user --user-pool-id $_CERTIFY_POOL_ID --username $userName  | jq '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | {Username,employee_id: $fields."custom:employee_id",name: $fields.name,given_name: $fields.given_name,family_name: $fields.family_name,"employment_status>>>>>>>>>>>>>>>>>>>>": $fields."custom:employment_status",join_date: $fields."custom:join_date",UserStatus,phone_number_verified: $fields.phone_number_verified,"phone_number>>>>>>>>>>>>>>>>>>>>": $fields.phone_number, email_verified: $fields.email_verified, "email>>>>>>>>>>>>>>>>>>>>": $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserCreateDate,UserLastModifiedDate}'
  _cgetLastLoginStatus $userName

  # if summary is not true, print s3 data and sync data
  if  [[ -z $summary ]]
  then
    crgs $userName #search s3 folder for empId
    echo "##### SYNC REPORT ####"
    crgsu $userName #search s3 report folder for sync report for this user
  fi
}

#expects EE ID
crgs () {
  rg "($1,).*(,NUM|,C_EMAIL|,P_EMAIL|,STAT2|,USRID_LONG)" $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER --sortr created
}

crgsu () {
  rg "($1),(NUM|C_EMAIL|P_EMAIL|STAT2|USRID_LONG)" $_CERTIFY_S3_BUCKET_SAP_SYNC_REPORTS_LOCAL_FOLDER --sortr created
}

clog () {
  # awslogs get  /aws/lambda/Certify-SapSync-prod -s '29/9/2020' -e '30/9/2020'
  awslogs get  /aws/lambda/Certify-SapSync-prod -s $1 -e $2
}

clogs () {
  # awslogs get  /aws/lambda/Certify-SapSync-prod -s '29/9/2020' -e '30/9/2020'
  awslogs get  /aws/lambda/Certify-ScheduledSync-prod -s $1 -e $2
}
function cpatche(){
  cpatch $1 > $1.csv && vim $1.csv
}

function cpatch(){
  while getopts 'r' opt; do
    case "$opt" in
      r) local r=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  local empIds
  if (( $# == 0 )); then
    read -d '' empIds #shell behaviour? - the first command reads from stdin. -d do not use newline as delimiter to read entire input
  else
    empIds=$@
  fi
  {
    if ! [[ -v r ]]; then # if not raw, show column headers
      echo "EE ID","Global ID","Start Date","End Date","FieldName","Field Value","Status"
    fi
    for empId in ${=empIds} #zsh param expansion to word split param, see man zshexpn, ${=spec}
    do
      rg -I "(SG$empId).*(NUM|EMAIL|STAT|USRID_LONG)" $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER --sortr created
    done
  }
}

#deleteuser details
# eg ccreate -n 'timmy' 125391
function ccreate() {
  local handphone="+***REMOVED***" #default
  local email="dasonteuh@hotmail.com" #default
  local name="Timtesty" #default

  while getopts 'e:p:n:' opt; do
    case "$opt" in
      e) email=$OPTARG ;;
      n) name=$OPTARG
        echo $name;;
      p) handphone=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))

  aws cognito-idp admin-create-user \
    --user-pool-id $_CERTIFY_POOL_ID \
    --username SG$1 \
    --temporary-password ***REMOVED*** \
    --message-action SUPPRESS \
    --user-attributes \
    Name=custom:employee_id,Value="$1" \
    Name=given_name,Value="$name" \
    Name=family_name,Value="Goh" \
    Name=email,Value="$email" \
    Name=phone_number,Value="$handphone" \
    Name=custom:company,Value="1000" \
    Name=custom:organization,Value="50794952" \
    Name=custom:department,Value="Tech Planning & Development" \
    Name=custom:staff_type,Value="O0001" \
    Name=custom:employment_status,Value="3" \
    Name=custom:working_home,Value="C100" \
    Name=custom:personal_email,Value="$email" \
    Name=custom:legal_home,Value="C400" \
    Name=custom:join_date,Value="20191111"\
  }


#deleteuser details
function cdel() {
  aws cognito-idp admin-delete-user --user-pool-id $_CERTIFY_POOL_ID --username "SG$1"
}


#get user details raw
function cgetr() {
  aws cognito-idp admin-get-user --user-pool-id $_CERTIFY_POOL_ID --username "SG$1"
}


#get the user values without the column headers
function cgetcsvrow() {
  # aws cognito-idp admin-get-user --user-pool-id ap-southeast-1_Q5BSv9IX7 --username "SG$1" | jq '.UserAttributes[] | select(.Name | endswith("email") or endswith("phone_number") or endswith("employee_id") or endswith("staff_type"))'
  aws cognito-idp admin-get-user --user-pool-id $_CERTIFY_POOL_ID --username "SG$1" | jq --raw-output '(.UserAttributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username,employee_id: $fields."custom:employee_id",name: $fields.name,given_name: $fields.given_name,family_name: $fields.family_name,employment_status: $fields."custom:employment_status",join_date: $fields."custom:join_date",UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified, email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserCreateDate,UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | map([.[ $keys[] ]])[] | @csv'
}

function cgetcsv() {
  if (( $# == 0 ));
  then echo "no args passed!"
  else
    echo '"Username","employee_id","name","given_name","family_name","employment_status","join_date","UserStatus","phone_number_verified","phone_number","email_verified","email","company_email","personal_email","UserCreateDate","UserLastModified"'
    for i #without in ... this reads the positional params
    do cgetcsvrow $i
    done
  fi
}

function cgetscsv() {
  # TODO: run this in parallel with a named pipe?
  if (( $# == 0 ));
  then echo "no args passed!"
  else
    echo '"Username","EventResponse","EventType","CreationDate","RiskDecision","CompromisedCredentialsCreated","ChallengeName","ChallengeResponse"'
    for i #without in ... this reads the positional params
    do cgetscsvrow $i
    done
  fi
}

#get the user values without the column headers
function cgetscsvrow() {
  aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username SG$1 | jq --raw-output ".AuthEvents[0] | [$1,.EventResponse,.EventType,.CreationDate,.EventRisk.RiskDecision,.EventRisk.CompromisedCredentialsDetected,.ChallengeResponses[0].ChallengeName,.ChallengeResponses[0].ChallengeResponse] | @csv"
}

function _cgetLastLoginStatus() {
  aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username $1 | jq '.AuthEvents[0] | {EventResponse,EventType,CreationDate,EventRisk,ChallengeResponses}'
}

#get last 5 login attempt statuses
function cgets() {
  local userPrefix="SG" #default
  local n=6 #default to get 5 items
  while getopts 'n:p:' opt; do
    case "$opt" in
      n) n=$OPTARG ;;
      p) userPrefix=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))

  local userName=$userPrefix$1

  # aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username SG$1 | jq '.AuthEvents[0:6][] | {EventResponse,EventType,CreationDate,EventRisk,ChallengeResponses}'
  aws cognito-idp admin-list-user-auth-events --user-pool-id $_CERTIFY_POOL_ID --username $userName | jq ".AuthEvents[0:$n][] | {EventResponse,EventType,CreationDate,EventRisk,ChallengeResponses}"
}

## cognito pool operations
csync() {
  #sync source to destination (one way)
  #source is the users uploads dir
  #include only works if you exclude everything first
  #include and excludes filter is relative to source folder
  #eg if your s3 is s3//bucket/folder/tim and your source is s3//bucket/folder
  #and you want to exclude tim, specify /tim not s3//bucket/folder/tim
  aws s3 sync $_CERTIFY_S3_BUCKET_SAP_SYNC $_CERTIFY_S3_BUCKET_SAP_SYNC_LOCAL_FOLDER --exclude "*" --include "*.csv" --include "*.CSV" --exclude "hk/*"
  aws s3 sync $_CERTIFY_S3_BUCKET_SAP_SYNC_REPORTS $_CERTIFY_S3_BUCKET_SAP_SYNC_REPORTS_LOCAL_FOLDER
}

cupload() {
  # TODO: what happens if $has spaces?
  local basename=$(basename $1)
  aws s3 cp $1 "$_CERTIFY_S3_BUCKET_SAP_SYNC$basename"
}

# cognito list users
clu() {
  aws cognito-idp list-users --user-pool-id $_CERTIFY_POOL_ID > $_CERTIFY_COGNITO_LOCAL_DB
}

clu2csv() {
  jq --raw-output '.Users[] | (.Attributes | map( {(.Name) : .Value}) | add ) as $fields | [{Username, employee_id: $fields."custom:employee_id",name: $fields.name,given_name: $fields.given_name,family_name: $fields.family_name,employment_status: $fields."custom:employment_status", join_date: $fields."custom:join_date",UserStatus,phone_number_verified: $fields.phone_number_verified, phone_number: $fields.phone_number, email_verified: $fields.email_verified,email: $fields.email,company_email: $fields."custom:company_email", personal_email: $fields."custom:personal_email",UserCreateDate,UserLastModifiedDate}] | (.[0] | keys_unsorted) as $keys | map([.[ $keys[] ]])[] | @csv'  \
    < $_CERTIFY_COGNITO_LOCAL_DB \
    > $_CERTIFY_COGNITO_LOCAL_DB.csv
  }

