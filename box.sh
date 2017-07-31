#!/bin/bash
#
# Author: Michael Ajala
#
#
STORAGENAME="test";
MEDIUM="";

if [ $2 -a $1 == "create" ]; then

    # getops is a builtin shell command and handels 
    # options also known as flags. In this case it looks 
    # if -m AND/OR -s flagsare passed by the user. 
    # $OPTARG contains value of the flag
    while getopts ":s" opt; do
        case $opt in 
            m) 
                vboxmanage modifyvm $2 --memory 2048 >&2
                ;;
            p) 
                $MEDIUM=$OPTARG >&2
                ;;
            s) 
                $STORAGENAME=$OPTARG >&2
                ;;
            \?) echo "Wrong options\n Usage: -m MEMORYSIZE -s STORAGENAME" 
                exit 1
                ;;
        esac
    done

    # creates a vbox 
    vboxmanage createvm --name $2 --register

    # modifies storage device and sets the port(between 0 -2 ) and the device( must be 0, probably because only 1 storage exists)
    vboxmanage storagectl $2 --name $STORAGENAME --add IDE
    vboxmanage storageattach $2 --storagectl $STORAGENAME --port 0 --device 0 --type dvddrive --medium "$MEDIUM" 
else 
    echo "USAGE: $0 create YOURBOXNAME [-m MEMORYSIZE] [-s STORAGENAME]";
fi
