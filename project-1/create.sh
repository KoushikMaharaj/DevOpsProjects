#!/bin/bash

# create_user function creates new user
function create_user {
    read -p "Username: " userName
    if [ -z $userName ]; then # check enter username is blank or not
        echo "Please enter valid username"
        return 1
    elif id $userName &>/dev/null; then # check user is exist or not
        echo "The user $userName is already exist."
        return 1
    else
        if sudo useradd -m "$userName"; then # user creation
            echo "User $userName is created."
            echo -e "To set password use below command.\n$0 -r"
        else
            echo "Failed to create user $userName"
            return 1
        fi
    fi
}

# create_group function creates new group
function create_group {
    read -p "Enter group name: " grpName
    if [ -z $grpName ]; then # check enter group name is blank or not
        echo "Please enter valid group name"
        return 1
    elif grep -q -E "^$grpName:" /etc/group; then # check group exists or not
        echo "The group $grpName is already exist."
        return 1
    else
        if sudo groupadd $grpName; then # group creation
            echo "Group $grpName is created."
        else
            echo "Failed to create group $grpName"
            return 1
        fi
    fi
}

# display_create_usage shows available options for create argument
function display_create_usage {
    echo "$0 $1 [options]"
    echo "options:"
    echo -e "-u, --user\n\tCreate User"
    echo -e "-g, --group\n\tCreate Group"
    echo -e "-h, --help\n\tDisplay this help and exit"
}

# create function decides user creation or group creation
function create {
    if [ $# -ne 2 ] || [ $2 = "-h" ] || [ $2 = "--help" ]; then
        display_create_usage $1
        return 1
    fi
    option=$1
    shift
    case $1 in
    -u | --user)
        create_user
        ;;
    -g | --group)
        create_group
        ;;
    *)
        echo -e "$0 $option: invalid arg $1\nTry '$0 $option --help' for more information"
        ;;
    esac
}
