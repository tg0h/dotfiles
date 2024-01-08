include "date";
include "pad";
include "colour";
include "aws/route53/subCandyUrls";

def subRecords: 
  sub("(?<x>dualstack)";("\(_orange("dualstack"))"))
  | sub("(?<x>production-alb)";("\(_orange("production-alb"))"))
  | sub("(?<x>staging-application-loadbalancer)";("\(_y("staging-application-loadbalancer"))"))
  | sub("(?<x>cloudfront.net)";("\(_purple("cloudfront.net"))"))
  | sub("(?<x>acm-validations)";("\(_r_u("acm-validations"))"))
  | sub("(?<x>amazonses)";("\(_b("amazonses"))"))
  | sub("(?<x>dkim)";("\(_b("dkim"))"))
  | sub("(?<x>smtp)";("\(_y("smtp"))"))
  | sub("(?<x>s3)";("\(_g("s3"))"))
;

# [ {"Value": ...}, ...]
def showResourceRecords: 
if has("_ResourceRecords") then
  ._ResourceRecords | subRecords | trunc(90)
else
  ""
end
;

def showAliasTarget: 
# ignore .HostedZoneId, .EvaluateTargetHealth 
  (.DNSName // "") | subRecords
;

def __typeColour:
{
  "A": _g("    A"), # green_bg
  "CNAME": _orange("CNAME"),
  "TXT": __("  TXT"),
  "MX": _y("   MX"),
  "NS": "   NS",
  "SOA": "  SOA",
};

def showType:
  __typeColour[.Type] // .Type;


def subStar: sub("(?<x>\\\\052)";("\(_g("*"))"))
;
def subJunkNames: 
  sub("(?<x>timothyt)";("\(_bgy("timothyt"))"))
  | sub("(?<x>test)";("\(_bgy("test"))")) 
  | sub("(?<x>try)";("\(_bgy("try"))")) 
  | sub("(?<x>veroemail)";("\(_bgy("veroemail"))")) 
  | sub("(?<x>nerfed)";("\(_bgy("nerfed"))")) 
  | sub("(?<x>answers)";("\(_bgy("answers"))")) 
  | sub("(?<x>my.new)";("\(_bgy("my.new"))")) 
  | sub("(?<x>knowledgebase)";("\(_bgy("knowledgebase"))")) 
  | sub("(?<x>images)";("\(_bgy("images"))")) 
  | sub("(?<x>promo)";("\(_bgy("promo"))")) 
  | sub("(?<x>_my)";("\(_bgy("_my"))")) 
  | sub("(?<x>affiliate)";("\(_bgy("affiliate"))")) 
  | sub("(?<x>my.backup)";("\(_bgy("my.backup"))")) 
  | sub("(?<x>cancel)";("\(_bgy("cancel"))")) 
  | sub("(?<x>email_links)";("\(_bgy("email_links"))")) 
  | sub("(?<x>wonka1)";("\(_bgy("wonka1"))")) 
  # staging
  | sub("(?<x>refcandyqueue.anafore.com)";("\(_bgy("refcandyqueue.anafore.com"))"))
  | sub("(?<x>shanhanc)";("\(_bgy("shanhanc"))"))
  | sub("(?<x>shaoming)";("\(_bgy("shaoming"))"))
  | sub("(?<x>storybook)";("\(_bgy("storybook"))"))
  | sub("(?<x>willf)";("\(_bgy("willf"))"))
  | sub("(?<x>miguelg)";("\(_bgy("miguelg"))"))
  | sub("(?<x>maythee)";("\(_bgy("maythee"))"))
  | sub("(?<x>joey)";("\(_bgy("joey"))"))
  | sub("(?<x>joel)";("\(_bgy("joel"))"))
  | sub("(?<x>jasmine)";("\(_bgy("jasmine"))"))
  | sub("(?<x>jaspherb)";("\(_bgy("jaspherb"))"))
  | sub("(?<x>hafiza)";("\(_bgy("hafiza"))"))
  | sub("(?<x>glenn)";("\(_bgy("glenn"))"))
  | sub("(?<x>giggs)";("\(_bgy("giggs"))"))
  | sub("(?<x>chrisf)";("\(_bgy("chrisf"))"))
  | sub("(?<x>daniel)";("\(_bgy("daniel"))"))
  | sub("(?<x>darren)";("\(_bgy("darren"))"))
  | sub("(?<x>fabian)";("\(_bgy("fabian"))"))
  | sub("(?<x>jeancharles)";("\(_bgy("jeancharles"))"))
  ;

def subOtherSpecialNames:
  sub("(?<x>partners.referralcandy.com)";("\(__u("partners.referralcandy.com"))"))
  | sub("(?<x>blog.referralcandy.com)";("\(__u("blog.referralcandy.com"))"))
  | sub("(?<x>bytes.referralcandy.com)";("\(__u("bytes.referralcandy.com"))"))
  | sub("(?<x>help.referralcandy.com)";("\(__u("help.referralcandy.com"))"))
;

def subStagingJunk:
  sub("(?<x>dev)";("\(_fp("dev"))"))
;

def subName:
  subCandyUrls | subOtherSpecialNames | subJunkNames | subStar
  | subStagingJunk
;

def showName:
  "\(.Name | subName | ltrunc(70) | lp(70)) "
;

# Name
# Type
# TTL
# SetIdentifier
# Weight
def showDetails:
showName
+"\(showType) "
+"\((.TTL|lp(5))// "_")" 

;

def showChildren:
"\(showResourceRecords)"
# +"\(if has("AliasTarget") then .AliasTarget | showAliasTarget else end)"
+"\(.AliasTarget | showAliasTarget)"
;

def showRecord:
  "\(showDetails) "
  + "\(showChildren)"
;

def mapRecord:
  if has("ResourceRecords") then
    ._ResourceRecords = (.ResourceRecords | map(.Value) | join(" "))
  # elif has("AliasTarget") then
    # .
  end
;

def rf: 
  .ResourceRecordSets
  | .[]
  | mapRecord
  | showRecord
;
