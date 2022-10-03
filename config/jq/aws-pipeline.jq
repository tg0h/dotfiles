include "pad";
include "colour";

def _colour1(text):
  escape + colours["doveGrey_bg"] + escape + colours["purple"] + text + escape + colours.reset;
def _colour2(text):
  escape + colours["doveGrey_bg"] + escape + colours["neonBlue"] + text + escape + colours.reset;
def _colour3(text):
  escape + colours["doveGrey_bg"] + escape + colours["brightTurquoise"] + text + escape + colours.reset;
def _colour5(text):
  escape + colours["doveGrey_bg"] + escape + colours["brinkPink"] + text + escape + colours.reset;

def awsPipelineStatus:
{
  "Succeeded": _g(.), # grey
  "Superseded": __(.), # red
  "Failed": _r(.),
  "InProgress": _y(.),
};

def aplStatus:
  awsPipelineStatus[.] // .;



#### used in aws codepipeline get-pipeline

def __awsActionTypeCategory: {
  "Source": __("s"),
  "Build": __("b"),
  "Deploy": __("d"),
  "Approval": __("a"),
};
def _actionTypeCategory:
  __awsActionTypeCategory[.] // .;

def __awsActionTypeProvider: {
  "CodeStarSourceConnection": _g("CS"),
  "CodeBuild": _bt("CB"),
  "CloudFormation": _orange("CF"),
  "Manual": _y("MN"),
};
def _actionTypeProvider:
  __awsActionTypeProvider[.] // .;

def __artifact: {
  "Synth_Output": _m_u("syn"),
  "Anafore_referralcandy_main_Source": _g_u("src"),
};
def _artifact:
  __artifact[.] // .;


# color Deploy or Prepare action name in the candy staging or production stage

def __actionName: {
  ## AUTH
  "cognito": _y(.),
  "cognito-wonka": _y(.),

  ## FRONTEND
  "frontend-wonka": _fp(.),
  "frontend": _fp(.),
  "storybook": _fp(.),

  ## BACKEND
  "apiInternal": _sdb(.),
  "api-nerfed": _sdb(.),
  "api": _sdb(.),

  ## DB
  "dynamoDBStack": __reverse(.),

  ## AWS
  "s3Stack": _orange(.),
  "sendDkimEmail": _orange(.),
  "sqsQueueStack": _orange(.),

  ## DAEMONS?
  "createDailyRate": _yaleBlue_b(.),
  "updateReferral": _yaleBlue_b(.),
  "createDaemonDailyScheduler": _yaleBlue_b(.),
  "createDaemonFifteenMinsScheduler": _yaleBlue_b(.),
  "createDaemonTenDayScheduler": _yaleBlue_b(.),
  "updateStat": _yaleBlue_b(.),
};

def _actionName:
  __actionName[.] // .;

def __configurationActionMode: {
  "CHANGE_SET_REPLACE": _y("R"),
  "CHANGE_SET_EXECUTE": _g("X"),
};
def _actionMode:
  __configurationActionMode[.] // .;

def __prepare:
 sub("(?<p>Prepare)"; _g((.p)));
def __deploy:
 # (?<=) is a positive lookbehind capture
 # I only want to match Deploy if it is preceded by a literal .
 # frontend.Deploy - match
 # DeployToPRoduction - do not match
 sub("(?<=.)(?<d>Deploy)"; _b((.d)));
def actionName:
 # escape the literal . twice
 sub("(?<d>.*)(?=\\.)"; (.d | _actionName));

def _CFname:
  actionName | __prepare | __deploy ;
def __manual:
 sub("(?<p>DeployToProduction)"; _bgr((.p)));
def __tests:
 sub("(?<p>Tests)"; _bgy((.p)));
def _stgProdActionName:
  _CFname | __manual | __tests;

# color action run order for the staging and production stage
def __runOrderStaging:
  if . == 1 then
    # _purple("1")
    _colour1("1")
  elif . == 2 then
    _colour2("2")
  elif . == 3 then
    _bt("3")
  elif . == 4 then
    _jazzberry("4")
  elif . == 5 then
    _colour5("5")
  else
    .
  end;
def __runOrderProduction:
  if . == 1 then
    _purple("1")
  elif . == 2 then
    # _nb("2")
    _colour2("2")
  elif . == 3 then
    # _bt("3")
    _colour3("3")
  elif . == 4 then
    _jazzberry("4")
  elif . == 5 then
    _brinkPink("5")
  else
    .
  end;
def _runOrder($stageName):
  if $stageName == "staging" then
    __runOrderStaging
  else
    __runOrderProduction
  end;

def _sortKeys:
[ 
  ## AUTH
  "cognito.Prepare",
  "cognito.Deploy",
  "cognito-wonka.Prepare",
  "cognito-wonka.Deploy",

  ## FRONTEND
  "frontend.Prepare",
  "frontend.Deploy",
  "frontend-wonka.Prepare",
  "frontend-wonka.Deploy",
  "storybook.Prepare",
  "storybook.Deploy",

  ## BACKEND
  "api.Prepare",
  "api.Deploy",
  "api-nerfed.Prepare",
  "api-nerfed.Deploy",
  "apiInternal.Prepare",
  "apiInternal.Deploy",

  ## DB
  "dynamoDBStack.Prepare",
  "dynamoDBStack.Deploy",

  ## AWS
  "s3Stack.Prepare",
  "s3Stack.Deploy",
  "sendDkimEmail.Prepare",
  "sendDkimEmail.Deploy",
  "sqsQueueStack.Prepare",
  "sqsQueueStack.Deploy",

  ## DAEMONS?
  "createDaemonDailyScheduler.Prepare",
  "createDaemonDailyScheduler.Deploy",
  "createDaemonFifteenMinsScheduler.Prepare",
  "createDaemonFifteenMinsScheduler.Deploy",
  "createDaemonTenDayScheduler.Prepare",
  "createDaemonTenDayScheduler.Deploy",
  "createDailyRate.Prepare",
  "createDailyRate.Deploy",
  "updateReferral.Prepare",
  "updateReferral.Deploy",
  "updateStat.Prepare",
  "updateStat.Deploy"
];

