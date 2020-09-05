source $HOME/scripts/standard-vars.sh

## attributes:
printf "$set_attr" $bold
bold= 1
dim= 2 ## may not be supported
underline= 4
blink= 5 ## may not be supported
reverse= 7
hidden= 8 ## may not be supported
## Reset attributes to the default
## Clear the screen
## Clear to end of line

## screen codes
CSI=$ESC[ ## Control Sequence Introducer
NA=${CSI}0m
CLS=${CSI}H${CSI}2J
cle=$ESC[K

## cursor movement
cu_row_col="${CSI}%d;%dH"
cu_up=${CSI}%dA cu_down=${CSI}%dB
cu_d1=${CSI}1B cu_right=${CSI}%dC cu_left=${CSI}%dD
cu_save=${ESC}7 cu_restore=${ESC}8
## position cursor by row and column
## mv cursor up N lines
## mv cursor down N lines
## mv cursor down 1 line
## mv cursor right N columns
## mv cursor left N columns
## save cursor position
## restore cursor to last saved position
cu_vis="${CSI}?12l${CSI}?25h" cu_invis="${CSI}?25l"
cu_NL=$cu_restore$cu_d1$cu_save
## visible cursor
## invisible cursor
## move to next line
## set attributes
set_attr=${CSI}%sm ## set printing attribute
set_bold=${CSI}1m set_ul=${CSI}4m
set_rev=${CSI}7m
## equiv: printf "$set_attr" $bold
## equiv: printf "$set_attr" $underline ## equiv: printf "$set_attr" $reverse
## unset attributes unset_bold=${CSI}22m unset_ul=${CSI}24m unset_rev=${CSI}27m
## colors (precede by 3 for foreground, 4 for background) black=0
red=1 green=2 yellow=3 blue=4
magenta=5 cyan=6 white=7 fg=3 bg=4
## set colors set_bg="${CSI}4%dm" set_fg="${CSI}3%dm"
## e.g.: printf "$set_bg" $red
## e.g.: printf "$set_fg" $yellow set_fgbg="${CSI}3%d;4%dm" ## e.g.: printf "$set_fgbg" $yellow $red
