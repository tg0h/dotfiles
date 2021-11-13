# rpad(5;" ") - add right padding with spaces up to a length of 5
# do not need to escape $ with \, unlike in a heredoc

def rpad($len; $fill):
  tostring | ($len - length) as $l | . + ($fill * $l)[:$l];

def lpad($len; $fill):
  tostring | ($len - length) as $l | ($fill * $l)[:$l] + .;

def rp($len):
  tostring | ($len - length) as $l | . + (" " * $l)[:$l];

def lp($len):
  tostring | ($len - length) as $l | (" " * $l)[:$l] + .;
