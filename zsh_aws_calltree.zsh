function ct2csv(){
  # convert call tree campaign excel to csv
  # be careful of names with commas
  in2csv --sheet USERS $1 > report.toSend.csv
 
  # remove lines with only commas,
  # -i - edit file in place
  # gsed option /pattern/command
  # d - delete command
  gsed -i '/^,*$/d' report.toSend.csv
}

function ctrep(){
  # generate calltree campaign report
  # how to generate report
  # ctp to pull logs from phone
  # manually copy campaign csv to local folder
  # ct2csv <filename> to convert excel to csv
  # run ctrep to generate wasNotSent.report.csv
  
  # don't use gawk, you run into trouble if the name has a comma
  # gawk -F, '{print $4}' report.toSend.csv > report.toSend.uniq.csv

  csvcut -c 4 report.toSend.csv | sort | guniq -cd > report.toSend.duplicates.csv

  #generate sms sent report
  gawk -F, 'NF {print $3}' call-tree-sms-delivery.log > report.sent.log

  # remove country code
  #remove the first 3 chars of every line
  gawk '{gsub(/^.{3}/, ""); print}' report.sent.log > report.sentClean.log

  # add a header row to sent
  gsed -i '1i Sent' report.sentClean.log

  # left join toSend with sentClean
  # pipe to rg to remove lines with only , 
  # rg -v means invert match
  xsv join --left 4 report.toSend.csv 1 report.sentClean.log > report.wasSent.csv
  
  # search the 9th column for nothing
  # which of the toSend was not sent?
  # TODO: 9th column hardcoded?
  xsv search -s Sent '^$' report.wasSent.csv > report.wasNotSent.csv

  gsort report.sentClean.log | guniq -cd > report.duplicateSent.log

  # echo begin: $(head -n1 call-tree-error.log | cut -d ' ' -f 1,2)
  local beginDate=$(head -n1 call-tree-error.log | cut -d ' ' -f 1,2)
  # echo end: $(tail -n2 call-tree-sms-delivery.log | head -n1 | cut -d , -f 1)
  local endDate=$(tail -n2 call-tree-sms-delivery.log | head -n1 | cut -d , -f 1)
  local beginEpoch=$(gdate --date "$beginDate" +%s)
  local endEpoch=$(gdate --date "$endDate" +%s)
  local duration=$((endEpoch - beginEpoch))

  local toSendTmp=$(wc -l <report.toSend.csv)
  local toSend=$(( toSendTmp - 1 ))
  local toSendDuplicates=$(wc -l <report.toSend.duplicates.csv | tr -d " ")
  local toSendUniqueUsers=$(( toSend - toSendDuplicates ))

  #remove whitespace with tr
  #use < to remove filename from wc 
  local sent=$(wc -l <report.sent.log | tr -d " ")
  local sentUnique=$(sort report.sent.log | guniq -c | wc -l | tr -d " ")
  local sentSuccessRate=$(bc <<< "scale=3; ($sentUnique/$toSendUniqueUsers)*100")

  local notSentTmp=$(wc -l < report.wasNotSent.csv)
  local notSent=$(( notSentTmp - 1 ))

  local usersWithMultipleSms=$(wc -l <report.duplicateSent.log | tr -d " ")
  local duplicateSmsTotalTmp=$(gawk -F' ' '{sum += $1} END {print sum}' report.duplicateSent.log)
  # if i receive 2 smses, there is 1 duplicate
  local duplicateSmsTotal=$(( duplicateSmsTotalTmp - usersWithMultipleSms ))

  #use bc to perform division with floating point numbers
  local durationHours=$(bc <<< "scale=3; $duration/60/60")
  local smsSpeed=$(bc <<< " $sent/$durationHours")

  echo CAMPAIGN RUN DETAILS:
  echo -e "duration: \t\t $(displaytime $duration)"
  echo -e "campaign actual begin: \t $beginDate"
  echo -e "campaign actual end: \t $endDate"
  echo

  echo -e "duration (h): \t $durationHours h"
  echo -e "sms speed: \t $smsSpeed sms/h"
  echo

  echo CAMPAIGN DATA QUALITY:
  echo -e "to send duplicates (phone number duplicated): \t $toSendDuplicates"
  echo

  echo SMS STATISTICS:
  echo -e "smses to send: \t\t $toSend"
  echo -e "smses sent (inc dups): \t $sent"
  echo -e "smses not sent: \t $notSent"
  echo -e "sms duplicate total: \t $duplicateSmsTotal (example: if i receive 2 smses, there is 1 duplicate sms)"

  echo

  echo USER STATISTICS:
  echo -e "Unique users to send to: \t\t $toSendUniqueUsers"
  echo -e "Users who received at least 1 sms: \t $sentUnique"
  echo -e "Sent Success Rate (% of users reached): \t $sentSuccessRate%"
  echo

  echo USER FAILURE METRICS:
  echo -e "Users who did not receive an sms:  \t $notSent"
  echo -e "users w/ multiple sms: \t $usersWithMultipleSms"
  echo 

  bat report.toSend.duplicates.csv

  bat report.wasNotSent.csv

  bat report.duplicateSent.log
}

function ctlist(){
  aws events list-rules | jq -r '.Rules[] | .Name'
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
