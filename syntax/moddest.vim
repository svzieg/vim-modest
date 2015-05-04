" Vim syntax file
" Language: Moddest
" Maintainer: Sven Ziegler
" Latest Revision: 4 May 2015

if exists("b:current_syntax")
    finish
endif


" Keywords
syn keyword syntaxElementKeyword keyword1 keyword2 nextgroup=syntaxElement2"
" Matches
syn region syntaxElementRegion start='x' end='y'
" Regionso
syn match syntaxElementMatch 'regexp' contains=syntaxElement1 nextgroup=syntaxElement2 skipwhite" 



