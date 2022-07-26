include "pad";
# To learn more about colors in terminal, 
# see https://mhttps://apihandyman.io/api-toolbox-jq-and-openapi-part-4-bonus-coloring-jqs-raw-output/isc.flogisoft.com/bash/tip_colors_and_formatting

# use with -r flag on jq command
# sample code to include this custom jq module:

# jq -L "~/.config/jq" -r 'include "colour"; .Parameters[] | .Name + " = " + colour_text(.Value; "green")'

# Unicode escape character
# \e, \033 and \x1b cause "Invalid escape" error
def escape: "\u001b";

# Terminal color codes
def colours:
 {
  "red": "[31m",
  "green": "[32m",
  "yellow": "[33m",
  "blue": "[34m",
  "darkgray": "[90m",
  "disabled": "[30;100m", # Black on darkgray
  "reset": "[0m",
  "orange": "[38;2;255;135;0m", # #ff8700
  "purple": "[38;2;135;135;255m", # #8787ff
  "neonBlue": "[38;2;82;96;255m", # #5360ff
  "brightTurquoise": "[38;2;5;217;243m", # #05d9f3
  "electricCrimson": "[38;2;255;0;60m", # #ff003d
  "tacha": "[38;2;217;186;94m", # #d9ba5e
  "jazzberry": "[38;2;167;23;92m", # #a7175c
  "brinkPink": "[38;2;252;93;124m", # #fc5d7c
};

def colourTest:
  colours | to_entries | map("\(escape)\(.value)\(.key)\(escape)\(colours.reset) \(.value)")[];

# Colors text with the given color
# colored_text("some text"; "red")
# will output 
# \u001b[31msome text\u001b[0m
# WARNING parameters are separated by ; not ,
def colour(text; colour):
  escape + colours[colour] + text + escape + colours.reset;

def _r(text):
  escape + colours["red"] + text + escape + colours.reset;

def _g(text):
  escape + colours["green"] + text + escape + colours.reset;

def _b(text):
  escape + colours["blue"] + text + escape + colours.reset;

def _nb(text):
  escape + colours["neonBlue"] + text + escape + colours.reset;

def _bt(text):
  escape + colours["brightTurquoise"] + text + escape + colours.reset;

def _ec(text):
  escape + colours["electricCrimson"] + text + escape + colours.reset;

def _tacha(text):
  escape + colours["tacha"] + text + escape + colours.reset;

def _jazzberry(text):
  escape + colours["jazzberry"] + text + escape + colours.reset;

def _brinkPink(text):
  escape + colours["brinkPink"] + text + escape + colours.reset;

def _orange(text):
  escape + colours["orange"] + text + escape + colours.reset;

def _purple(text):
  escape + colours["purple"] + text + escape + colours.reset;

def _y(text):
  escape + colours["yellow"] + text + escape + colours.reset;

def __(text):
  escape + colours["darkgray"] + text + escape + colours.reset;

def ___(text):
  escape + colours["disabled"] + text + escape + colours.reset;
