def escape: "\u001b";
def reset: "[0m";

def greyscale:
{
  "0": "[38;2;36;36;36m", # #242424 "Black"
  "1": "[38;2;52;52;52m", # #343434 "Jet"
  "2": "[38;2;67;67;67m", # #434343 "Tuatara"
  "3": "[38;2;83;83;83m", # #535353 "Dark Gray"
  "4": "[38;2;99;99;99m", # #636363 "Storm Dust"
  "5": "[38;2;114;114;114m", # #727272 "Nickel"
  "6": "[38;2;130;130;130m", # #828282 "Battleship  Gray"
  "7": "[38;2;146;146;146m", # #929292 "Mountain  Mist"
  "8": "[38;2;161;161;161m", # #a1a1a1 "Star  Dust"
  "9": "[38;2;177;177;177m", # #b1b1b1 "Magnesium"
  "10": "[38;2;192;192;192m", # #c0c0c0 "Silver"
  "11": "[38;2;208;208;208m", # #d0d0d0 "Concrete"
  "12": "[38;2;224;224;224m", # #e0e0e0 "Zircon"
  "13": "[38;2;239;239;239m", # #efefef "Gallery"
  "14": "[38;2;255;255;255m", # #ffffff "White"

};

def _colourify(colour): escape + colour + . + escape + reset;
def _gs0: _colourify(greyscale["0"]);
def _gs1: _colourify(greyscale["1"]);
def _gs2: _colourify(greyscale["2"]);
def _gs3: _colourify(greyscale["3"]);
def _gs4: _colourify(greyscale["4"]);
def _gs5: _colourify(greyscale["5"]);
def _gs6: _colourify(greyscale["6"]);
def _gs7: _colourify(greyscale["7"]);
def _gs8: _colourify(greyscale["8"]);
def _gs9: _colourify(greyscale["9"]);
def _gs10: _colourify(greyscale["10"]);
def _gs11: _colourify(greyscale["11"]);
def _gs12: _colourify(greyscale["12"]);
def _gs13: _colourify(greyscale["13"]);
def _gs14: _colourify(greyscale["14"]);
