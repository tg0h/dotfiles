#toggl time tracking
# Details
  #  d
    #  dt
  #  dd - timeline
# Week
  #  w - projects by week
  #  ww - projects+tags by week
# Month
  #  m
#  Summary
    # s - summary
      # st
      # sw
      # sm
    # sd - Summary with details
      # sdt
      # sdm

## candy
alias td="timt -w c -t d" # client, project, tag
alias tdt="timt -w c -t d -s today"
alias tdd="timt -w c -t d --dd" # timeline report
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

## dev - h
alias thd="timt -w h -t d"
alias thdd="timt -w h -t d --dd"
alias thdt="timt -w h -t d -s today"
alias thw="timt -w h -t w"
alias thw="timt -w h -t d --ww -s 0cw"
alias thm="timt -w h -t d --ww -s 1"
alias ths="timt -w h -t s"
alias thst="timt -w h -t s -s today"
alias thsw="timt -w h -t s -s 0cw"
alias thsm="timt -w h -t s -s 1"
alias thsd="timt -w h -t s -d"
alias thsdt="timt -w h -t s -d -s today"
alias thsdm="timt -w h -t s -d -r 0m"

## study - t
alias ttd="timt -w s -t d" # client, project, tag
alias ttdt="timt -w s -t d -s today"
alias ttdd="timt -w s -t d --dd" # timeline report
alias ttw="timt -w s -t w"
alias ttww="timt -w s -t d --ww -s 0cw" #detailed report starting this week
alias ttm="timt -w s -t d --ww -s 1" #wide report starting from the 1st
alias tts="timt -w s -t s"
alias ttst="timt -w s -t s -s today"
alias ttsw="timt -w s -t s -s 0cw" #since start of this week
alias ttsm="timt -w s -t s -s 1" #since start of this month
alias ttsd="timt -w s -t s -d"
alias ttsdt="timt -w s -t s -d -s today"
alias ttsdm="timt -w s -t s -d -r 0m"
