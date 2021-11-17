include "pad";
include "colour";

def gitlabNames:
{
  "Do Duy Hung": "hung",
  "Loc Nguyen Huu": "loc",
  "Hanh Nguyen": "harry",
  "Khanh Nguyen Khoa (Michael)": "mike",
  "Tien Pham Minh": "tien",
  "Truong Le Ngoc": "tom",
  "Amanda Chow": "amand",
  "Dominic Soh": "dom",
  "Mason Chen Guanming": "dom",
  "zhu_ziming": "zm",
  "Samuel Low": "sam",
  "timothy goh": "tim"
};

def gName:
  ( gitlabNames[.] | rp(5) ) // .; # if name is not found in gitlabNames, let it pass through

def gitlabStatus:
{
  "To Do": __("00td "), # grey
  "Tested with Issues": _r("0fail"), # red
  "Pending (Migrated)": "pend ",
  "In Progress": "0ip  ",
  "Pending Epic Completion": "pec  ",

  "Feature Testing": _y("1ut  "), # yellow
  "To Merge To Develop": _g("1ut  "), # green

  "Integration Test": _y("2dv  "),
  "To Merge to Master or Release": _g("2dv  "),

  "Regression Test": _y("3st  "),
  "User Acceptance Test": _y("3uat "),
  "Pending Production Deployment": _g("3st  "),

  "Done": _b("4done"), # blue

  "Cancelled": ___("5canc"), # disabled 
};


def gStatus:
  gitlabStatus[.] // .;
