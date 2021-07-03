#TODO: verbose flag - more columns
#TODO: environment sensitive commands
#TODO: refactor commands for host, port and database
#TODO: why is user_roles, users_orgs,orgs,accounts in auth and users db? which one to use?
#TODO: why is user_auths in users db?  - it is useless
#TODO: configuration file - 9 Aug 20 - done
#TODO: /usr/local/share/zsh/site-functions/_rg - study rg zsh completion file

# dependencies -
# use mysqlsh's credential store helper to remember your password
# "credentialStore.helper": "keychain",
# "credentialStore.savePasswords": "always"

#ports 0 to 1023 are reserved

function dbconn-argus() {
  _kill_argus_db_ports

  # ssh -N -L <local port>:<destination ip>:<remote port> <ssh user>:<ssh host>
  # the ssh host forwards your <localhost>:<local port> to the <destination ip>:<remote port>
  # if there are problems with this command, eg it suspends immediately, run the actual ssh command without putting it in the bacground (without &)
  # some possible errors:
  # ssh key permissions
  # need to add host fingerprint
  # _kill_argus_db_ports did not kill the port (eg because a new environment added new ports)
  ssh -N -L $_ARGUS_RDS_DB_USER_LOCAL_PORT:$_ARGUS_RDS_DB_USER_HOST $_ARGUS_RDS_SSH_USER@$_ARGUS_RDS_SSH_HOST -i $_ARGUS_RDS_SSH_KEY &
  ssh -N -L $_ARGUS_RDS_DB_AUTH_LOCAL_PORT:$_ARGUS_RDS_DB_AUTH_HOST $_ARGUS_RDS_SSH_USER@$_ARGUS_RDS_SSH_HOST -i $_ARGUS_RDS_SSH_KEY &
}

function _kill_argus_db_ports() {
  for pid in $(dbconn-get | awk {'if(NR>1) print $2'}) ## get pids of processes listening on rds ssh's
  do
    kill $pid > /dev/null #supress output
  done
}

#get all the pids of processes listening at these ports
alias dbconn-get='lsof -Pi tcp@localhost:1100,1101,1200,1201,1210,1211,1300,1301,1400,1401' #-P do not resolve port numbers to port names so you can see 1100 instead of something else


# ALL
function dball() {
  dbuu $1
  dbaua $1
}

## switch env
argp () {
  if [[ -z "$1" ]]
  then
    # unset AWS_DEFAULT_PROFILE AWS_PROFILE AWS_EB_PROFILE
    # echo AWS profile cleared.
    echo $_ARGUS_PROFILE
    return
  fi
  # local -a available_profiles
  # available_profiles=($(aws_profiles))
  # if [[ -z "${available_profiles[(r)$1]}" ]]
  # then
  #   echo "${fg[red]}Profile '$1' not found in '${AWS_CONFIG_FILE:-$HOME/.aws/config}'" >&2
  #   echo "Available profiles: ${(j:, :)available_profiles:-no profiles found}${reset_color}" >&2
  #   return 1
  # fi
  _setArgusProfile $1
}

function _setArgusProfile() {
  local argus_profile
  case $1 in
    d) argus_profile="development"
      _ARGUS_PROFILE="development"
      . ~/.argus/argus.develop.env
      vpn
      dbconn-argus #automatically open ssh ports
      asp adev #switch aws profile to dev
      ;;
    s) argus_profile="staging"
      . ~/.argus/argus.staging.env
      vpn
      dbconn-argus #automatically open ssh ports
      asp adev #switch aws profile to dev
      ;;
    as) argus_profile="au staging"
      . ~/.argus/argusAu.staging.env
      vpn
      dbconn-argus #automatically open ssh ports
      asp aastg #switch aws profile to au staging
      ;;
    p) argus_profile="production"
      vpn
      . ~/.argus/argus.production.env
      dbconn-argus #automatically open ssh ports
      asp aprod #switch aws profile to prod
      ;;
    ap) argus_profile="au prod"
      . ~/.argus/argusAu.production.env
      vpn
      dbconn-argus #automatically open ssh ports
      asp aaprod #switch aws profile to au staging
      ;;
  esac

  export _ARGUS_PROFILE=$argus_profile
}

