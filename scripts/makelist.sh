#!/bin/bash

#make proc script
echo "functions list building script"

fileName="primary.desc"
itemStr='item'

declare -A paramsArray
paramsArray+=(["name"]="mftoi")

echo ${paramsArray["name"]}

while IFS=: read -r param value
do
    if [[ "$param" == *"$itemStr"* ]]; then
        echo "match"
        echo ${paramsArray[@]}
        paramsArray=()
    else
        #echo "param: $param"
        paramsArray+=([$param]=$value)
    fi
done < "$fileName"

#echo ${paramsArray["return"]}


