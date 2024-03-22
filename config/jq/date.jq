include "pad";
include "time-format";
include "colour";

# https://github.com/stedolan/jq/issues/1053
# https://ijmacd.github.io/rfc3339-iso8601/

# converts iso date timezone offset to offset in seconds
# +12
# +0800
# +08
# Z
# +08:30
# +08:00
# -08:00
# -08
# TO
# converts input iso time string to
# {
#   "sign": "+",
#   "_hour": "08",
#   "_minute": "00",
#   "hour": 8,
#   "minute": 0
# },
def _setOffset:
  if type == "object" then 
    (if ._offset == "Z" then
      { "sign": "+", "_hour": 0, "_minute": 0 }
    else
      (._offset | capture("(?<sign>\\+|\\-)(?<_hour>\\d\\d)(?::)?(?<_minute>\\d\\d)?") )
    end) as $offsetObject 
    | .hour = ($offsetObject._hour // 0 | tonumber)
    | .minute = ($offsetObject._minute // 0 | tonumber)
    | (if .sign == "+" then .hour * 60*60 + .minute*60
      else -(.hour * 60*60 + .minute*60)
      end) as $offsetSeconds
      | .offset = $offsetSeconds
  else . end
;

def _setUnixTime:
    .unixTime = (.date+"T"+.time+"Z" | fromdate) + .offset;
def _trimOffset: 
  if type == "object" then ._offset = (.__offset|ltrim) else . end;
def _removeFractionalSeconds: 
  if type == "object" then .time = ._time[0:8] else . end;
# "2022-07-13 19:08:59"
# "2022-07-13 19:08:59Z"
# "2022-07-13 19:08:59 +0800"
# "2022-07-13 19:08:59+0800"
# "2022-09-30T11:01:31.511000-08:00"
# "2022-09-30T11:01:31.511000+08:00"
# "2022-09-30T11:01:31.511000+08:00"
def _toDateTimeOffsetObject:
  if . == null then null
  else
    # if passed in string does not match capture, pass it through so we do not
    # swallow input
    # _time may contain time with fractional seconds
    # _offset may have leading whitespace
    (
    capture("(?<date>[0-9\\-\\/]+?)(T|\\s)(?<_time>[0-9\\:\\.]+)(?<__offset>.*)")
    | _removeFractionalSeconds
    | _trimOffset
    | _setOffset
    | _setUnixTime
    )
    // .
  end;

def aws_fromdate:
# if pass in null, return ""
# convert eg 2022-09-30T11:01:31.511000+08:00 to unix time
  if . == null then 
    null
  else
    . [0:19]+"Z" | fromdate
  end;

# return duration in s
# accepts unix time
def _duration_s($startTime;$endTime):
  if ($startTime | type) == "string" or ($startTime | type) == "null" or 
     ($endTime | type) == "string" or  ($endTime | type) == "null" 
  then
    null
  else
    $endTime - $startTime
  end;

# expects 2022-11-06 13:21:22
# TODO: does not consider timezone 2022-11-15 22:15:23 +0800
def ToSeconds:
  if . == null then null
  else
    _toDateTimeOffsetObject | .unixTime
  end
;

# def _toSeconds($timeZoneOffset):
#   if . == null then null
#   else
#     ( .[0:10]+"T"+.[11:19]+"Z" | fromdate ) + $timeZoneOffset * 60*60
#   end
# ;
#
# def _setSecondsAgo($offset): .;

# accepts unixTime and converts to iso date object in UTC
def ToDateObject($offsetHours):
  ((. + $offsetHours * HOUR) | todate) as $isoDate
  | ($isoDate[0:4] | tonumber) as $year
  | ($isoDate[5:7] | tonumber) as $month
  | ($isoDate[8:10] | tonumber) as $day
  | ($isoDate[11:13] | tonumber) as $hour
  | ($isoDate[14:16] | tonumber) as $minute
  | ($isoDate[17:19] | tonumber) as $second
  | { $year,$month,$day,$hour,$minute,$second }
;

def ToDateObject: ToDateObject(0);
def ToLocalDateObject: ToDateObject(8);

# accepts format string of ymdhMs
# specify yy for 4 year format
def ToDateFormatObject($_format; $offsetHours):
  ($_format|tostring) as $format
  |((. + $offsetHours * HOUR) | todate) as $isoDate
  |(if ($format | contains("y")) then 
      if ($format | contains("yy")) then 
        $isoDate[0:4]
      else
        $isoDate[2:4]
      end 
  else "" end) as $year
  | (if ($format | contains("m")) then $isoDate[5:7] else "" end) as $month
  | (if ($format | contains("d")) then $isoDate[8:10] else "" end) as $day
  | (if ($format | contains("h")) then $isoDate[11:13] else "" end) as $hour
  | (if ($format | contains("M")) then $isoDate[14:16] else "" end) as $minute
  | (if ($format | contains("s")) then $isoDate[17:19] else "" end) as $second
  | (if ($year|length) > 0 and ($month|length) > 0 then "-" else "" end) as $yearSeparator
  | (if ($month|length) > 0 and ($day|length) > 0 then "-" else "" end) as $monthSeparator
  | (if ($day|length) > 0 and ($hour|length) > 0 then " " else "" end) as $daySeparator
  | (if ($hour|length) > 0 and ($minute|length) > 0 then ":" else "" end) as $hourSeparator
  | (if ($minute|length) > 0 and ($second|length) > 0 then "." else "" end) as $minuteSeparator
  | 
  { $year,$month,$day,$hour,$minute,$second }
  # "\($year)"
  # +"\($yearSeparator)"
  # +"\($month)"
  # +"\($monthSeparator)"
  # +"\($day)"
  # +"\($daySeparator)"
  # +"\($hour)"
  # +"\($hourSeparator)"
  # +"\($minute)"
  # +"\($minuteSeparator)"
  # +"\($second)"
;

def ToDateFormatObject($_format): ToDateFormatObject($_format; 0);
def ToLocalDateFormatObject($_format): ToDateFormatObject($_format; 8);

# accepts unixTime and converts to iso date in SG time
def ToLocalDate:.;

# see afl for example
def FormatDate($dateFormatObject):
  $dateFormatObject.year as $year
  | $dateFormatObject.month as $month
  | $dateFormatObject.day as $day
  | $dateFormatObject.hour as $hour
  | $dateFormatObject.minute as $minute
  | "\($year|__(.))"
      +__("/")
      +"\($month|__(.))"
      +__("/")
      +"\($day|_bt(.))"
      +" "
      +"\($hour)"
      +__(":")
      +"\($minute|__(.))"
;

