#!/bin/bash

while getopts ":d: g" opt; do
    case $opt in
    d)
        path=$OPTARG/
        ;;
    g)
        go="1"
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
done

if [ -z "$path" ]; then
    echo "no"
    path=$(pwd)
fi

if [ ! -e "$path" ]; then
    echo "Directory doesn't exist"
    exit 2
fi

if [ ! -z $go ]; then
    cat >./test/main.go <<limite
package main

import(
    "fmt"
)

func main(){
    fmt.Println("Hello World")
}
limite
fi
