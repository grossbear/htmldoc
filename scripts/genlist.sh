#!/bin/bash

echo "gen html doc script"

#global variables
filename='doclist.html'
tabs_count=0;
spaces="    ";
spaces_len=${#spaces};
spaces_str="";

move_forward_carriage () {
    spaces_str="$spaces_str$spaces"
    let "tabs_count=$tabs_count+1"
}

move_backward_carriage () {
    let "tabs_count=$tabs_count-1"
    let "newpos = $tabs_count * $spaces_len"    
    spaces_str=${spaces_str:0:$newpos}
}

write_tag_open () {
    echo "$spaces_str<$1>" >> $filename
    move_forward_carriage 
}

write_tag_close () {
    move_backward_carriage
    echo "$spaces_str</$1>" >> $filename
}

write_text_line () {
    echo "$spaces_str$1" >> $filename
}

#param 1 - style name
#param 2 - font family
#param 3 - font size
#param 4 - font color in hex
write_text_style () {
    styleName=".$1Text"
    fontFamily=$2
    fontSize=$3
    fontColor=$4

    write_text_line "$styleName"
    write_text_line "{"
    move_forward_carriage
    write_text_line "font-family:$fontFamily;"
    write_text_line "font-size:$fontSize;"
    write_text_line "color:#$fontColor;"
    move_backward_carriage
    write_text_line "}"

}

#create html file
filename='doclist.html'
touch $filename

#add html type in file and clean file
echo "<!DOCTYPE html>" > $filename

#start writing data to file
write_tag_open "html"

#html head
write_tag_open "head"

#title
write_tag_open "title"
write_text_line "functions in  C"
write_tag_close "title"

#style
write_tag_open "style"
write_text_style "include" "Calibri" "10" "00FF00"
write_tag_close "style"

write_tag_close "head"
#--head

#html body
write_tag_open "body"
write_tag_close "body"
#--body

write_tag_close "html"
