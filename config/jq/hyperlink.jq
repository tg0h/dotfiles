include "colour";
include "colour-scale";
include "green-scale";

def _ESC: "\u001b";
def _ST: "\u001b\\"; # string terminator
def _OSC: "\u001b]";
def _OSC8: "\u001b]8";

# https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
# provide uri in form of https://google.com etc
def hyperlink:
  _OSC8
  +";;"
  + . 
  + _ST 
  + "\("||>"|_b(.))"
  +_OSC8
  +";;"
  +_ST;

def hyperlink($linkText):
  if (. != null) then 
    _OSC8
    +";;"
    + . 
    + _ST 
    + "\($linkText+("||>"|_cs0))"
    +_OSC8
    +";;"
    +_ST
  else 
    . 
  end;
