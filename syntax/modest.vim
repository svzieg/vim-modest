" Vim syntax file
" Language: Modest
" Maintainer: Sven Ziegler
" Latest Revision: 4 May 2015

if exists("b:current_syntax")
    finish
endif


" Keywords
syn keyword modest_statement stop abort break when urgent alt do par palt throw try catch relabel by extend hide process invariant
syn keyword modest_type int, bool, agent, clock, float 
syn keyword modest_todo contained TODO FIXME XXX NOTE 

" Matches
syn region modest_string start='"' end='"' contained 
syn region modest_comment_block start='/*' end='*/' fold transparent contains modest_number,modest_string,modest_todo
" Regionso
syn match syntaxElementMatch 'regexp' contains=syntaxElement1 nextgroup=syntaxElement2 skipwhite" 
syn match modest_comment "//.*" contains=modest_todo


" Modest integer numbers
syn match modest_number '[-+]\d\+' contained display
syn match modest_number '\d\+' contained display

" Modest decimal no E or c
syn match modest_number '[-+]\d\+\.\d*' contained display
syn match modest_number '\d\+\.\d*' contained display



let b:current_syntax = "modest"
hi def link modest_comment Comment
hi def link modest_todo Todo
hi def link modest_number Constant
hi def link modest_string Constant
hi def link modest_type Type
hi def link modest_statement Statement
