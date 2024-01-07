include "colour";

def ecsServiceStatus:
{
  "ACTIVE": _g("ACTIVE"),
  "DRAINING": _y("DRAINING"),
  "INACTIVE": __("INACTIVE"),
};

def showEcsServiceStatus:
  ecsServiceStatus[.] // .;

def ecsDeploymentStatus:
{
  "PRIMARY": _b("PRIMARY"), # most recent deployment
  "ACTIVE": _y("ACTIVE"), # still has running tasks, being replaced by primary
  "INACTIVE": __("INACTIVE"), # deployment has been completely replaced
};

def showEcsDeploymentStatus:
  ecsDeploymentStatus[.] // .;

def ecsDeploymentRolloutState:
{
  "IN_PROGRESS": _y("IN_PROGRESS"),
  "COMPLETED": _ebony("COMPLETED"),
};

def showEcsDeploymentRolloutState:
  ecsDeploymentRolloutState[.] // .;
