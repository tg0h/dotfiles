include "colour";
include "colour-out";
include "grey-scale";
include "pad";
include "null";

def formatStatus:
{
"InProgress": _g("IP")
};

def getInboundPipelineExecutionId:
  .pipelineExecutionId|isNotNull(.[0:8]|_y(.)) // ""
;

def getInboundExecutionStatus:
  .status|isNotNull(formatStatus[.]) // ""
;

def aps: 
  .stageStates 
  | map(select(.stageName=="production"))
  | .[]
  | (.actionStates
      | map( 
            select( .actionName == "DeployToProduction" ) )[]
           ) as $deployToProdAction
  | .inboundExecution? as $inboundExecution
  | .latestExecution as $latestExecution
  |
  "\($deployToProdAction.latestExecution.token)"
  +" "
  +"\($inboundExecution | getInboundPipelineExecutionId)"
  +("->"|_m(.))
  + "\($latestExecution.pipelineExecutionId|_g(.))"
  +" "
  + "\($inboundExecution | getInboundExecutionStatus)"
  +("->"|_m(.))
  +"\($deployToProdAction.latestExecution.status|formatStatus[.]//.)"
  ;
