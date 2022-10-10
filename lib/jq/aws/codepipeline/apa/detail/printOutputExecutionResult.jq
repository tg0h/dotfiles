include "pad";
include "colour";
include "aws-pipeline";
include "hyperlink";

def printGitCommit:
  "\(.CommitId | trunc(6) | _g(.))"
  +" "
  +"\(.CommitMessage | trunc(30) | __u(.))"
  ;
def printSourceExecution:
  .output.outputVariables as $outputVariable |
  "\($outputVariable | printGitCommit)"
  ;

def printStagingExecution:
  "#"
  +"\(.output.executionResult.externalExecutionId)"
  ;

def subPipelineChange:
 sub("(?<w>PipelineChange was)"; (.w|__("PC…")));
def subChangeSet:
 sub("(?<w>Change set)"; (.w|_purple(.)));

def subCreated:
 sub("(?<w>created)"; ("C"|_orange(.)));
def subUpdated:
 sub("(?<w>updated)"; ("U"|_m(.)));
def subExecuted:
 sub("(?<w>executed)"; ("X"|_g(.)));

def subStack:
 sub("(?<w>Stack)"; (.w|_tacha(.)));
def subNoChanges:
 sub("(?<w>no (changes|change).)"; ("-"|__(.)));
def subPeriod:
 sub("(?<w>\\.)"; "");
def subWith:
 sub("(?<w>with )"; "");
def subWas:
 sub("(?<w>was )"; "");
def subProductionAction:
 sub("(?<=production-)(?<action>\\S*)"; (.action|_actionName) );
def subStagingAction:
 sub("(?<=staging-)(?<action>\\S*)"; (.action|_actionName) );
def subProductionStaging: # put this after subProductionAction or subStagingAction
 sub("(?<w>(production|staging)-)"; (.w|__("…")) );

def subApprovedBy: # put this after subProductionAction or subStagingAction
 sub("(?<w>(Approved by))"; (.w|_g(.)) );
def subRejectedBy: # put this after subProductionAction or subStagingAction
 sub("(?<w>(Rejected by))"; (.w|_r(.)) );
def subArn: # put this after subProductionAction or subStagingAction
 sub("(?<w>(arn.*/))"; "");
 
def printExecutionSummary:
  if . == null then null else
  subChangeSet | subPipelineChange | subWas | subProductionAction 
  | subStagingAction | subProductionStaging | subStack | subCreated 
  | subUpdated | subExecuted | subNoChanges | subWith | subPeriod 
  | subApprovedBy | subRejectedBy | subArn
  end
  ;
def printExternalId:
  . | ltrunc(2) | _b(.);

def printOutputExecutionResult:
  .output.executionResult.externalExecutionUrl as $hyperlink |
  .output.executionResult.externalExecutionId as $externalId |
  if .stageName == "Source" then
    printSourceExecution
  elif .stageName == "staging" or .stageName == "production" then
    if .actionName == "DeployToProduction" then
    "\(.output.executionResult.externalExecutionSummary | printExecutionSummary // "")"
    else
    "\(.output.executionResult.externalExecutionSummary | printExecutionSummary // "") \($externalId|printExternalId)\($hyperlink|hyperlink)"
    end
  elif .stageName == "Build" or .stageName == "UpdatePipeline" or .stageName == "Assets" then
    $externalId|printExternalId + "\($hyperlink|hyperlink)"
  else
    ""
  end;
