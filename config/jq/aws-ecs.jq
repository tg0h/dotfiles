include "pad";
include "colour";

def awsRolloutState:
{
  "COMPLETED": _g(.),
  "FAILED": _bgr(.),
  "IN_PROGRESS": __(.),
};

def _rolloutState:
  awsRolloutState[.] // .;
