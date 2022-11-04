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
  else .
  end
  ;

def setImageSortKey:
  .Repository as $repo |
  if $repo | startswith("203") then ._sortKey = 3 # rc images
  elif $repo | contains("/") then ._sortKey = 2 # images from docker registry
  else ._sortKey = 1 # local images
  end
;

def dil($sortBy):
  map(setMonthsAgo)
  | map(SetUnitSize)
  | map(SetKbSize)
  | map(setImageSortKey)

  | _sortBy($sortBy)
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

