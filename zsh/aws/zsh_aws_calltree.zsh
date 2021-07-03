function ct2csv(){
  # convert call tree campaign excel to csv
  # be careful of names with commas
  # the canonical form is a number with a country code
  # remove spaces and -'s ?
  # if the number has only 8 digits, assume it is a sg number and add +65 to the number

  in2csv --sheet USERS $1 > report.toSend.orig.csv

  # remove lines with only commas,
  # -i - edit file in place
  # gsed option /pattern/command
  # d - delete command
  gsed '/^,*$/d' report.toSend.orig.csv > report.toSend.csv

  # remove numbers with spaces in them, since calltree will remove the spaces, these numbers are ok
  # important, combine whitespaces before removing country code below, there is a sequential dependency
  gsed -Ei 's/(,[0-9]*)\s+([0-9]*,)/\1\2/' report.toSend.csv
  #
  # remove numbers with -'s in them, since calltree will remove the -'s, these numbers are ok
  gsed -Ei 's/(,[0-9]*)-+([0-9]*,)/\1\2/' report.toSend.csv

  # if the number is 8 digits long, assume it is an sg number and add +65
  gsed -Ei 's/,([0-9]{8}),/,\+65\1,/' report.toSend.csv

  # if the number is eg 6512345678, add a +
  gsed -Ei 's/,(65[0-9]{8}),/,\+\1,/' report.toSend.csv
}

