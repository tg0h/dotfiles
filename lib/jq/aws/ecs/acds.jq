include "pad";
include "colour";
include "aws-time";
include "aws-ecs";
include "aws/ecs/ecsState";

def awsRolloutState:
{
  "COMPLETED": _g(.),
  "FAILED": _bgr(.),
  "IN_PROGRESS": __(.),
};
def _rolloutState:
  awsRolloutState[.] // .;

def placementStrategy:
 map("\(.type | lp(10) | _y(.)):\(.field)")[];
def pTaskDefinition:
 gsub(".*/(?<x>.*)";_orange((.x)));
def service:
 "\(.serviceName| _brinkPink(.))"
 +" 🎯\(.desiredCount) \(.runningCount|tostring|_g(.)) \(.pendingCount|tostring|_y(.))"
 +" \(.taskDefinition | pTaskDefinition)"
 +" \(.status | showEcsServiceStatus) \(.deploymentConfiguration.minimumHealthyPercent)% \(.deploymentConfiguration.maximumPercent)%",
 "\(.placementStrategy|placementStrategy)"
;
def deployment:
 "\(.status | showEcsDeploymentStatus)"
 +" 🎯\(.desiredCount) \(.runningCount|tostring|_g(.)) \(.pendingCount|tostring|_y(.)) \(.failedTasks|tostring|_r(.))"
 +" created:\(.createdAt | pTime) updated:\(.updatedAt | pTime)"
 +" \(.rolloutState | _rolloutState) \(.rolloutStateReason)"
;
def _completed:
 sub("(?<dc>deployment completed)"; _nb((.dc)));
def _brackets:
 gsub("(?<openb>\\\\()(?<br>.*?)(?<closeb>(\\\\)))"; __(.openb)+__((.br))+__(.closeb) );
def _stopped:
 gsub("(?<x>stopped)"; _r((.x)));
def _started:
 gsub("(?<x>started)"; _y((.x)));
def _reached:
 gsub("(?<x>reached a steady state)"; _g((.x)));
def _filler:
 gsub("(?<x>(has|\\\\.|:))"; __((.x)));
def _unable_to_place_a_task:
 gsub("(?<x>unable to place a task)"; _brinkPink((.x)));
def _unhealthy:
 gsub("(?<x>unhealthy)"; _brinkPink((.x)));
def registered:
 gsub("(?<x> registered)"; _by((.x)));
def _colourFilter:
 _completed | _filler | _started | _stopped | _reached | _brackets | _unable_to_place_a_task | _unhealthy ;
def event:
 "  \(.createdAt | pTime) \(.message | _colourFilter)";

def acds($number):
   (.services[] | 
   service, 
   "\(.deployments | map(deployment)[])",
   "\(.events[0:$number] | map(event)[])"
   )
;

