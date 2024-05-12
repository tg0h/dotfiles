 include "pad";
 include "colour";
 include "boolean";

 def __cmd:
   .[0] as $cmd | .[1:] | join (" ") as $rest |
   _brinkPink($cmd | ltrunc(20) | lp(44)) +" "+ _tacha($rest | trunc(29) | rp(29));

 def _sub:
   sub("(?<x>/Users/tim)";("_")) | sub("(?<x>/candy/main/)";("/c/m/")) ;

 def __cwd:
   _sub | ltrunc(55);

def __env:
 if (length > 0) then (. | tostring | .[1:] | trunc(30) | __(.)) else __("-") end; 

def fasState:
  "🔍️\(.is_focused|bool(.;"F"))\(.is_active|bool(.;"A"))\(.is_self|bool(.;"S"))"
  ;

def _os_window:
"\(.id | rp(2))    \(fasState)  \(.platform_window_id) -------------------------";

def _tab:
 "t \(.id|lp(3)|_g(.)) \(fasState) \(.title|ltrunc(30)|lp(30)|_purple(.)) \(.layout| lp(10) |_orange(.)) \(.active_window_history|join(" "))";

def _window:
"w \(.id | lp(3) | _y(.)) \(fasState) \(.title|ltrunc(30)|lp(30)) \(.cmdline | join(" ") | ltrunc(10) | rp(10) | _brinkPink(.)) 🏡\(.env | __env) \(" " | lp(19)) \(.cwd| __cwd |__(.))";

def _fgProcess:
 "\(.cmdline |__cmd) \(.cwd| __cwd |__(.)) \(.pid)";

def ktl:
      .[] | _os_window,
      (
        .tabs[] | _tab,
        ( 
          .windows[] | _window,
          (.foreground_processes[] | _fgProcess  )
        )
      )
    ;
