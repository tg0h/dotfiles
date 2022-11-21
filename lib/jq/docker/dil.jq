include "pad";
include "colour";
include "colour-scale";
# include "docker";
include "docker/docker.bytes-format";
include "docker/docker.size";
include "docker/docker.time";
include "docker/docker.image-tag";

def _sortBy($sortBy):
  if $sortBy == "createdAt" then sort_by(.CreatedAt) | reverse
    elif $sortBy == "repository" then sort_by(._sortKey,.Repository)
    elif $sortBy == "size" then sort_by(._sizeKb) | reverse
    # else sort_by(.refName,.commiterName, .committerDateSecondsAgo)
    else sort_by(.refName)
  end
  | .
  ;

def setImageSortKey:
  .Repository as $repo |
  if $repo | startswith("203") then ._sortKey = 3 # rc images
  elif $repo | contains("/") then ._sortKey = 2 # images from docker registry
  else ._sortKey = 1 # local images
  end
;

def filterImage($imageFilter):
  if $imageFilter == "all" then true
  elif $imageFilter == "slash" then ._sortKey == 2 # TODO: use another property
  elif $imageFilter == "local" then ._sortKey == 1
  elif $imageFilter == "candy" then ._sortKey == 3
  else
    true
  end
;

def dil($sortBy; $rev; $imageFilter):
  map(setMonthsAgo)
  | map(SetUnitSize)
  | map(SetKbSize)
  | map(setImageSortKey)
  | map(select(filterImage($imageFilter)))
  | _sortBy($sortBy)
  | if $rev then reverse else . end
  | .[]
  | ._monthsAgo as $monthsAgo
  | ._unit as $unit
  | ._size as $size

  | " \(.ID| .[0:5] |__(.))"
  +" \(._monthsAgo|_monthDiff)"
  +" \(.CreatedAt|FormatCreatedAtTime($monthsAgo))"
  +" \(DockerBytesFormat($size;$unit;4))"
  +" \(.Repository|_repository)"
  +" \(.Tag|_tag|rp(15))"

  # +" \(.Size)"
  # +" \(.VirtualSize)"
  ;