# users db

function dbuu() {
  print '====================================== users         ========================================='
  _dbuusers $1
  print '====================================== teams         ========================================='
  _dbuteams $1
  print '====================================== user orggrps  ========================================='
  _dbuorg-groups $1
  print '====================================== user roles    ========================================='
  _dbuuser_roles $1
  # print '====================================== user auths??  ========================================='
  # _dbuuser_auths $1
  print '====================================== accounts     ========================================='
  _dbuaccounts
}

#team details
function dbut() {
  print '====================================== team         ========================================='
  _dbuGetTeam $1
  print '====================================== users         ========================================='
  _dbuGetTeamUsers $1
  print '====================================== clients       ========================================='
  _dbuGetTeamClients $1
}

function _dbuGetTeam() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select t.name, t.active, t.id as teamId
from teams t
where UPPER(t.name) like UPPER('%$1%')
order by t.name
EOF
}

function _dbuGetTeamUsers() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select t.name, u.staff_id
from users u
         inner join users_teams ut on u.id = ut.user_id
         inner join teams t on ut.team_id = t.id
where UPPER(t.name) like UPPER('%$1%')
order by t.name, u.staff_id
EOF
}

function _dbuGetTeamClients() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select t.name as team, c.name as client, c.id as clientId
from clients c
         inner join clients_teams ct on c.id = ct.client_id
         inner join teams t on ct.team_id = t.id
where UPPER(t.name) like UPPER('%$1%')
order by t.name, c.name
EOF
}

#get all the teams and all the users
function dbutu() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select t.name, u.staff_id, t.id, u.id
from users u
         inner join users_teams ut on u.id = ut.user_id
         inner join teams t on ut.team_id = t.id
order by t.name, u.staff_id
EOF
}
#
#get all the teams and all the clients
function dbutc() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select t.name as team, c.name as client, t.id, c.id
from clients c
         inner join clients_teams ct on c.id = ct.client_id
         inner join teams t on ct.team_id = t.id
order by t.name, c.name
EOF
}

#helper function for dynamodb. very useful as dynamo db does not have staff id and requires user id
function _dbGetUserId() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=json << EOF | jq -r .id
select id
from users
where staff_id = '$1'
EOF
}

#helper function for dynamodb.
function _dbGetAccountId() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=json << EOF | jq -r .id
select id
from accounts
where UPPER(name) = UPPER('$1')
EOF
}

#helper function for dynamodb.
function _dbGetOrganizationId() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=json << EOF | jq -r .id
select id
from organizations
where UPPER(name) = UPPER('$1')
EOF
}

#helper function for dynamodb. AUTH db
function _dbGetAppId() {
  # eg _dbGetAppId CAS a - get the app id of CAS Argus Officer

  local appName
  case $2 in
    a) appName='Argus Officer';;
    m) appName='Argus Supervisor';;
    cc) appName='Argus Admin';;
  esac

  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=json << EOF | jq -r .id
select apps.id,
       a.name,
       apps.appId,
       apps.appName
       # apps.checkDevice,
       # apps.createdAt,
       # apps.updatedAt
from apps
         inner join accounts a on apps.accountId = a.id
where (appId REGEXP '.admin\$|.dev\$|.staging\$'
    or appId REGEXP '.officer\$|.staging\$') #in production, appId does not have an environment suffix
  and a.name = '$1'
  and apps.appName like '%$appName%'
order by a.name, appId
EOF
}


function _dbuusers-Id() {
  # mysqlsh --sql -u useradmin -h 127.0.0.1 -P 1300 -D argus_users  -e "select * from users where staff_id = 'tim'"
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=json << EOF | jq .
select *
from users
where id = '$1'
EOF
}

