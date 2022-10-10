# include "aws-pipeline";
include "pad";
include "colour";


def subBucket:
 sub("referralcandy-main-pipel-pipelineartifactsbucketa-yhtabfeteb9l"; "…");
def subKeyPrefix:
 sub("ReferralCandy-Main-P"; "…");
def subSynthOutputPrefix:
 sub("Synth_Outp"; "so…");

def printBucket:
  . as $s3Location
  | $s3Location.bucket as $bucket
  | $s3Location.key as $key
  # the frontend-wonka and frontend buckets are different, show the first char of this bucket with .[0:1]
  | "\($bucket|subBucket| .[0:1] |__(.))/\($key|subKeyPrefix|subSynthOutputPrefix|__(.))"
  ;
def printInputOutputArtifact($pad):
    "\(.input.inputArtifacts[0].s3location | printBucket ? // ""|lp($pad))"
    +"\("->"|_b(.))"
    +"\(.output.outputArtifacts[0].s3location | printBucket ? // " ")"
    ;
def printInputOutputArtifacts:
  .input.actionTypeId.provider as $provider |
  if $provider == "CodeStarSourceConnection" or 
     $provider == "CodeBuild" or
     $provider == "CloudFormation" then
      15 as $pad |
      if .stageName == "Build" then
        printInputOutputArtifact($pad)
      else
        printInputOutputArtifact(0)
      end
  elif $provider == "Manual" then # approval to deploy to production
    ""
  else
    # .
    null
  end
  ;
