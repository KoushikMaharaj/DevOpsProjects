#!/bin/bash

# display_list_usage shows available options for list argument
function display_list_usage {
    echo "$0 $1 [options]"
    echo "options:"
    echo -e "-u, --user\n\tList all users"
    echo -e "-g, --group\n\tList all groups"
    echo -e "-h, --help\n\tDisplay this help and exit"
}

# list function displays existing users or groups
function list {
    if [ $# -ne 2 ] || [ $2 = "-h" ] || [ $2 = "--help" ]; then
        display_list_usage $@
        exit 0
    fi
    option=$1
    shift
    case $1 in
    -u | --user)
        cat /etc/passwd | awk -F: '{ if($3>999) print "- " $1 " (UID:"$3")" }'
        ;;
    -g | --group)
        cat /etc/group | awk -F: '{ if($3>999) print "- " $1 " (GID:"$3") users:"$4"" }'
        ;;
    *)
        echo -e "$0 $option: invalid arg $1\nTry '$0 $option --help' for more information"
        ;;
    esac
}
