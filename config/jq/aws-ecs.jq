include "pad";
include "colour";

def awsDeploymentStatus:
{
  "PRIMARY": _g(.), # MOST RECENT DEPLOYMENT
  "ACTIVE": _bgr(.|rp(7)), # still has running tasks, being replaced by PRIMARY
  "INACTIVE": __(.), # completely replaced
};

def awsServiceStatus:
{
  "ACTIVE": _g(.),
  "INACTIVE": _bgr(.),
  "DRAINING": __(.),
};

def awsRolloutState:
{
  "COMPLETED": _g(.),
  "FAILED": _bgr(.),
  "IN_PROGRESS": __(.),
};

def _deploymentStatus:
  awsDeploymentStatus[.] // .;

def _serviceStatus:
  awsServiceStatus[.] // .;

def _rolloutState:
  awsRolloutState[.] // .;
