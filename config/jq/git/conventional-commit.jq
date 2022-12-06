include "colour-out";
include "colour";
include "colour-scale";
include "grey-scale";
include "rainbow-theme";
include "decoration";
include "pad";

def conventionalCommitTypes:{
"feat": _g("ftr")|rv,
"fix": _r("fix")|rv,
"chore": _orange("chr"),
"refactor": _magenta("rfc")|rv,
"ci": _orange(.)|rv,
"style": "style",
"docs": "doc"|_gs2|rv,
"test": _b("tst")|rv,
};

def formatConventionalCommitType:
  conventionalCommitTypes[.] // .;

def formatConventionalCommitScope:
  _gs10;

# accepts parseSubject output
# manage raw links outside this function
# perhaps raw links can be added as footers in commit messages
def formatSubject:
  if type == "object" then
    if (.isConventionalCommit == true) then
     "\(.type|formatConventionalCommitType)"
     +"\(.scope|formatConventionalCommitScope)"
     +":"
     +"\((.subject//"")|_gs8)"
     # +"\(.rawLinks//"")"
    else 
     "\((.subject//"")|_gs8)"
     # +"\(.rawLinks//"")"
    end
  else
    .
  end;

# others
# NOTE: subject capture group prone to breaking
# may contain . - , ""
def captureNonConventionalCommits:
  if type == "string" then capture("(?<subject>[\\w\\s\\.,\\-\"#…/]+)(?<rawLinks>[\\[\\(].*)?")//. 
  else . 
  end;

# anything with a type(scope): subject [link1] (link2) ...
# scope is captured as (scope) with brackets unfortunately
# NOTE: subject capture group prone to breaking
# need to handle special chars in subject
# . - " , # (eg hex colour)
def captureConventionalCommits:
  capture("(?<type>^[\\w-]+)(?<scope>\\(.+\\))?:(?<subject>[\\w\\s\\.,\\-\"#…/]+)(?<rawLinks>[\\[\\(].*)?")//. 
  | if type == "object" then .isConventionalCommit = true else . end ;

def parseSubject:
  captureConventionalCommits | captureNonConventionalCommits
;
