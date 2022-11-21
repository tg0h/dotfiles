def escape: "\u001b";
def reset: "[0m";

def colourscale:
{
  "0": "[38;2;99;190;123m",  # #63be7b - Fern
  "1": "[38;2;134;201;126m", # #86c97e - De York
  "2": "[38;2;169;210;127m", # #a9d27f - Feijoa
  "3": "[38;2;204;221;130m", # #ccdd82 - Medium Spring Bud
  "4": "[38;2;238;230;131m", # #eee683 - Texas
  "5": "[38;2;254;220;129m", # #fedc81 - Jasmine
  "6": "[38;2;252;191;123m", # #fcbf7b - Macaroni and Cheese
  "7": "[38;2;251;162;118m", # #fba276 - Atomic Tangerine
  "8": "[38;2;249;133;112m", # #f98570 - Salmon 
  "9": "[38;2;248;105;107m", # #f8696b - Pastel Red

  "10": "[38;2;240;88;89m",  # #f05859 - Carnation
  "11": "[38;2;233;72;72m",  # #e94848 - Carmine Pink
  "12": "[38;2;226;55;55m",  # #e23737 - Cg Red
  "13": "[38;2;219;38;38m",  # #db2626 - Lust
  "14": "[38;2;211;21;21m",  # #d31515 - Fire Engine Red
  "15": "[38;2;204;4;3m"     # #cc0403 - Boston University Red
};

def _colourify(colour):
  escape + colour + . + escape + reset;
def _cs0: _colourify(colourscale["0"]);
def _cs1: _colourify(colourscale["1"]);
def _cs2: _colourify(colourscale["2"]);
def _cs3: _colourify(colourscale["3"]);
def _cs4: _colourify(colourscale["4"]);
def _cs5: _colourify(colourscale["5"]);
def _cs6: _colourify(colourscale["6"]);
def _cs7: _colourify(colourscale["7"]);
def _cs8: _colourify(colourscale["8"]);
def _cs9: _colourify(colourscale["9"]);
def _cs10: _colourify(colourscale["10"]);
def _cs11: _colourify(colourscale["11"]);
def _cs12: _colourify(colourscale["12"]);
def _cs13: _colourify(colourscale["13"]);
def _cs14: _colourify(colourscale["14"]);
def _cs15: _colourify(colourscale["15"]);
