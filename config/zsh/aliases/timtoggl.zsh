#toggl time tracking
# t
#  d
#  dd
#  dt
  #  w
  #  ww
  #  m
#  Summary
    # s
    # st
    # sw
    # sm
# tt
# tm

# 

## candy
alias td="timt -w c -t d"
alias tdd="timt -w c -t d --dd" #detailed report
alias tdt="timt -w c -t d -s today"

alias tw="timt -w c -t w"
alias tww="timt -w c -t d --ww -s 0cw" #detailed report starting this week

alias tm="timt -w c -t d --ww -s 1" #wide report starting from the 1st

alias ts="timt -w c -t s"
alias tst="timt -w c -t s -s today"
alias tsw="timt -w c -t s -s 0cw" #since start of this week
alias tsm="timt -w c -t s -s 1" #since start of this month

alias tsd="timt -w c -t s -d"
alias tsdt="timt -w c -t s -d -s today"
alias tsdm="timt -w c -t s -d -r 0m"

## hack
alias thd="timt -w h -t d"
alias thdd="timt -w h -t d --dd" #detailed report
# alias thdt="timt -w h -t d -s today"
#
alias thw="timt -w h -t w"
# alias tww="timt -w h -t d --ww -s 0cw" #detailed report starting this week
#
# alias tm="timt -w h -t d --ww -s 1" #wide report starting from the 1st
#
alias ths="timt -w h -t s"
alias thst="timt -w h -t s -s today"
alias thsw="timt -w h -t s -s 0cw" #since start of this week
alias thsm="timt -w h -t s -s 1" #since start of this month
#
alias thsd="timt -w h -t s -d"
alias thsdt="timt -w h -t s -d -s today"
alias thsdm="timt -w h -t s -d -r 0m"

## study
alias ttd="timt -w s -t d"
alias ttd="timt -w s -t d -s today" #today
alias ttdd="timt -w s -t d --dd" #detailed report

alias ttw="timt -w s -t w"
alias ttww="timt -w s -t d --ww -s 0cw" #detailed report starting this week

alias ttm="timt -w s -t d --ww -s 1" #wide report starting from the 1st

alias tts="timt -w s -t s"
alias ttsd="timt -w s -t s -d"
alias ttsdt="timt -w s -t s -d -s today"

## me
alias tmd="timt -w m -t d"
alias tmdd="timt -w m -t d --dd" #detailed report
alias tmdt="timt -w m -t d -s today"

alias tmw="timt -w m -t w"
alias tmww="timt -w m -t d --ww -s 0cw" #detailed report starting this week

alias tmm="timt -w m -t d --ww -s 1" #wide report starting from the 1st

alias tms="timt -w m -t s"
alias tmsd="timt -w m -t s -d"
alias tmsm="timt -w m -t s -d -r 0m"
