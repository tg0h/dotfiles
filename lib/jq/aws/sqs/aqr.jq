include "date";
include "pad";
include "colour";
# use this with the scratchz function to create a jq playground
# store the json in /tmp/t (use CT, T)
# call scratchz to call the zsh scratchz function

def formatMessageBody: 
.sentTime = (.Attributes.SentTimestamp |.[0:-3]|tonumber|todate)
| .taskName = (.MessageAttributes.taskName.StringValue // "")
;

def formatTable:
  "\(.sentTime)"
  +" "
  +"\(.Attributes.ApproximateReceiveCount)"
  +" "
  +"\(.MessageId|.[0:8]|__(.))"
  +" "
  +"\(.ReceiptHandle|.[0:12]|__(.))"
  +" "
  +"\(.taskName|rp(25))"
  +" "
  +"\(.Body)"
;

def aqr: 
  .Messages
  | map(formatMessageBody)
  | map(formatTable) 
  | .[]
;
