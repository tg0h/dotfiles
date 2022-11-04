include "colour";
include "colour-scale";

def _image:
  # truncate and highlight aws ecr prefix
  # gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"...")|_("bblue"))+(.x | _tacha(.)));
  gsub("(?<dkr>.*amazonaws.*)/(?<x>.*)";((.dkr[0:3]+"..."))+(.x));

def _repo:
  gsub("(?<repo>.*)/(?<image>.*)" ; 
        ( "\(.repo|_g(.))"
          +"\("/"|__(.))"
          +"\(.image|_brinkPink(.))"
        )
      );

def _203image:
  gsub("(?<dkr>.*)\\.\\.\\.(?<image>.*)" ; 
        ( "\(.dkr|_("bblue"))"
          +"\("..."|__(.))"
          +"\(.image|_orange(.))"
        )
      );

def _localImage:
  gsub("(?<dkr>.*)" ; 
        ( "\(.dkr|_purple(.))"
        )
      );


def _repository:
  _image
  # | lp(35)
  | _repo
  | _203image
  | _localImage
;

def _git:
  gsub("(?<git>git_)(?<hash>.*)" ; 
        ( "\(.git|_b(.))"
          +"\(.hash|_g(.))"
        )
      );

def _isStartWithVAndDigit: test("^v\\d");
def _isStartWithNonDigit: test("^\\D");

def _tag:
  # rp(15) |
  if . | contains("latest") then .|_cs0
  elif . | contains("<none>") then .|__(.)
  elif . | startswith("git") then .|_git
  elif _isStartWithVAndDigit then .
  elif _isStartWithNonDigit then _m(.)
  else .
  end
;
