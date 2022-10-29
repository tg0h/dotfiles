include "pad";
include "colour";
include "docker";

def image:
 # truncate and highlight aws ecr prefix
 gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"...")|_("bblue"))+(.x | _tacha(.)));

def dcl:
   # sort by status descending (show up first then exit). ignore the exit code (whether exit 0 or exit 127 etc) by just getting the first 2 chars of exit. 
   # then sort by name ascending
   sort_by((.Status[0:2] | explode | map(-.)), .Names)[] |
   # $excludeCandy |
   "\(.ID[0:5] | __(.)) \(.Names[0:45] | rp(45)) \(.Status | prettyStatus) \(.Ports | rp(35) | _brinkPink(.)) \(.Image | image | rp(15) | _tacha(.)) \(.Command[1:11] | rp(10) | __(.)) \(.CreatedAt|pCreatedAt)";

