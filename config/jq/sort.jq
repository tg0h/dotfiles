# assumes that an array of sortKeys _sortKeys = [key1,key2,key3 ...] will be definied
# key1 will be sorted first
# key2 will be sorted second

# add a sortKey to an array of objects
# eg use add a sortKey key to the input array of objects, then sort by the sortKey 
# map(.sortKey = (getSortKey(.Name) // 99)) | sort_by(.sortKey)
# to_entries converts an array to an array of key value objects
# the key of the 0th element in the array is 0
def getSortKey($input; $sortKeys):
  $sortKeys | to_entries | map(select(.value==$input))[].key;

  # $key is the key to sort by 
  # assumes an array of objects an input.
  # [
  #   {"Name":"tim"},
  #   {"Name":"val"}
  #   {"Name":"joop"}
  # ] as $input
  # also assume _sortKeys = ["joop","val"]
  # then $input | _sort("Name") will add a sortKey key and sort by this sortKey
  # eg the ouput will be
  # [
  #   {"Name":"tim", ".sortKey": 99},
  #   {"Name":"val", ".sortKey": 1},
  #   {"Name":"joop", ".sortKey": 0},
  # ]
  # we can then sort the array by the sortKey to get our special sorting
def addSortKey($key;$sortKeys):
  map(.sortKey = (getSortKey(.[$key]; $sortKeys) // 99)); 
