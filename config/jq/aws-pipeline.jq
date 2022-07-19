include "pad";
include "colour";

def awsPipelineStatus:
{
  "Succeeded": _g(.), # grey
  "Superseded": __(.), # red
  "Failed": _r(.),
  "InProgress": _y(.),
};


def aplStatus:
  awsPipelineStatus[.] // .;
