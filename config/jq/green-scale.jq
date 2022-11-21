def escape: "\u001b";
def reset: "[0m";

def greenscale:
{
  "0": "[38;2;98;189;123m", # #62bd7b "Fern"
  "1": "[38;2;108;193;114m", # #6cc172 "Fern"
  "2": "[38;2;119;196;105m", # #77c469 "Mantis"
  "3": "[38;2;129;200;97m", # #81c861 "Mantis"
  "4": "[38;2;140;204;88m", # #8ccc58 "Mantis"
  "5": "[38;2;150;207;79m", # #96cf4f "Atlantis"
  "6": "[38;2;161;211;70m", # #a1d346 "Atlantis"
  "7": "[38;2;171;215;62m", # #abd73e "Atlantis"
  "8": "[38;2;181;218;53m", # #b5da35 "Fuego"
  "9": "[38;2;192;222;44m", # #c0de2c "Fuego"
  "10": "[38;2;202;225;35m", # #cae123 "Pear"
  "11": "[38;2;213;229;26m", # #d5e51a "Barberry"
  "12": "[38;2;223;233;18m", # #dfe912 "Barberry"
  "13": "[38;2;234;236;9m", # #eaec09 "Titanium Yellow"
  "14": "[38;2;244;240;0m", # #f4f000 "Aureolin"
};

def _colourify(colour): escape + colour + . + escape + reset;
def _grs0: _colourify(greenscale["0"]);
def _grs1: _colourify(greenscale["1"]);
def _grs2: _colourify(greenscale["2"]);
def _grs3: _colourify(greenscale["3"]);
def _grs4: _colourify(greenscale["4"]);
def _grs5: _colourify(greenscale["5"]);
def _grs6: _colourify(greenscale["6"]);
def _grs7: _colourify(greenscale["7"]);
def _grs8: _colourify(greenscale["8"]);
def _grs9: _colourify(greenscale["9"]);
def _grs10: _colourify(greenscale["10"]);
def _grs11: _colourify(greenscale["11"]);
def _grs12: _colourify(greenscale["12"]);
def _grs13: _colourify(greenscale["13"]);
def _grs14: _colourify(greenscale["14"]);
