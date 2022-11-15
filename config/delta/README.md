# README

https://dandavison.github.io/delta/full---help-output.html

https://git-scm.com/docs/git-config#Documentation/git-config.txt-color
contains 0,1 or 2 colours
must specify fg if you want to specify bg
attributes can be in any position
<fg colour> <bg colour> <attribute 1> <attribute 2> <attribute n...>
NOTE: attributes: blink bold dim hidden italic reverse strike ul
NOTE: the special omit attribute is supported by commit-style, file-style and hunk-header-style - meaning remove from output

In addition to real colors, there are 4 special color names: 'auto', 'normal', 'raw', and 'syntax'.
auto - delta chooses colour automatically
normal - your terminal's foreground/background colour
syntax - can only be used for foreground (text), used to syntax highlight text
raw - delta strips colours from its input, if you want delta to output the colours unchanged, use --raw

empty string '' style means do not apply any colours or styling

4 ways to specify colour
css colour
rgb hex
ansi colour name - black, red, green, yellow, blue magenta, cyan, white and bright form brightred...
ansi colour number (8 bit - 256 numbers)
