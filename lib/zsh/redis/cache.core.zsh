function rcache(){
  # rcache gets the api results from the cache or calls the api for you
  # rcache <cache key[.expiry]> <function> <option 1> <option 2> ...
  # the -r reload option ignores the cache, fetches the function result and stores it in cache
  # rcache -r ...
  # eg rcache jira/ras.60 ras
  #
  # NOTE: DO NOT ECHO any output other than the function output
  # callers of rcache expect that rcache will only output the cache/func value
  # to stdout

  # model cache behaviour options on browser fetch api
  # https://developer.mozilla.org/en-US/docs/Web/API/Request/cache
  local cacheReload

  while getopts 'r' opt; do
    case "$opt" in
      r) cacheReload=true ;;
    esac
  done
  shift $(($OPTIND - 1))

  if [[ $# -lt 2 ]]; then
    echo $fg[red]error:$reset_color 'please provide a <cache key> and the <function> to call' >&2
    return 1
  fi

  local cacheKeyExpiry func
  # echo number of args is $#
  cacheKeyExpiry=$1
  func=$2
  shift 2
  # pop the 1st 2 args off the arg list
  # now the old $3 is the new $1

  local cacheKey cacheExpiry
  # cacheKeyExpiry may be test.123 ( key of test, expiry of 123 seconds ) or
  # test (no expiry specified)
  if [[ "$cacheKeyExpiry" =~ "\." ]]; then
    # a greedy match will ignore multiple periods
    # eg passing in prefix..suffix will stil parse correctly, removing both periods
    cacheKey=${cacheKeyExpiry%%\.*} # % means greedily match pattern \.* and remove pattern from end
    cacheExpiry=${cacheKeyExpiry##*\.} # # means greedily match pattern *\. and remove from the start
  else
    cacheKey=$cacheKeyExpiry
  fi

  local response cacheValue funcResult
  #rcg = redis-cli get
  cacheValue=$(rcg $cacheKey)

  if [[ -z "$cacheValue" ]] || [[ -n "$cacheReload" ]]; then
    # echo number of args is $#
    # echo remaining args is $@
    # echo $fg[green] 'calling function' $func $reset_color
    funcResult=$(eval $func $@)
    #rcs sets the cache, ignores expiry if none provided
    rcs $cacheKey $funcResult $cacheExpiry
  fi
  # return the cache value. if null, return funcResult
  echo ${cacheValue:-$funcResult}
}