function _dbuusers() {
  # mysqlsh --sql -u useradmin -h 127.0.0.1 -P 1300 -D argus_users  -e "select * from users where staff_id = 'tim'"
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=json << EOF | jq .
select *
from users
where staff_id = '$1'
EOF
}

# function _dbuorg-groups() {
#   mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
# select
#     u.staff_id,
#     a.name as acc,
#     o.name as org,
#     o.id as orgId,
#     g.name as grp,
#     g.id as grpId,
#     ug.role
# from users u
#          inner join users_groups ug on u.id = ug.user_id
#          inner join groups g on ug.group_id = g.id
#          inner join organizations o on g.org_id = o.id
#          inner join accounts a on o.account_id = a.id
# where u.staff_id like '$1'
# order by a.name, o.name, g.Name, ug.role
# EOF
# }

function _dbuteams() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select u.staff_id,
       t.name
from users u
         inner join users_teams ut on u.id = ut.user_id
         inner join teams t on ut.team_id = t.id
where u.staff_id like '$1'
EOF
}


function _dbuorg-groups() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select u.staff_id,
       a.name as acc,
       p.name as parent,
       o.name as org,
       o.type as type,
       o.id   as orgId
from users u
         inner join users_organizations uo on u.id = uo.user_id
         inner join organizations o on uo.org_id = o.id
         inner join organizations p on o.parent_id = p.id
         inner join accounts a on o.account_id = a.id
where u.staff_id like '$1'
order by a.name, p.name, o.name, o.Name, o.type
EOF
}


function _dbuaccounts() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select name,
       id
from accounts
where active = 1
EOF
}

function dbuasync_tasks() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select
        a.name 'account name',
        at.*
from async_tasks at
        inner join accounts a on at.account_id = a.id
order by at.started_at DESC
limit 10
EOF
}

function dbuemail_templates() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME -e "select * from email_templates" --result-format=json/pretty
}

function dbugroups() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME -e "select * from groups where name = '$1'" --result-format=table
}

function dbuorgs() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME -e "select * from organizations where name = '$1'" --result-format=table
}

function dbuorgs-id() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME -e "select * from organizations where id = '$1'" --result-format=table
}


function _dbuuser_roles() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_USER_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_USER_LOCAL_PORT -D $_ARGUS_RDS_DB_USER_NAME --result-format=table << EOF
select u.staff_id,
       # ur.user_id,
       ur.role_id,
       CASE ur.role_id
           WHEN 1 THEN 'admin'
           WHEN 2 THEN 'officer'
           WHEN 3 THEN 'supervisor'
           WHEN 4 THEN 'account owner'
           WHEN 5 THEN 'manager'
           WHEN 6 THEN 'operator'
           ELSE 'LOL'
           END as role
from users_roles ur
         inner join users u on ur.user_id = u.id
where u.staff_id = '$1'
EOF
}


# auth db ################################################################################################
function dbaua() {
  # EXAMPLES:
  # dbaua -u 100 - get data from user 100

  local staffId
  local rows=5
  while getopts 'n:u:' opt; do
    case "$opt" in
      n) rows=$OPTARG ;;
      u) staffId=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))

  print '====================================== user auths    ========================================='
  _dbauser_auths $staffId
  print '====================================== login attempts ========================================='
  _dbalogin_attempts -u $staffId -n $rows
  print '====================================== users devices  ========================================='
  _dbausers_devices $staffId
  print '====================================== phone regs     ========================================='
  _dbaphone_regs $staffId
}

function _dbauser_auths() {
  # mysqlsh --sql -u authadmin -h 127.0.0.1 -P 1301 -D argus_auth  -e "select 1 from user_auths"
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=json << EOF | jq .
select ua.id,
#        ua.accountId,
       a.name as acc,
       ua.staffId,
       ua.active,
       ua.passwordHash,
       ua.passwordSalt,
       ua.phone,
       ua.photoUrl,
       ua.failures,
       ua.status,
       ua.lockout,
       ua.lastSigninAt,
       ua.registeredAt,
       ua.createdAt,
       ua.updatedAt
from user_auths ua
         inner join accounts a on ua.accountId = a.id
where staffId = '$1'
EOF
}


