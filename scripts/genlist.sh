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
    echo "$space_str$1" >> $filename
}

write_text_style () {
    echo "hello"
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
echo "functions list" >> $filename
write_tag_close "title"

#style
write_tag_open "style"
write_tag_close "style"

write_tag_close "head"
#--head

#html body
write_tag_open "body"
write_tag_close "body"
#--body

write_tag_close "html"