function ctrep(){
  # TODO: option to specify how many smses in the message body
  # generate calltree campaign report
  # how to generate report
  # ctp to pull logs from phone
  # manually copy campaign csv to local folder
  # ct2csv <filename> to convert excel to csv
  # run ctrep to generate wasNotSent.report.csv

  # don't use gawk, you run into trouble if the name has a comma
  # gawk -F, '{print $4}' report.toSend.csv > report.toSend.uniq.csv
  local smsPerMessage=1
  while getopts 's:' opt; do
    case "$opt" in
      s) smsPerMessage=$OPTARG ;;
    esac
  done
  shift $(($OPTIND - 1))

  # does the campaign try to send the message to the same user more than once?
  # (user phone number repeated in excel)
  csvcut -c 4 report.toSend.csv | sort | guniq -cd > report.toSend.duplicates.csv

  # generate sms sent report
  gawk -F, 'NF {print $3}' call-tree-sms-delivery.log > report.sent.log

  # ASSUMPTION!
  # remove country code
  # remove the first 3 chars of every line
  # TODO: DANGEROUS !!!!!
  # gawk '{gsub(/^.{3}/, ""); print}' report.sent.log > report.sentClean.log

  # add a header row to sent
  gsed -i '1i Sent' report.sent.log

  # left join toSend with sent
  # pipe to rg to remove lines with only ,
  # rg -v means invert match
  xsv join --left 4 report.toSend.csv 1 report.sent.log > report.toSendLeftJoinSent.csv

  # search the 9th column for nothing
  # which of the toSend was not sent?
  # TODO: 9th column hardcoded?
  xsv search -s Sent '^$' report.toSendLeftJoinSent.csv > report.wasNotSent.csv

  # echo begin: $(head -n1 call-tree-error.log | cut -d ' ' -f 1,2)
  local beginDate=$(head -n1 call-tree-error.log | cut -d ' ' -f 1,2)
  # echo end: $(tail -n2 call-tree-sms-delivery.log | head -n1 | cut -d , -f 1)
  local endDate=$(tail -n2 call-tree-sms-delivery.log | head -n1 | cut -d , -f 1)
  local beginEpoch=$(gdate --date "$beginDate" +%s)
  local endEpoch=$(gdate --date "$endDate" +%s)
  local duration=$((endEpoch - beginEpoch))

  # remove the header row of report.sent.log before processing it for counts
  gsed 1d report.sent.log | sort | guniq -c | gawk -v smsPerMessage=$smsPerMessage '{ if ($1 == smsPerMessage) print $0}' > report.sent.exactMessage.log
  local sentExactMessage=$(wc -l < report.sent.exactMessage.log | tr -d " ")
  gsed 1d report.sent.log | sort | guniq -c | gawk -v smsPerMessage=$smsPerMessage '{ if ($1 > smsPerMessage) print $0}' > report.sent.duplicateMessage.log
  local sentDuplicateMessage=$(wc -l < report.sent.duplicateMessage.log | tr -d " ")
  gsed 1d report.sent.log | sort | guniq -c | gawk -v smsPerMessage=$smsPerMessage '{ if ($1 < smsPerMessage) print $0}' > report.sent.partMessage.log
  local sentPartMessage=$(wc -l < report.sent.partMessage.log | tr -d " ")

  local sentSuccessIncDups=$(( sentExactMessage + sentDuplicateMessage ))

  # TO SEND STATS
  # local toSendTmp=$(wc -l <report.toSend.csv)
  # do not count the header
  local toSend=$(( $(wc -l <report.toSend.csv) - 1 ))
  # local toSend=$(( toSendTmp - 1 ))
  local toSendDuplicates=$(wc -l <report.toSend.duplicates.csv | tr -d " ")
  local toSendUniqueUsers=$(( toSend - toSendDuplicates ))
  local sentSuccessRateTmp=$(bc <<< "scale=3; ($sentSuccessIncDups*100/$toSendUniqueUsers)")
  # use printf to format the decimal places
  local sentSuccessRate=$(printf %.0f $sentSuccessRateTmp)

  # NOT SENT STATS
  #number of users who did not receive the entire message
  local notSentTmp=$(wc -l < report.wasNotSent.csv | tr -d " ")
  local notSent=$(( notSentTmp - 1 ))

  # local usersWithMultipleSms=$(wc -l <report.sent.duplicateMessage.log | tr -d " ")
  local duplicateSmsTotal=$(( $(gawk -F' ' '{sum += $1} END {print sum}' report.sent.duplicateMessage.log) - $sentDuplicateMessage ))
  # if i receive 2 smses, there is 1 duplicate
  # local duplicateSmsTotal=$(( duplicateSmsTotalTmp - usersWithMultipleSms ))

  rg -v '\+65' report.toSend.csv > report.dodgyNumbers.csv
  local dodgyNumbers=$(( $(wc -l < report.dodgyNumbers.csv) - 1 ))

  #use bc to perform division with floating point numbers
  local durationHours=$(bc <<< "scale=3; $duration/60/60")
  local sent=$(wc -l <report.sent.log | tr -d " ")
  local smsSpeed=$(bc <<< " $sent/$durationHours")

  echo CAMPAIGN RUN DETAILS:
  printf "%41s\n" "$(displaytime $duration)"
  printf "%-20s %20s\n" "campaign begin:" $beginDate
  printf "%-20s %20s\n" "campaign end:" $endDate
  printf "%-30s %10s\n" "sms to send in the message:" $smsPerMessage
  echo

  printf "%-40s %.3f h\n" "duration (h):" $durationHours
  printf "%-40s %5d sms/h\n" "sms speed:" $smsSpeed
  echo

  echo CAMPAIGN DATA QUALITY:
  printf "%-40s %5d\n" "duplicate phone numbers:" $toSendDuplicates
  printf "%-40s %5d\n" "dodgy numbers:" $dodgyNumbers
  echo
  echo SMS STATISTICS:
  LC_ALL=en_US.UTF-8 printf  "%-40s %5d \n" "users to send to:" $toSend
  # super hack, temporarily change the locale for the gprintf command
  # note the ' in %'5d to indicate that grouping should be used?
  LC_ALL=en_US.UTF-8 printf "%-40s %'5d\n" "smses to send:" $(( $toSend * $smsPerMessage ))
  LC_ALL=en_US.UTF-8 printf  "%-40s %'5d\n" "smses sent (inc dups):" $sent
  LC_ALL=en_US.UTF-8 printf  "%-40s %'5d\n" "sms duplicate total:" $duplicateSmsTotal
  gprintf  "\t example:\n"
  gprintf  "\t   if the message requires 1 sms and I receive 2 smses, there is 1 duplicate sms\n"
  gprintf  "\t   if the message requires 5 smses and I receive 6 smses, I received 1 duplicate sms\n"
  echo

  echo USER STATISTICS:
  LC_ALL=en_US.UTF-8 printf "%-40s %'5d" "Unique users to send to:" $toSendUniqueUsers
  echo
  echo USER SUCCESS METRICS:
  LC_ALL=en_US.UTF-8 printf   "%-40s %'5d\n" "Users who received the full message:" $sentSuccessIncDups
  printf "    of which:\n"
  LC_ALL=en_US.UTF-8 printf "      received exactly %d smses: \t %'5d\n" $smsPerMessage $sentExactMessage
  LC_ALL=en_US.UTF-8 printf "%-40s %'5d\n" "      received duplicate smses:" $sentDuplicateMessage
  echo
  printf "%-40s %5d%%\n" "Sent Success Rate (% users reached):" $sentSuccessRate
  echo


  echo USER FAILURE METRICS:
  printf "%-40s %'5d\n" "Did not receive the full message:" $(( sentPartMessage + notSent ))
  printf "    of which:\n"
  printf "%-40s %'5d\n" "      received part of the smses" $sentPartMessage
  printf "%-40s %'5d\n" "       did not receive any sms:" $notSent
  echo
  printf "%-40s %'5d" "Users who received duplicate smses:" $sentDuplicateMessage
  echo

  bat report.dodgyNumbers.csv

  bat report.toSend.duplicates.csv

  bat report.wasNotSent.csv

  bat report.sent.duplicateMessage.log

  bat report.sent.partMessage.log
}

