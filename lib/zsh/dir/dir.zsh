function lt1(){

    while getopts 'd' OPT; do
        case "$OPT" in
            d) dir=~/Downloads/;;
        esac
    done
    shift $(($OPTIND - 1))

    # -t sort by latest first
    # -p add trailing / to directories
    # -d add full path to file name
    local latestFile=$dir$(ls -tp $dir | rg -v / | head -n1)
    cp $latestFile .
    echo copied $fg[green]$latestFile$reset_color here
}
