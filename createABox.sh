###########################################################################################################################################
#!/bin/bash
#
#                                                 Author:  Michael Ajala
#                                                 License: MIT
#
###########################################################################################################################################
STORAGENAME="controller";

if [ $2 -a $1 == "create" ]; then

    # getops is a builtin shell command. It handels options/flags and their values. 
    while getops ":m" opt; do
        case $opt in 
            m) 
                vboxmanage modifyvm $2 --memory 2048 >&2
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

    # modifies storage device
    vboxmanage storagectl $2 --name $STORAGENAME --add sata
    vboxmanage storageattach $2 --storagectl $STORAGENAME --port 0 --device 0 --type hdd --medium emptydrive --comment "this is my first comment"
else 
    echo "USAGE: $0 create YOURBOXNAME [-m MEMORYSIZE] [-s STORAGENAME]";
fi
