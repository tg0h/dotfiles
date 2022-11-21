# https://news.ycombinator.com/item?id=33651724
def escape: "\u001b";
def reset: "[0m";

def rainbowTheme:
{
  "0": "[38;2;136;17;119m", # #881177 "Dark Purple"
  "1": "[38;2;170;51;102m", # #aa3366 "Rich Maroon"
  "2": "[38;2;204;101;102m", # #cc6566 "Fuzzy Wuzzy Brown"
  "3": "[38;2;238;153;68m", # #ee9944 "Sea Buckthorn"
  "4": "[38;2;238;221;0m", # #eedd00 "Peridot"
  "5": "[38;2;153;221;85m", # #99dd55 "Conifer"
  "6": "[38;2;67;221;136m", # #43dd88 "Shamrock"
  "7": "[38;2;33;204;187m", # #21ccbb "Java"
  "8": "[38;2;2;187;204m", # #02bbcc "Iris Blue"
  "9": "[38;2;0;153;204m", # #0099cc "Pacific Blue"
  "10": "[38;2;51;102;187m", # #3366bb "Denim"
  "11": "[38;2;102;51;153m", # #663399 "Rebecca Purple"
};

def _colourify(colour): escape + colour + . + escape + reset;
def _rb0: _colourify(rainbowTheme["0"]);
def _rb1: _colourify(rainbowTheme["1"]);
def _rb2: _colourify(rainbowTheme["2"]);
def _rb3: _colourify(rainbowTheme["3"]);
def _rb4: _colourify(rainbowTheme["4"]);
def _rb5: _colourify(rainbowTheme["5"]);
def _rb6: _colourify(rainbowTheme["6"]);
def _rb7: _colourify(rainbowTheme["7"]);
def _rb8: _colourify(rainbowTheme["8"]);
def _rb9: _colourify(rainbowTheme["9"]);
def _rb10: _colourify(rainbowTheme["10"]);
def _rb11: _colourify(rainbowTheme["11"]);
