def RoundTo2Dp: .*100.0|round/100.0;

def RoundTo($precision):
  pow(10;$precision) as $factor
  | if $precision == 0 
      then . | round
    else 
      .*$factor|round/$factor
    end
;
