include "pad";
# To learn more about colors in terminal, 
# see https://mhttps://apihandyman.io/api-toolbox-jq-and-openapi-part-4-bonus-coloring-jqs-raw-output/isc.flogisoft.com/bash/tip_colors_and_formatting

# use with -r flag on jq command
# sample code to include this custom jq module:

# jq -L "~/.config/jq" -r 'include "colour"; .Parameters[] | .Name + " = " + colour_text(.Value; "green")'

# Unicode escape character
# \e, \033 and \x1b cause "Invalid escape" error
def escape: "\u001b";

def bold: "\u001b[1m";
def underline: "\u001b[4m";
def reverse: "\u001b[7m";

### Terminal color codes
# 3 bit colours (just 8 available)
# CSI - Control Sequence Introducer
# SGR - Select Graphic Rendition - CSI n m
# 93 means yellow
# echo \u001b[93;1m - 1 means bold
# echo \u001b[93;1m - 2 means faint
# echo \u001b[93;3m - 3 means italic
# echo \u001b[93;4m - 4 means underline
# echo \u001b[93;7m - 7 means invert
# echo \u001b[93;9m - 9 means strikethrough
# echo \u001b[93;21m - 21 means double underline

# 8 bit colour
# ESC[38;5;⟨n⟩m Select foreground color      where n is a number from the table below
# ESC[48;5;⟨n⟩m Select background color
#   0-  7:  standard colors (as in ESC [ 30–37 m)
#   8- 15:  high intensity colors (as in ESC [ 90–97 m)
#  16-231:  6 × 6 × 6 cube (216 colors): 16 + 36 × r + 6 × g + b (0 ≤ r, g, b ≤ 5)
# 232-255:  grayscale from black to white in 24 steps

# https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit
# 24 bit colour = 256*256*256 = 16,777,216 colours
# ESC[ 38;2;⟨r⟩;⟨g⟩;⟨b⟩ m Select RGB foreground color
# ESC[ 48;2;⟨r⟩;⟨g⟩;⟨b⟩ m Select RGB background color
def colours:
 {
  # 3 bit colours
  "black": "[30m",
  "red": "[31m",
  "green": "[32m",
  "yellow": "[33m",
  "blue": "[34m",
  "magenta": "[35m",
  "cyan": "[36m",
  "white": "[37m",

  # bright
  "bblack": "[90m",
  "bred": "[91m",
  "bgreen": "[92m",
  "byellow": "[93m",
  "bblue": "[94m",
  "bmagenta": "[95m",
  "bcyan": "[96m",
  "bwhite": "[97m",

  #background
  "bgblack": "[40m",
  "bgred": "[41m",
  "bggreen": "[42m",
  "bgyellow": "[43m",
  "bgblue": "[44m",
  "bgmagenta": "[45m",
  "bgcyan": "[46m",
  "bgwhite": "[47m",
  
  # bright background
  "bbgblack": "[100m",
  "bbgred": "[101m",
  "bbggreen": "[102m",
  "bbgyellow": "[103m",
  "bbgblue": "[104m",
  "bbgmagenta": "[105m",
  "bbgcyan": "[106m",
  "bbgwhite": "[107m",

  "darkgray": "[90m",
  # 3 bit colours - specify FG and BG together
  "disabled": "[30;100m", # Black on darkgray
  "reset": "[0m",
  "orange": "[38;2;255;135;0m", # #ff8700
  "bgorange": "[48;2;255;135;0m", # #ff8700
  "purple": "[38;2;135;135;255m", # #8787ff
  "neonBlue": "[38;2;82;96;255m", # #5360ff
  "brightTurquoise": "[38;2;5;217;243m", # #05d9f3
  "electricCrimson": "[38;2;255;0;60m", # #ff003d
  "tacha": "[38;2;217;186;94m", # #d9ba5e
  "jazzberry": "[38;2;167;23;92m", # #a7175c
  "brinkPink": "[38;2;252;93;124m", # #fc5d7c
  "fsg": "[38;2;3;255;19m", # #03ff13

  # RC colours
  "flourescentPink": "[38;2;255;14;139m", # #ff0e8b
  "spiroDiscoBall": "[38;2;34;197;236m", # #22c5ec
  "yaleBlue": "[38;2;18;65;145m", # #124191
  "yaleBlueBackground": "[48;2;18;65;145m", # #124191
  "doveGrey_bg": "[48;2;118;118;118m", # #767676
  "ebony_bg": "[48;2;51;52;52m", # #333434
  "dark_grey_bg": "[48;2;88;88;88m", # #585858
};

def _(colour):
  tostring | escape + colours[colour] + . + escape + colours.reset;

def colourTest:
  colours | to_entries | map("\(escape)\(.value)\(.key)\(escape)\(colours.reset) \(.value)")[];

# Colors text with the given color
# colored_text("some text"; "red")
# will output 
# \u001b[31msome text\u001b[0m
# WARNING parameters are separated by ; not ,
def colour(text; colour):
  tostring | escape + colours[colour] + text + escape + colours.reset;

def _r(text):
  escape + colours["red"] + text + escape + colours.reset;

  # escape + colours["magenta"] + underline + text  + escape + colours.reset;
def _m(text):
  escape + colours["magenta"] + text  + escape + colours.reset;

def _m_u(text):
  escape + colours["magenta"] + underline + text  + escape + colours.reset;

def _by(text):
  escape + colours["byellow"] + text + escape + colours.reset;

def _bm(text):
  escape + colours["bmagenta"] + text + escape + colours.reset;


def _bgy(text):
  # background yellow and foreground black
  escape + colours["bgyellow"] + escape + colours["black"] + text + escape + colours.reset;

def _bgr(text):
  # background red and foreground black
  escape + colours["bgred"] + escape + colours["black"] + text + escape + colours.reset;

def _bgm(text):
  # background red and foreground black
  escape + colours["bgmagenta"] + escape + colours["black"] + text + escape + colours.reset;

def _g(text):
  escape + colours["green"] + text + escape + colours.reset;

def _g_u(text):
  escape + colours["green"] + underline + text + escape + colours.reset;

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

def _fp(text):
  escape + colours["flourescentPink"] + text + escape + colours.reset;

def _sdb(text):
  escape + colours["spiroDiscoBall"] + text + escape + colours.reset;

def _yaleBlue(text):
  escape + colours["yaleBlue"] + text + escape + colours.reset;

def _yaleBlue_b(text):
  escape + colours["yaleBlueBackground"] + text + escape + colours.reset;

def _fsg(text):
  escape + colours["fsg"] + text + escape + colours.reset;

def _orange(text):
  escape + colours["orange"] + (text|tostring) + escape + colours.reset;

def _orange_b(text):
  escape + colours["bgorange"] + escape + colours["black"] + (text|tostring) + escape + colours.reset;

def _purple(text):
  escape + colours["purple"] + text + escape + colours.reset;

def _y(text):
  escape + colours["yellow"] + text + escape + colours.reset;

def __(text):
  escape + colours["darkgray"] + text + escape + colours.reset;

def __reverse(text):
  escape + colours["darkgray"] + reverse + text + escape + colours.reset;

def ___(text):
  escape + colours["disabled"] + text + escape + colours.reset;
