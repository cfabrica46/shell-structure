#!/bin/bash

while getopts ":d: f g j" opt; do
    case $opt in
    d)
        path=$OPTARG
        ;;
    g)
        type="go"
        ;;
    j)
        type="js"
        ;;
    \?)
        echo "Invalid option: -$OPTARG" >&2
        exit 1
        ;;
    esac
done

if [ -z "$path" ]; then
    path=$(pwd)
fi

if [ ! -e "$path" ]; then
    echo "Directory doesn't exist"
    exit 2
fi

case $type in
"go")
    cat >"$path"/main.go <<limite
package main

import(
    "fmt"
)

func main(){
    fmt.Println("Hello World")
}
limite

    cat >"$path"/main_test.go <<limite
package main

import(
    "fmt"
    "testing"
)

func TestHelloWorld(t *testing.T){
    fmt.Println("hola")
}
limite
    go mod init 2>/dev/null
    ;;

"js")
    cat >"$path"/index.html <<limite
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <script src="index.js" defer></script>
</head>

<body>

</body>

</html>
limite
    mkdir "$path"/src "$path"/dist
    mkdir "$path"/dist/css "$path"/dist/js "$path"/src/js "$path"/src/sass
    cat >"$path"/src/js/index.js <<limite
    console.log("hello world")
limite
    cat >"$path"/src/sass/style.scss <<limite
    *{
        margin: 0;
    }
limite
    npm init -y -w "$path"
    ;;
*)
    echo "You need to specify what type of proyect you will be doing"
    ;;
esac
