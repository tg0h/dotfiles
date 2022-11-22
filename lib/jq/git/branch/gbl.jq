include "pad";
include "date";
include "colour";
include "colour-out";
include "time-format";
include "math";
include "git/branch/formatCommitterDateAgo";
include "git/branch/formatCommitterDate";
include "rainbow-theme";
include "colour-scale";
include "grey-scale";
include "decoration";
include "sort";

def formatCommitterName:{
"CowBelleh": _christine("brian"), # aws orange
"Eri Sitohang": _cyan("Eri"),
"Gary": _mySin("gary"), # lakers colours
"Giggs": _rossoCorsa("Giggs"), # man u 
"GitHub": __("GitHub"), # bright green
"Glenn Sunkel": _sapphireBg("Glenn"), # new zealand
"Jared Tong": _tacha("Jared"), # rc colours
"Kel Vyn Ong": _danube("Kelvyn"), # sound of music
"Timothy Tan": _tan("TimTan"),
"chingyeow": _indianYellow("chingyeow"), # nepal buddist monk robes
"darrenong17": _beaver("darren"), # otter singaporean beaver geddit lol
"garyfoo88": _mySin("gary"), # lakers
"jasmined09": _morningGlory("jasmine"), # princess jasmine
"joel": _pinkFlamingo("joel"),
"tim goh": _steelPink("timg"),
"Chris Fraser": "Chris",
"Will Fong": "Will",
"Jason Nulla": "Jason",
};

# sub("(?:\/)(?<ticket>\\w+-\\d+)(?:\/)";(.ticket));
def subAfterOrigin: sub("(?:\/)(?<after>.*)";"/"+(.after|_cs0));
def subTicket: sub("(?:/)(?<ticket>\\w+-\\d+)(?:\/)";"/"+(.ticket|_y(.)+"/"));

def subOrigin: sub("(?<o>origin)";(.o)|_gs1);
def gSubSlash: gsub("/";"/"|_gs3);
def subRefsHeads: sub("refs/heads/";" ");
def subRefsRemotes: sub("refs/remotes/";" ");

def formatRemoteRef: sub("origin/(?<r>.*)";"origin/"+(.r|__(.)));
def formatLocalRef: sub("heads/(?<r>.*)";"heads/"+(.r|_orange(.)));
def formatMyLocalRef: sub("heads/(?<r>timg)";"heads/"+(_brinkPink(.r)));
def formatMyLocalRefName: sub("heads/timg/(?<r>.*)";"heads/timg/"+(_brinkPink(.r)));
def formatLocalMain: sub("heads/(?<r>main)";"heads/"+(_g(.r)));
def subRefsPrefix: 
  .
  | formatMyLocalRefName
  | formatMyLocalRef
  | formatLocalMain
  | formatLocalRef
  | formatRemoteRef
  | subTicket 
  | subRefsRemotes 
  | subRefsHeads 
  | gSubSlash
  | subOrigin 
  # | subAfterOrigin
;

# def formatRefName: __(.) | subRefsPrefix | __(.) ;
def formatRefName: subRefsPrefix ;

# accepts [ number, unit ]
def showAgo:
 .[0] as $time
 | .[1] as $unit
 | "\($time|lp(4)) \($unit)"
;

def formatTable:
  "\(.head) "
  +"\(.committerDateAgoHumanNumberRoundFormat | showAgo) "
  +"\(.commiterName| formatCommitterName[.]//. | lp(10)) "
  +"\(.committerDateFormat) "
  # +"\(.authorName)"
  +"\(.refNameFormat ) "
  # +"\(.upstream) "
  # +"\(.committerDate) "
  # +"\(.authorDate) "
  # +"\(.authorName|lp(20)) "
  +"\(.subject|_gs8) "
  +"\(.body | trunc(70) | _gs4 ) "
  ;

def _sortBy($sortBy; $rev):
  # if $sortBy == "" then sort_by(.CreatedAt) | reverse
  # elif $sortBy == "" then sort_by(._sortKey,.Repository)
  # elif $sortBy == "" then sort_by(._sizeKb) | reverse
  if $rev|not then
  sort_by( .sortKeyHead, .sortKeyLocal, .sortKeyCommitterName, .sortKeyGithub, (.commiterName|ascii_downcase), .committerDateSecondsAgo ) 
  else
    # if any (.sortKeyHead | length > 0)
    # then
      # reverse the sort but keep the currently checked out branch as the top branch
      sort_by( .sortKeyHead, .sortKeyLocal, .sortKeyCommitterName, .sortKeyGithub, (.commiterName|ascii_downcase), .committerDateSecondsAgo ) | ([.[0]] + ( .[1:] | sort_by( .sortKeyLocal, .sortKeyCommitterName, .sortKeyGithub, (.commiterName|ascii_downcase), .committerDateSecondsAgo )|reverse ))
    # else
    #   # if checked out branch does not exist (perhaps filtered out)
    #   # just reverse
    #   reverse
    # end
  end
  ;

def setSortKeyLocal: if (.refName | startswith("refs/heads")) then 0 else 99 end;
def setSortKeyHead: if .head == "*" then 0 else 99 end;
def setSortKeyGithub: if .commiterName == "GitHub" then 999 else .sortKeyCommitterName end;

def _committerNameSortOrder: [
"tim goh",
"chingyeow"
];


def filterCommitter($committerFilter):
  if $committerFilter == "all" then true
  elif $committerFilter == "me" then .commiterName == "tim goh" or .head == "*"
  elif $committerFilter == "team" then .commiterName == "tim goh" or .commiterName =="chingyeow" or .head == "*"
  else
    true
  end
;

def gbl($sortBy; $rev; $committerFilter):
  map(.committerDateSeconds = (.committerDate | ToSeconds) )
  # filter
  | map(select(filterCommitter($committerFilter)))

  # sort
  | map(.sortKeyHead = setSortKeyHead)
  | map(.sortKeyLocal = setSortKeyLocal)
  | addSortKey("commiterName";_committerNameSortOrder; "sortKeyCommitterName")
  | map(.sortKeyCommitterName = setSortKeyGithub)


  # process
  | map(.committerDateSecondsAgo = (now - .committerDateSeconds))
  | map(.committerDateDaysAgo = (now - .committerDateSeconds)/(24*60*60))
  | map(.committerDateAgoHumanNumber = (.committerDateSecondsAgo | TimeFormat))
  | map(.committerDateAgoHumanNumberRound = [(.committerDateAgoHumanNumber|RoundHumanTime), .committerDateAgoHumanNumber[1], .committerDateAgoHumanNumber[2]] ) 
  | map(.committerDateAgoHumanNumberRoundFormat = formatCommitterDateAgo(.committerDateAgoHumanNumberRound)) 
  | map(.committerDateObject= (.committerDateSeconds | ToLocalDateObject ) )
  | map(.committerDateFormatObject = (.committerDateSeconds | ToLocalDateFormatObject("ymdhM"))) 
  | map(.committerDateFormat = (formatCommitterDate(.committerDateObject;.committerDateFormatObject;.committerDateSecondsAgo)))
  | _sortBy($sortBy; $rev)
  # | if $rev then reverse else . end
  | map(.refNameFormat = (.refName|formatRefName))
  # | map(.committerDateAgoHumanUnit= .committerDateAgoHumanNumber[1]) 
  # map(.committerDateSecondsAgo = (.committerDate | ToSeconds) )
  # | map(.authorDateSeconds = (.authorDate | ToSeconds) )
  | map(formatTable)
  | .[]
;
