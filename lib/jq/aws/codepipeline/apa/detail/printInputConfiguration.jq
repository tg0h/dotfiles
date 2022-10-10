include "aws-pipeline";
include "pad";
include "colour";

def printInputConfiguration:
  .input.actionTypeId.provider as $provider |
  4 as $trunc |
  if $provider == "CodeStarSourceConnection" then
    .input.configuration.BranchName | ltrunc($trunc) | __(.)+" "
  elif $provider == "CodeBuild" then # Build, UpdatePipeline, Assets, Tests
    .input.configuration.ProjectName | ltrunc($trunc) | __(.)+ " "
  elif $provider == "Manual" then # approval to deploy to production
    " " | lp($trunc)+" "
  elif $provider == "CloudFormation" then # staging, production
    # .input.configuration.ProjectName
    "\(.input.configuration.ActionMode | _actionMode)" + " "|lp($trunc)+"   " 
  else
    .
  end
  ;
