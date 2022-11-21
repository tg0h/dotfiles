def _bold: "\u001b[1m";
def _boldReset: "\u001b[22m";

def _dim: "\u001b[2m";
def _dimReset: "\u001b[22m";

def _italic: "\u001b[3m";
def _italicReset: "\u001b[23m";

def _underline: "\u001b[4m";
def _underlineReset: "\u001b[24m";

def _blink: "\u001b[5m";
def _blinkReset: "\u001b[25m";

def _reverse: "\u001b[7m"; # zzz this is a jq keyword!
def _reverseReset: "\u001b[27m";

def _hidden: "\u001b[8m";
def _hiddenReset: "\u001b[28m";

def _strikethrough: "\u001b[9m";
def _strikethroughReset: "\u001b[29m";

def dm: _dim + . + _dimReset;
def dm(text): _dim + text + _dimReset;

def bo: _bold + . + _boldReset;
def bo(text): _bold + text + _boldReset;

def it: _italic + . + _italicReset;
def it(text): _italic + text + _italicReset;

def ul: _underline + . + _underlineReset;
def ul(text): _underline + text + _underlineReset;

def rv: _reverse + . + _reverseReset;
def rv(text): _reverse + text + _reverseReset;

def hd: _hidden + . + _hiddenReset;
def hd(text): _hidden + text + _hiddeneReset;

def st: _strikethrough + . + _strikethroughReset;
def st(text): _strikethrough + text + _strikethroughReset;
