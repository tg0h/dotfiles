# To learn more about colors in terminal, 
# see https://mhttps://apihandyman.io/api-toolbox-jq-and-openapi-part-4-bonus-coloring-jqs-raw-output/isc.flogisoft.com/bash/tip_colors_and_formatting

# use with -r flag on jq command
# sample code to include this custom jq module:
# jq -L "~/.config/jq" -r 'include "module-colour"; .Parameters[] | .Name + " = " + colour_text(.Value; "green")'

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
  "reset": "[0m"
};

# Colors text with the given color
# colored_text("some text"; "red")
# will output 
# \u001b[31msome text\u001b[0m
# WARNING parameters are separated by ; not ,
def colour_text(text; colour):
  escape + colours[colour] + text + escape + colours.reset;
