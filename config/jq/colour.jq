include "pad";
# To learn more about colors in terminal, 
# see https://mhttps://apihandyman.io/api-toolbox-jq-and-openapi-part-4-bonus-coloring-jqs-raw-output/isc.flogisoft.com/bash/tip_colors_and_formatting
# https://notes.burke.libbey.me/ansi-escape-codes/#:~:text=write%20them%20effectively.-,%5Cx1b,and%20this%20is%20basically%20why.

# use with -r flag on jq command
# sample code to include this custom jq module:

# jq -L "~/.config/jq" -r 'include "colour"; .Parameters[] | .Name + " = " + colour_text(.Value; "green")'

# Unicode escape character
# \e, \033 and \x1b 
def escape: "\u001b";

def bold: "\u001b[1m";
def underline: "\u001b[4m";
def _reverse: "\u001b[7m"; # zzz this is a jq keyword!

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

  "ebony": "[38;2;51;52;52m", # #333434
  "mineShaft": "[38;2;51;51;51m", # #333333
  "thunder": "[38;2;77;77;76m", # #4d4d4c
  "steel": "[38;2;102;102;102m", # #666666
  "darkgray": "[90m",
  "tin": "[38;2;128;127;128m", # #807f80
  "aluminium": "[38;2;153;153;153m", # #999999
  "iron": "[38;2;204;204;204m", # #cccccc

  # 3 bit colours - specify FG and BG together
  "disabled": "[30;100m", # Black on darkgray
  "reset": "[0m",
  "orange": "[38;2;255;135;0m", # #ff8700
  "bgorange": "[48;2;255;135;0m", # #ff8700
  "christine": "[38;2;236;114;17m", # #ec7211 # aws colours
  "purple": "[38;2;135;135;255m", # #8787ff
  "neonBlue": "[38;2;82;96;255m", # #5360ff
  "brightTurquoise": "[38;2;5;217;243m", # #05d9f3
  "electricCrimson": "[38;2;255;0;60m", # #ff003d
  "tacha": "[38;2;217;186;94m", # #d9ba5e
  "jazzberry": "[38;2;167;23;92m", # #a7175c
  "brinkPink": "[38;2;252;93;124m", # #fc5d7c
  "freeSpeechGreen": "[38;2;3;255;19m", # #03ff13
  "malachiteGreen": "[38;2;95;255;135m", # #5fff87
  "tePapaGreen": "[38;2;29;67;60m", # #1d433c
  "sapphireBg": "[48;2;1;31;100m", # #011f64 # new zealand
  "burntCrimson": "[38;2;93;28;39m", # #5d1c27 #buddhist robes nepal
  "burntCrimsonBg": "[48;2;93;28;39m", # #5d1c27 #buddhist robes nepal
  "indianYellow": "[38;2;230;168;84m", # #e6a854
  "gold": "[38;2;255;215;0m", # #ffd700
  "pinkFlamingo": "[38;2;245;97;245m", # #f561f5
  "danube": "[38;2;93;138;189m", # #5d8abd
  "rossoCorsa": "[38;2;217;0;14m", # #d9000e # man u 
  "steelPink": "[38;2;203;29;209m", # #cb1dd1
  "tan": "[38;2;210;180;140m", # #d2b48c
  "beaver": "[38;2;142;112;92m", # #8e705c
  "mySin": "[38;2;245;179;39m", # #f5b327 # lakers lol
  "morningGlory": "[38;2;151;220;228m", # #97dce4 - princess jasmine from aladdin
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

def _showColourDict: to_entries | map("\(escape)\(.value)\(.key)\(escape)\(colours.reset) \(.value)")[];

def colourTest: colours | _showColourDict;

# Colors text with the given color
# colored_text("some text"; "red")
# will output 
# \u001b[31msome text\u001b[0m
# WARNING parameters are separated by ; not ,
def colour(text; colour):
  escape + colours[colour] + text + escape + colours.reset;

def colourReverse(text; colour):
  escape + colours[colour] + _reverse + text + escape + colours.reset;

def _colourCompile: 
  colours 
  | to_entries
  | map(
    .key as $key
    | .value as $colour
    | "def _\($key)($text): \"\($key)\" as $c | colour($text; $c);" as $colourDef
    | "def _\($key)Reverse($text): \"\($key)\" as $c | colourReverse($text; $c);" as $colourReverseDef
    | $colourDef+"\n"
    + $colourReverseDef
  )
  | .[]
;

def _gold($text): "gold" as $c | colour($text; $c);
def _malachiteGreen($text): "malachiteGreen" as $c | colour($text; $c);

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
  escape + colours["bgred"] + escape + colours["black"] + text + escape + colours.reset;

def _bgg(text):
  escape + colours["bggreen"] + escape + colours["black"] + text + escape + colours.reset;

def _bgm(text):
  escape + colours["bgmagenta"] + escape + colours["black"] + text + escape + colours.reset;

def _g(text):
  escape + colours["green"] + text + escape + colours.reset;

def _g_u(text):
  escape + colours["green"] + underline + text + escape + colours.reset;

def _y_u(text):
  escape + colours["yellow"] + underline + text + escape + colours.reset;

def _r_u(text):
  escape + colours["red"] + underline + text + escape + colours.reset;

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

# ebony is almost invisibly black
def _ebony(text):
  escape + colours["ebony"] + text + escape + colours.reset;

def _thunder(text):
  escape + colours["thunder"] + text + escape + colours.reset;

def _steel(text):
  escape + colours["steel"] + text + escape + colours.reset;

def _tin(text):
  escape + colours["tin"] + text + escape + colours.reset;

def _aluminium(text):
  escape + colours["aluminium"] + text + escape + colours.reset;

def _iron(text):
  escape + colours["iron"] + text + escape + colours.reset;


def _mg(text):
  escape + colours["malachiteGreen"] + text + escape + colours.reset;

def _yaleBlue(text):
  escape + colours["yaleBlue"] + text + escape + colours.reset;

def _yaleBlue_b(text):
  escape + colours["yaleBlueBackground"] + text + escape + colours.reset;


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

def __u(text):
  escape + colours["darkgray"] + underline + text + escape + colours.reset;

def __reverse(text):
  escape + colours["darkgray"] + _reverse + text + escape + colours.reset;

def ___(text):
  escape + colours["disabled"] + text + escape + colours.reset;
