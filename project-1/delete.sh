#!/bin/bash

# display_delete_usage shows available options for delete argument
function display_delete_usage {
    echo "$0 $1 [options]"
    echo "options:"
    echo -e "-u, --user\n\tDelete User"
    echo -e "-g, --group\n\tDelete Group"
    echo -e "-h, --help\n\tDisplay this help and exit"
}

# delete_user function deletes existing user
function delete_user {
    read -p "Username: " userName
    if [ -z $userName ]; then # check enter username is blank or not
        echo "Please enter valid username"
        return 1
    elif ! id $userName &>/dev/null; then # check user is exist or not
        echo "The user $userName does not exist."
        return 1
    else
        if sudo userdel -r "$userName"; then # user deletion
            echo "User $userName is deleted."
        else
            echo "Failed to delete user $userName"
            return 1
        fi
    fi
}

# delete_group function deletes existing user
function delete_group {
    read -p "Group name: " grpName
    if [ -z $grpName ]; then # check enter username is blank or not
        echo "Please enter valid group name"
        return 1
    elif ! grep -q -E "^$grpName:" /etc/group; then # check group exists or not
        echo "The group $grpName does exist."
        return 1
    else
        if sudo groupdel "$grpName"; then # user deletion
            echo "Group $grpName is deleted."
        else
            echo "Failed to delete user $grpName"
            return 1
        fi
    fi
}

# delete function decides user deletion or group deletion
function delete {
    if [ $# -ne 2 ] || [ $2 = "-h" ] || [ $2 = "--help" ]; then
        display_delete_usage $1
        return 1
    fi
    option=$1
    shift
    case $1 in
    -u | --user)
        delete_user
        ;;
    -g | --group)
        delete_group
        ;;
    *)
        echo -e "$0 $option: invalid arg $1\nTry '$0 $option --help' for more information"
        ;;
    esac
}
