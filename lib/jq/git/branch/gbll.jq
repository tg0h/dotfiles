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

def formatCommitterName:{
"CowBelleh": _christine("brian"), # aws orange
"Eri Sitohang": _cyan("Eri"),
"Gary": _mySin("gary"), # lakers colours
"Giggs": _rossoCorsa("Giggs"), # man u 
"GitHub": _freeSpeechGreen("GitHub"), # bright green
"Glenn Sunkel": _sapphireBg("Glenn"), # new zealand
"Jared Tong": _brinkPink("Jared"), # rc colours
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

def subOrigin: sub("(?<o>origin)";(.o)|_purple(.));
def gSubSlash: gsub("/";"/"|_gs3);
def subRefsHeads: sub("refs/heads/";" ");
def subRefsRemotes: sub("refs/remotes/";" ");
def formatRemoteRef: sub("origin/(?<r>.*)";"origin/"+(.r|_rb9));
def formatLocalRef: sub("heads/(?<r>.*)";"heads/"+(.r|_rb5));
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
  +"\(.committerDateFormat) "
  +"\(.commiterName| formatCommitterName[.]//. | lp(10)) "
  +"\(.refNameFormat ) "
  # +"\(.upstream) "
  # +"\(.committerDate) "
  # +"\(.authorDate) "
  # +"\(.authorName|lp(20)) "
  +"\(.subject|_gs8) "
  +"\(.body | trunc(70) | _gs4 ) "
  ;

def gbll:
  map(.committerDateSeconds = (.committerDate | ToSeconds) )
  | map(.committerDateSecondsAgo = (now - .committerDateSeconds))
  | map(.committerDateDaysAgo = (now - .committerDateSeconds)/(24*60*60))
  | map(.committerDateAgoHumanNumber = (.committerDateSecondsAgo | TimeFormat))
  | map(.committerDateAgoHumanNumberRound = [(.committerDateAgoHumanNumber|RoundHumanTime), .committerDateAgoHumanNumber[1], .committerDateAgoHumanNumber[2]] ) 
  | map(.committerDateAgoHumanNumberRoundFormat = formatCommitterDateAgo(.committerDateAgoHumanNumberRound)) 
  | map(.committerDateObject= (.committerDateSeconds | ToDateObject ) )
  | map(.committerDateFormatObject = (.committerDateSeconds | ToDateFormatObject("ymdhM"))) 
  | map(.committerDateFormat = (formatCommitterDate(.committerDateObject;.committerDateFormatObject;.committerDateSecondsAgo)))
  | map(.refNameFormat = (.refName|formatRefName))
  # | map(.committerDateAgoHumanUnit= .committerDateAgoHumanNumber[1]) 
  # map(.committerDateSecondsAgo = (.committerDate | ToSeconds) )
  # | map(.authorDateSeconds = (.authorDate | ToSeconds) )
  | map(formatTable)
  | .[]
;
