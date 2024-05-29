#!/bin/bash

#loading common libraries
source $(dirname "$0")/include/common_htmldoc.sh

#setting tabs and creating html doc file
set_tab_size 4
create_html_file "doc.html"

#html tag
write_tag_open "html"

#html head section
write_tag_open "head"

#title
write_tag_open "title"
write_text_line "functions in  C"
write_tag_close "title"

#style
write_tag_open "style"
load_write_styles "data/styles.desc"
write_paragraph_margin 2
write_tag_close "style"

write_tag_close "head"

#html body section
write_tag_open "body"

write_tag_close "body"

write_tag_close "html"
