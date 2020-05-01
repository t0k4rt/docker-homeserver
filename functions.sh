#!/bin/bash

ask_value() {
    # $1 is subject
    # $2 is current value
    if [ -n "$2" ]; then
        echo "$2"
        return 0
    fi
    while true; do
        read -p "$1: " VAR
        if [ -z "$VAR" ]; then
            >&2 echo "$1 cannot be empty, try again"
        else
            break
        fi
    done
    echo "$VAR"
    return 0
}

ask_value_with_default() {
    # $1 is subject
    # $2 is default value
    # $3 is current value
    if [ -n "$3" ]; then
        echo "$3"
        return 0
    fi
    while true; do
        read -p "$1: " INPUT
        if [ -z "$VAR" ]; then
            VAR="$2"
            break
        else
            VAR="$INPUT"
            break
        fi
    done
    echo "$VAR"
    return 0
}
