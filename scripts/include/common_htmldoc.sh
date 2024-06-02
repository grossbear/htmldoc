#!/bin/bash

#common global variables
html_filename=""

#tab spaces data
let tab_size=0
tab_spaces=""
spaces_str=""


#common functions

#setting tab size with spaces
set_tab_size () {
    tab_size=$1
    if [[ "$tab_size" -gt "16" ]]; then
        tab_size=16;
    fi
    if [[ "$tab_size" -lt "0" ]];
    then
        tab_size=2;
    fi

    for (( c = 0; c < tab_size; c++ ))
    do
        tab_spaces="$tab_spaces "
    done
    echo "${#tab_spaces}"
}


create_html_file () {
    html_filename=$1

    touch $html_filename
    echo "<!DOCTYPE html>" > $html_filename
}

move_forward_carriage () {
    spaces_str="$spaces_str$tab_spaces"
}

move_backward_carriage () {
    let "size = ${#spaces_str}"
    let "new_pos = $size - $tab_size"
    spaces_str=${spaces_str:0:$new_pos}
}

write_tag_open () {
    echo "$spaces_str<$1>" >> $html_filename
    move_forward_carriage
}

write_tag_close () {
    move_backward_carriage
    echo "$spaces_str</$1>" >> $html_filename
}

write_text_line () {
    echo "$spaces_str$1" >> $html_filename
}

#param 1 - style name
#param 2 - font family
#param 3 - font size
#param 4 - font color in hex
write_text_style () {
    style_name=".$1Text"
    font_family=$2
    font_size=$3
    font_color=$4

    write_text_line "$style_name"
    write_text_line "{"
    move_forward_carriage
    write_text_line "font-family:$font_family;"
    write_text_line "font-size:$font_size;"
    write_text_line "color:#$font_color;"
    move_backward_carriage
    write_text_line "}"
}

#load styles from desc file and write into html doc
#param 1 - styles descriprion filename
load_write_styles () {
    styles_filename=$1

    while IFS=: read -r style_name font_name font_size font_color
    do
        write_text_style $style_name $font_name $font_size $font_color

    done < "$styles_filename"
}

write_paragraph_margin () {
    write_text_line "p"
    write_text_line "{"
    move_forward_carriage
    write_text_line "margin $1px;"
    move_backward_carriage
    write_text_line "}"
}

#param 1 - text data
#param 2 - style name
write_style_text () {
    echo "<span class=\"$2Text\">$1</span>" >> html_filename
}

#pars array and write function declaration in html doc
#param 1 - array of parameters
write_fun_decl () {
    params_array=$1

    code_style="code"
    keywd_style="keyword"
    
    write_tag_open "p"

    if [[ -v "params_array[name]" ]]; then
        echo "name exists"
        text=params_array[name]
        write_style_text text code_style
    fi

    if [[ -v "params_array[return]" ]]; then
        echo "return exists"
        text=params_array[return]
        write_text_style text keywd_style
    fi

    write_tag_close "p"
}

load_write_fun_decl () {
    desc_filename=$1
    item_str="item"

    declare -A params_array
    echo "$desc_filename"

    size=${#params_array}
    echo "$size"

    while IFS=: read -r param value
    do
        if [[ "$param" == *"$item_str"* ]]; then
            echo "match"
        else
            echo "param: $param, value: $value"
        fi
    done < "$desc_filename"

        
    write_fun_decl params_array

}


#fileName="primary.desc"
#itemStr='item'

#declare -A paramsArray
#paramsArray+=(["name"]="mftoi")

#echo ${paramsArray["name"]}

#while IFS=: read -r param value
#do
#    if [[ "$param" == *"$itemStr"* ]]; then
#        echo "match"
#        echo ${paramsArray[@]}
#        paramsArray=()
#    else
#        #echo "param: $param"
#        paramsArray+=([$param]=$value)
#    fi
#done < "$fileName"