function ctlist(){
# for more on how to read aws cron expressions, see https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html
# see https://github.com/stedolan/jq/wiki/Docs-for-Oniguruma-Regular-Expressions-(RE.txt) for how to use jq regex
# jq coalesce - see https://stedolan.github.io/jq/manual/#Alternativeoperator:// for how to use a fallback value if value does not exist

# the cloudwatch rule name for calltree contains the time when the email was sent. 
# as expected, the time is the same for both the generate and run rul
  local default=true
  local raw
  local getName
  while getopts 'rn' opt; do
    default=
    case "$opt" in
      r) raw=true ;;
      n) getName=true;;
    esac
  done
  shift $(($OPTIND - 1))

  # $# refers to number of args
  # -z tests if length of string is zero
  # use -eq 0 instead
  if [[ -n $default ]]; then
    ## string | capture("(?<minutes>[0-9,*-?]* ...)
    # in jq, use capture to define a named capturing group
    # jq creates an object with the name of the capture group as a key
    # note the character class which contains many special characters, which do 
    # not need to be escaped
    # the special chars are because aws cron expressions include special chars 
    # such as , - * ? and /
    # aws events list-rules | jq -r '.Rules[] | .ScheduleExpression | capture("(?<minutes>[0-9,*-/?]*)") | .minutes '
    #
    # note the jq // operator which acts like a sql coalesce, if .ScheduleExpression is null, fallback to an empty string
    # this avoids the capture throwing an error when it tries to operator on null
    # this is the error: if you try to capture on null - null (null) cannot be matched, as it is not a string
    #
    # jq - define a function
    # see https://github.com/stedolan/jq/issues/2033 for the lpad function
    # https://stackoverflow.com/questions/64957982/how-to-pad-numbers-with-jq
    # (When a string is multiplied by a number it is repeated that many time e.g. "foo" * 3 -> "foofoofoo")
    
    aws events list-rules | jq -r 'def lpad($len; $fill): tostring | ($len - length) as $l | ($fill * $l)[:$l] + .;  def lpad($len; $fill): tostring | ($len - length) as $l | ($fill * $l)[:$l] + .; .Rules[] | ((.ScheduleExpression // "" | capture("(?<minutes>[0-9,*-/?]*) (?<hours>[0-9,*-/?]*) (?<days>[0-9,*-/?]*) (?<month>[0-9,*-/?]*) (?<dow>[0-9,*-/?]*) (?<year>[0-9,*-/?]*)") | .year + "-" + (.month | lpad(2;"0")) +"-" + (.days | lpad(2;"0")) + "T" + (.hours | lpad(2;"0"))  + ":" + (.minutes | lpad(2;"0")) + "Z" + " dow:" + .dow) // "") + " - " + .Name + " - " + .State' | sort
  elif [[ -n $raw ]]; then
    # get json
    aws events list-rules 
  elif [[ -n $getName ]]; then 
    # get name of rule, used for housekeeping together with the ctdel command
    aws events list-rules | jq -r '.Rules[] | .Name'
  fi
}

function ctfilter(){
  aws events list-rules | jq -r '.Rules[] | .Name' | rg $1
}

# TODO: how to remove target and delete rule in a single function?
# delete the cloudwatch rule target before deleting it
# run ctfilter ... | ctdelt, then run
# run ctfilter ... | ctdelr
function ctdelt(){
  # examples:
  # ctfilter 2020 | ctdelt
  # ctfilter 202103 | ctdelt
  parallel aws events remove-targets --rule {} --ids 1
  # parallel aws events delete-rule --name {}
}

# delete the cloudwatch rule after deleting the cloudwatch rule target
function ctdelr(){
  # examples:
  # ctfilter 2020 | ctdelr
  # ctfilter 202103 | ctdelr
  # parallel aws events remove-targets --rule {} --ids 1
  # to use, run this command: ctfilter 2020 | ctdelr
  parallel aws events delete-rule --name {}
}

## Android pirate ship log management

function ctl(){
  # list log directory on pirate ship
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d shell ls -la sdcard/Download
  else;
    adb -s $ip shell ls -la sdcard/Download
  fi
}

