# rpad(5;" ") - add right padding with spaces up to a length of 5
# do not need to escape $ with \, unlike in a heredoc
# include "colour";

def rpad($len; $fill):
  tostring | ($len - length) as $l | . + ($fill * $l)[:$l];

def lpad($len; $fill):
  tostring | ($len - length) as $l | ($fill * $l)[:$l] + .;

def rp($len):
  tostring | ($len - length) as $l | . + (" " * $l)[:$l];

def lp($len):
  tostring | ($len - length) as $l | (" " * $l)[:$l] + .;

# truncate string to $len - 3 and add "..."
# if string < $len - 3, do nothing
# subtract 3 from $len so it is easy to do eg . | trunc(5) | lp(5)
# eg "12345" -> "12345"
# eg "123456" -> "12..."

  # escape + colours["darkgray"] + text + escape + colours.reset;

# unable to include colors because dependencies become circular
# define colours again here for use
def _padEscape: "\u001b";
def _padReset: "[0m";
def _padDarkGray: "[90m";
def __padColour($text):
  _padEscape + _padDarkGray + $text + _padEscape + _padReset;

def trunc($len):
  tostring | if (. | length) > $len then .[0:($len-1)] + __padColour("…") else . end; 

# truncate the string starting from the left so that the resulting string is 
# $len long, including ...
# eg ltrunc(5) turns "123456789" to "89..."
def ltrunc($truncLength):
  tostring | length as $inputLength | if $inputLength > $truncLength then "…" + .[$inputLength-$truncLength+1:] else . end; 
