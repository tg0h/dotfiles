include "pad";
include "date";
include "colour";
include "colour-out";
include "time-format";
include "math";
include "git/log/formatCommitterDateAgo";
include "git/log/formatCommitterDate";
include "candy/git/committerName"; # in jq config folder
include "grey-scale";
include "decoration";
include "git/conventional-commit";
include "hyperlink";
include "null";

# TODO: get remote url
# add hyperlink to hash
# eg https://github.com/anafore/referralcandy-main/commit/7c4e9

# accepts [ number, unit ]
def showAgo:
 .[0] as $time
 | .[1] as $unit
 | "\($time|lp(4)) \($unit)"
;

def formatTable:
  "\(.committerDateFormat) "
  +"\(.committerDateAgoHumanNumberRoundFormat | showAgo) "
  # +"\(.committerMailMapName| formatCommitterName[.] //. | lp(5)) "
  +"\(.authorMailMapName| formatCommitterName[.] //. | lp(5)) "
  +"\(.commitHash | .[0:8] | __(.)) "

  # +"\(.authorMailMapEmail | lp(25)) "
  # +"\(.authorName | lp(15)) "
  # +"\(.authorEmail|_y(.) ) "
  # +"\(.refNameFormat ) "
  # +"\(.upstream) "
  # +"\(.committerDate) "
  # +"\(.authorDate) "
  # +"\(.authorName|lp(20)) "

  # +"\(.subject|_gs8) "
  +"\(.subjectFormatString)"
  +"\(.subjectPullRequestNumberHyperlink//"")"
  +" "
  +"\(.subjectTicketIdHyperlink//"")"
  # +"\(.body | trunc(70) | _gs4 ) "
  +"\(.trailers)"
  ;

# https://anafore.atlassian.net/browse/SEG-37

def captureTicketId:
# remove the # in regex to accept SEG-20 or #mc-12
  capture("(?<ticketId>\\w{1,7}\\-\\d+)") + {"isTicketIdFound" : true, "subject": .} 
  //  {"isTicketIdFound" : false, "subject": .}
  ;
def addTicketIdUrl:
  if (.isTicketIdFound == true) then
   "https://anafore.atlassian.net/browse/"+.ticketId
  else
    null
  end
  ;
def addTicketIdHyperlink($linkText):
  hyperlink(_b($linkText))
  ;

def addSubjectTicketIdHyperlink:
  .subjectTicketId.ticketId as $linkText
  | .subjectTicketIdHyperlink = (.subjectTicketIdUrl | isNotNull(addTicketIdHyperlink($linkText)))
  ;


def capturePullRequestNumber:
  capture("\\(#(?<pullRequestNumber>(\\d)+)\\)") + {"isPullRequestNumberFound": true }// {"isPullRequestNumberFound": false, "input": . }
  | if (.isPullRequestNumberFound == true) then 
    .pullRequestNumber|tostring as $prNumber |
     { 
      pullRequestNumber: $prNumber, 
      pullRequestNumberString: "#\($prNumber|tostring)",
    }
    else . end
  ;
def addPullRequestNumberHyperlink($prNumber):
  if ($prNumber != null) then
  "https://github.com/Anafore/referralcandy-main/pull/"+($prNumber|tostring)
  else null end
  ;

def addSubjectPullRequestNumberHyperlink:
  .subjectPullRequestNumber as $prNumber
  | .subjectPullRequestNumberUrl as $prNumberUrl
  | $prNumber.pullRequestNumberString as $prNumberString
  | .subjectPullRequestNumberHyperlink = ($prNumberUrl|hyperlink($prNumberString|_tacha(.)))
  ;

def glo($sortBy; $rev; $committerFilter):
  # map(.committerDateSeconds = (.committerDate | ToSeconds) )
  # # filter
  # | map(select(filterCommitter($committerFilter)))
  #
  # # sort
  # | map(.sortKeyHead = setSortKeyHead)
  # | map(.sortKeyLocal = setSortKeyLocal)
  # | addSortKey("commiterName";_committerNameSortOrder; "sortKeyCommitterName")
  # | map(.sortKeyCommitterName = setSortKeyGithub)
  #
  #
  # # process
  map(.committerDateSecondsAgo = (now - .committerDateUnix))
  # | map(.committerDateDaysAgo = (now - .committerDateSeconds)/(24*60*60))
  | map(.committerDateAgoHumanNumber = (.committerDateSecondsAgo | TimeFormat))
  | map(.committerDateAgoHumanNumberRound = [(.committerDateAgoHumanNumber|RoundHumanTime), .committerDateAgoHumanNumber[1], .committerDateAgoHumanNumber[2]] ) 
  | map(.committerDateAgoHumanNumberRoundFormat = formatCommitterDateAgo(.committerDateAgoHumanNumberRound)) 
  | map(.committerDateObject= (.committerDateUnix | ToLocalDateObject ) )
  | map(.committerDateFormatObject = (.committerDateUnix | ToLocalDateFormatObject("ymdhM"))) 
  | map(.committerDateFormat = (formatCommitterDate(.committerDateObject;.committerDateFormatObject;.committerDateSecondsAgo)))

  | map(.subjectFormatObject = (.subject|parseSubject))
  | map(.subjectFormatString = (.subjectFormatObject|formatSubject))
  | map(.subjectPullRequestNumber = (.subject | capturePullRequestNumber))
  | map(.subjectPullRequestNumberUrl= addPullRequestNumberHyperlink(.subjectPullRequestNumber.pullRequestNumber))
  # | map(.subjectPullRequestNumberHyperlink= (.subjectPullRequestNumberUrl|isNotNull(hyperlink)))
  | map(addSubjectPullRequestNumberHyperlink)
  | map(.subjectTicketId = (.subject | captureTicketId))
  | map(.subjectTicketIdUrl = (.subjectTicketId | addTicketIdUrl))
  # | map(.subjectTicketIdHyperlink = (.subjectTicketIdUrl | isNotNull(addTicketIdHyperlink)))
  | map(addSubjectTicketIdHyperlink)
  # | _sortBy($sortBy; $rev)
  # # | if $rev then reverse else . end
  # | map(.refNameFormat = (.refName|formatRefName))
  | map(formatTable)
  | .[]
;
