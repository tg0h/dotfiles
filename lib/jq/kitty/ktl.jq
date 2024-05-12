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

def _tab:
 "\(.id|lp(2)|_g(.))  🔍️\(.is_focused|bool(.))  \(.title|ltrunc(30)|lp(30)|_purple(.)) \(.layout| lp(10) |_orange(.)) \(.active_window_history|join(" "))";

def _window:
"\(.id | lp(3) | _y(.)) 🔍️\(.is_focused|bool(.))\(.is_self|bool(.)) \(.title|ltrunc(30)|lp(30)) \(.cmdline | join(" ") | ltrunc(10) | rp(10) | _brinkPink(.)) 🏡\(.env | __env) \(" " | lp(19)) \(.cwd| __cwd |__(.))";

def _os_window:
"\(.id | rp(2))  🔍️\(.is_focused|bool(.))  \(.platform_window_id)";

def _fgProcess:
 "\(.cmdline |__cmd) \(.cwd| __cwd |__(.)) \(.pid)";

def ktl:
    (
      .[] |
      _os_window,
        (.tabs[] | 
          _tab,
          ( 
            .windows[] | _window,
            (.foreground_processes[] | _fgProcess  )
          )
        )
    );
