#!/bin/bash
#
# Displays a countdown timer for the specified period
#

function usage {
    echo "Usage: $(basename "$0") [-s seconds] [-m minutes] [-h hours] [-q] [-f]"
    exit 1;
}
function checkUsage {
    [[ "$1" =~ [1-9][0-9]* ]] || usage
}

## parse provided arguments
seconds=0
minutes=0
hours=0
quiet=''
flash=''
while getopts ":s:m:h:qf" option; do
    case $option in
        s)
            checkUsage $OPTARG
            seconds="$OPTARG";;
        m) 
            checkUsage $OPTARG
            minutes="$OPTARG";;
        h) 
            checkUsage $OPTARG
            hours="$OPTARG";;
        q) 
            quiet=1;;
        f) 
            flash=1;;
    esac
done

## check for extraneous non-flag args
shift $((OPTIND-1))
[[ ${#1} -gt 0 ]] && usage

## countdown duration
remaining=$(($hours*3600 + $minutes*60 + $seconds))

function writeTime {
    if [ ! $1 ]; then
        printf "\r%02d:%02d:%02d" $(($2/3600)) $(($2/60%60)) $(($2%60))
    fi
}

## run timer
[ ! "$quiet" ] && tput civis && echo ''
writeTime "$quiet" "$remaining"
while [[ $remaining -gt 0 ]]; do
    sleep 1
    let remaining=$remaining-1
    writeTime "$quiet" "$remaining" 1
done

## final output
[ ! "$quiet" ] && tput cnorm && echo -e "\n\nTimer complete"
if [ "$flash" ]; then
    for i in {0..2}; do
        printf '\e[?5h' && sleep .25 && printf '\e[?5l'
        sleep .4
    done
fi