function _dbaaccount_resets() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select
       ua.staffId,
#        ar.userId,
       ar.resetCode,
       ar.expiredAt,
       ar.resetAt
from account_resets ar
         inner join user_auths ua on ua.id = ar.userId
where staffId = '$1'
order by expiredAt desc
EOF
}

function _dbaapps() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select apps.id,
       a.name,
       apps.appId,
       apps.appName,
       apps.checkDevice,
       apps.createdAt,
       apps.updatedAt
from apps
         inner join accounts a on apps.accountId = a.id
order by a.name,appId
EOF
}

#not useful
function _dbaapps_roles() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select a.name,
       apps.appId,
#        r.id,
       r.name,
       r.isDefault,
       r.services,
       r.organizations,
       r.actions,
       r.isAdmin
from apps
         inner join accounts a on apps.accountId = a.id
         inner join apps_roles ar on apps.Id = ar.appId
         inner join roles r on ar.roleId = r.id
order by a.name, apps.appId
EOF
}

#not useful
function _dbalogin_attempts() {
  # EXAMPLES:
  # _dbalogin_attempts -n 20 -u SG123456 - get last 20 attempts for user SG123456
  # _dbalogin_attempts -u SG123456 - get last 5 rows for user SG123456

  local rows=5
  local staffId
  while getopts 'n:u:' opt; do
    case "$opt" in
      n) rows=$OPTARG ;;
      u) staffId=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select
       a.name,
       la.staffId,
#        la.userId, #user_auth id
       apps.appName,
       apps.appId,
       apps.id,
       la.ipAddress,
       la.deviceId,
       la.api,
       la.app,
       la.status,
       la.reason,
       la.method,
       la.similarity,
       la.createdAt
from login_attempts la
         inner join accounts a on la.accountId = a.id
         inner join apps on la.appId = apps.Id
where staffId = '$staffId'
order by createdAt desc
limit $rows
EOF
}


#not useful
function _dbaphone_regs() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select
#        a.name,
       ua.staffId,
#        pr.userId,
       pr.appId,
       apps.appName,
       pr.deviceId,
       pr.phone,
       pr.regCode,
       pr.regPin,
       pr.photo1,
       pr.photo2,
       pr.similarity,
       pr.expiredAt,
       pr.verifiedAt,
       pr.completedAt
from phone_regs pr
         inner join user_auths ua on ua.id = pr.userId
         inner join accounts a on ua.accountId = a.id
         inner join apps on  pr.appId = apps.id
where ua.staffId = '$1'
order by expiredAt desc
limit 5
EOF
}


function _dbausers_devices-deviceToken() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select ua.staffid,
       ua.id userId,
       a.appid,
       acc.name appAccount,
#        ud.userauthid,
       ud.appid,
       ud.deviceid,
       ud.devicetoken,
       # substr(ud.devicetoken, 1, 10) devicetoken10,
       ud.endpointarn
from users_devices ud
         inner join user_auths ua on ud.userauthid = ua.id
         inner join apps a on ud.appid = a.id
         inner join accounts acc on acc.id = a.accountId
where ud.deviceToken like 'os%'
EOF
}

function _dbausers_devices() {
  mysqlsh --sql -u $_ARGUS_RDS_DB_AUTH_USER -h 127.0.0.1 -P $_ARGUS_RDS_DB_AUTH_LOCAL_PORT -D $_ARGUS_RDS_DB_AUTH_NAME --result-format=table << EOF
select ua.staffid,
       ua.id userId,
       a.appid,
       acc.name appAccount,
#        ud.userauthid,
       ud.appid,
       ud.deviceid,
       ud.devicetoken,
       # substr(ud.devicetoken, 1, 10) devicetoken10,
       ud.endpointarn
from users_devices ud
         inner join user_auths ua on ud.userauthid = ua.id
         inner join apps a on ud.appid = a.id
         inner join accounts acc on acc.id = a.accountId
where ua.staffid = '$1'
EOF
}