function ctc(){
  # TODO: make this parallel
  # run CAT | head or cat | tail
  local ip=$HP_CALLTREE_IP
  local head=
  local tail=

  while getopts 'ht' opt; do
    case "$opt" in
      h) head=true ;;
      t) tail=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  mkdir -p '/tmp/ctc/'

  if [[ -n $head ]]; then
    echo "error log ============"
    adb -d shell cat sdcard/Download/call-tree-error.log | head | gawk 'NF > 1 {print $0}'
    echo
    echo "error wc"
    adb -d shell cat sdcard/Download/call-tree-error.log | wc
    echo
    echo "delivery log ========="
    # not sure why the number of fields on the empty line is 1 when outputting from adb shell cat
    # add condition 'NF > 1' to remove 'empty' lines from adb shell cat output
    adb -d shell cat sdcard/Download/call-tree-sms-delivery.log | head | gawk 'NF > 1 {print $0}'
    echo
    echo "delivery wc"
    adb -d shell cat sdcard/Download/call-tree-sms-delivery.log | wc -l
  else;
    local p0out="/tmp/ctc/$RANDOM"
    adb -s $ip shell cat sdcard/Download/call-tree-error.log | tail | gawk 'NF > 1 {print $0}' >  p0out &
    P0=$!

    local p1out="/tmp/ctc/$RANDOM"
    adb -s $ip shell cat sdcard/Download/call-tree-error.log | wc -l > p1out &
    P1=$!

    local p4out="/tmp/ctc/$RANDOM"
    adb -s $ip shell cat sdcard/Download/call-tree-sms-delivery.log | tail | gawk 'NF > 1 {print $0}' > p4out &
    P3=$!

    local p2out="/tmp/ctc/$RANDOM"
    adb -s $ip shell cat sdcard/Download/call-tree-sms-delivery.log | wc -l > p2out &
    P2=$!

    wait $P0 $P1 $P2 $P3
    cat p0out
    cat p1out
    cat p2out
    cat p4out
  fi
}

#SEQUENTIAL
function ctcc(){
  # TODO: make this parallel
  # run CAT | head or cat | tail
  local ip=$HP_CALLTREE_IP
  local head=
  local tail=

  while getopts 'ht' opt; do
    case "$opt" in
      h) head=true ;;
      t) tail=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $head ]]; then
    echo "error log ============"
    adb -d shell cat sdcard/Download/call-tree-error.log | head | gawk 'NF > 1 {print $0}'
    echo
    echo "error wc"
    adb -d shell cat sdcard/Download/call-tree-error.log | wc
    echo
    echo "delivery log ========="
    # not sure why the number of fields on the empty line is 1 when outputting from adb shell cat
    # add condition 'NF > 1' to remove 'empty' lines from adb shell cat output
    adb -d shell cat sdcard/Download/call-tree-sms-delivery.log | head | gawk 'NF > 1 {print $0}'
    echo
    echo "delivery wc"
    adb -d shell cat sdcard/Download/call-tree-sms-delivery.log | wc -l
  else;
    echo "error log ==========="
    adb -s $ip shell cat sdcard/Download/call-tree-error.log | tail | gawk 'NF > 1 {print $0}'
    echo
    echo "error wc"
    adb -s $ip shell cat sdcard/Download/call-tree-error.log | wc -l
    echo
    echo "delivery log ========"
    # not sure why the number of fields on the empty line is 1 when outputting from adb shell cat
    # add condition 'NF > 1' to remove 'empty' lines from adb shell cat output
    adb -s $ip shell cat sdcard/Download/call-tree-sms-delivery.log | tail | gawk 'NF > 1 {print $0}'
    echo
    echo "delivery wc"
    adb -s $ip shell cat sdcard/Download/call-tree-sms-delivery.log | wc -l
  fi
}

function ctp(){
  # pull logs from pirate ship to current directory
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d pull sdcard/Download/call-tree-error.log
    adb -d pull sdcard/Download/call-tree-sms-delivery.log
    adb -d pull sdcard/Download/call-tree-sms-received.log
  else;
    adb -s $ip pull sdcard/Download/call-tree-error.log
    adb -s $ip pull sdcard/Download/call-tree-sms-delivery.log
    adb -s $ip pull sdcard/Download/call-tree-sms-received.log
  fi
}

function ctd(){
  # delete logs on pirate ship
  # TODO: d same as delete?
  local usbMode=
  local ip=$HP_CALLTREE_IP

  while getopts 'd' opt; do
    case "$opt" in
      d) usbMode=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ -n $usbMode ]]; then
    adb -d shell rm sdcard/Download/call-tree-error.log
    adb -d shell rm sdcard/Download/call-tree-sms-delivery.log
    adb -d shell rm sdcard/Download/call-tree-sms-received.log
  else;
    adb -s $ip shell rm sdcard/Download/call-tree-error.log
    adb -s $ip shell rm sdcard/Download/call-tree-sms-delivery.log
    adb -s $ip shell rm sdcard/Download/call-tree-sms-received.log
  fi

}
