function imm(){
  # image magick mogrify - resize a file
  # mogrify -resize 1242x2208 <fileName>
  # imm <resize Dimensions> <fileName>
  
  mogrify -resize $1 $2
}

function imc(){
  # image magick convert crop
  # convert <fileName> -crop <cropDimensions> <outputFileName>
  # default the offset to +0+0
  # convert img123.png -crop 1242x2208+0+0 outputFile.png
  # default outputFileName to inputFileName
  # the crop dimensions are the to-be dimensions of the file
  # the offset is relative to the top left of the original file
  # imc inputFile 500x500+0+0
  
  convert $1 -crop $2'+0+0' $1
}
