#!/bin/bash

# imports
source create.sh
source list.sh
source delete.sh

# display_usage shows available options
function display_usage {
    echo "$0 [options]"
    echo "OPTIONS:"
    echo -e "-c, --create\n\tCreate new user or group."
    echo -e "-d, --delete\n\tDelete new user or group."
    echo -e "-l, --list\n\tList all users or groups."
    echo -e "-r, --reset\n\tReset password for existing user."
    echo -e "-aG \n\tAdd user to group"
    echo -e "-h, --help\n\tDisplay this help and exit."
}

if [ $# -eq 0 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
    display_usage
    exit 0
fi

# reset_password function restes/sets existing user's password
function reset_password {
    read -p "Enter username to reset password: " userName
    if [ -z $userName ]; then # check enter username is blank or not
        echo "Please enter valid username"
        return 1
    elif id $userName &>/dev/null; then # check user is already exist or not
        sudo passwd $userName
    else
        echo "User $userName does not exist."
        return 1
    fi

}

# add_user_to_group 
function add_user_to_group {
    read -p "Username: " username
    read -p "Group Name: " grpName

    if [ -z $username ] || [ -z $grpName ]; then # check group and user name are not empty
        echo "Please enter valid user or group name."
        return 1
    elif sudo usermod -aG $grpName $username; then # add user to group
        echo "User $username is added to group $grpName"
    else
        echo "Fail to add user in group."
    fi
}

# command line args
while (($# > 0)); do
    case $1 in
    -c | --create)
        create "$@"
        shift
        ;;
    -l | --list)
        list "$@"
        shift
        ;;
    -r | --reset)
        reset_password
        ;;
    -d | --delete)
        delete "$@"
        shift
        ;;
    -aG)
        add_user_to_group
        ;;
    *)
        echo -e "$0: invalid arg $1\nTry '$0 --help' for more information"
        exit 1
        ;;
    esac
    shift
done