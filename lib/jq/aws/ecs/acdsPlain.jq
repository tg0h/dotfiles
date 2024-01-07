 include "pad";
 include "colour";
 include "aws-time";
include "aws/ecs/ecsState";

def pTaskDefinition:
   gsub(".*/(?<x>.*)";_orange((.x)));

def deployment:
   "\(.status|showEcsDeploymentStatus)"
   +" \(.desiredCount|lp(2))🎯 \(.runningCount|lp(2))🟢 \(.pendingCount|lp(2))🟡 \(.failedTasks|lp(2))🔴"
   +" \(.createdAt | pTime) \(.updatedAt | pTime) \(.rolloutState|showEcsDeploymentRolloutState) ";

def service:
   "\(.serviceName| rp(45) | _brinkPink(.))"
   +"\(.status|showEcsServiceStatus)"
   +" \(.desiredCount|lp(2))🎯 \(.runningCount|lp(2))🟢 \(.pendingCount|lp(2))🟡 "
   +" \(.deployments | map(deployment)[])";


def showHeader:
 # "\(__u("Name")| rp(44))"
 "\(" "| rp(44))"
 +"\(__("SERVICE "))"
 +"\(__u("dsr"))  "
 +"\(__u("run"))  "
 +"\(__u("pend"))  "
 +"\(__("DEPLOY"))  "
 +"\(__u("dsr"))  "
 +"\(__u("run"))  "
 +"\(__u("pend"))  "
 +"\(__u("F"))   "
 +"\(__u("created"))     "
 +"\(__u("updated"))     "
 +"\(__u("rollout")) "
;
def acdsPlain:
 showHeader,
 (.services[] | service)
;

