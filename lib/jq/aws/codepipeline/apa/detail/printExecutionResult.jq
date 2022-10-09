include "pad";
include "colour";
include "aws-pipeline";

def subBucket:
 sub("(?<bucketPrefix>referralcandy-main-pipel-pipelineartifactsbucketa-yhtabfeteb9l)"; "…");

def printBucket:
  . as $s3Location
  | $s3Location.bucket as $bucket
  | $s3Location.key as $key
  | "\($bucket|subBucket|__(.)) \($key|__(.))"
  ;

def printGitCommit:
  "\(.CommitId | trunc(6) | _g(.))"
  +" "
  +"\(.CommitMessage | trunc(30) | __u(.))"
  ;
def printSourceExecution:
  .output.outputVariables as $outputVariable |
  "->"
  +" "
  +"\(.output.outputArtifacts[0].s3location | printBucket)"
  +" "
  +"\($outputVariable | printGitCommit)"
  ;

def printBuildExecution:
  "\(.input.inputArtifacts[0].s3location | printBucket)"
  +" -> "
  +"\(.output.outputArtifacts[0].s3location | printBucket)";
  
def printAssetExecution:
  .input.inputArtifacts[0].s3location | printBucket
  +" ->"
  ;

def subPipelineChange:
 sub("(?<w>PipelineChange was)"; (.w|__(.)));
def subChangeSet:
 sub("(?<w>Change set)"; (.w|_purple(.)));
def subCreated:
 sub("(?<w>created)"; (.w|_orange(.)));
def subUpdated:
 sub("(?<w>updated)"; (.w|_m(.)));
def subExecuted:
 sub("(?<w>executed)"; (.w|_g(.)));
def subStack:
 sub("(?<w>Stack)"; (.w|_tacha(.)));
def subNoChanges:
 sub("(?<w>no (changes|change).)"; (.w|__(.)));
def subPeriod:
 sub("(?<w>\\.)"; (.w|__(.)));
def subWith:
 sub("(?<w>with)"; (.w|__(.)));
def subWas:
 sub("(?<w>was)"; (.w|__(.)));
def subProductionAction:
 sub("(?<=production-)(?<action>\\S*)"; (.action|_actionName) );
def subStagingAction:
 sub("(?<=staging-)(?<action>\\S*)"; (.action|_actionName) );
def subProductionStaging: # put this after subProductionAction or subStagingAction
 sub("(?<w>(production|staging)-)"; (.w|__(.)) );

def subApprovedBy: # put this after subProductionAction or subStagingAction
 sub("(?<w>(Approved by))"; (.w|_g(.)) );
def subRejectedBy: # put this after subProductionAction or subStagingAction
 sub("(?<w>(Rejected by))"; (.w|_r(.)) );
def subArn: # put this after subProductionAction or subStagingAction
 sub("(?<w>(arn.*/))"; "");

#   capture("(?<action>(Approved|Rejected) by).*/(?<user>(.*))");
 
def printExecutionSummary:
  if . == null then null else
  subChangeSet | subPipelineChange | subWas | subProductionAction 
  | subStagingAction | subProductionStaging | subStack | subCreated 
  | subUpdated | subExecuted | subNoChanges | subWith | subPeriod 
  | subApprovedBy | subRejectedBy | subArn
  end
  ;
def printExecutionResult:
  if .stageName == "staging" or .stageName == "production" then
    .output.executionResult.externalExecutionSummary | printExecutionSummary // ""
  elif .stageName == "Assets" or .stageName == "UpdatePipeline" then
    printAssetExecution
  elif .stageName == "Build" then
    printBuildExecution
  elif .stageName == "Source" then
    # printBuildExecution
    printSourceExecution
  else
    .
  end;
