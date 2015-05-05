" vim syntax File " Language: modest
" Maintainer: Sven Ziegler <svzieg@gmx.de>
" URL: 
" Last Change: 2015-05-05


" Quit when a syntax file was already loaded
if !exists("main_syntax")
    if version < 600
        syntax clear
    elseif exists("b:current_syntax")
        finish
    endif 

    "we define it here so that included files can test for it
    let main_syntax='modest'
    syn region modestFold start="{" end="}" transparent fold
endif 
"
" don't use standard HiLink, it will not work with included syntax files
if version < 508
  command! -nargs=+ ModestHiLink hi link <args>
else
  command! -nargs=+ ModestHiLink hi def link <args>
endif


" keyword definitions
" syn keyword modestExternals         import 
syn keyword modestConditional       if else alt when
syn keyword modestLabel             default
syn keyword modestBoolean           true false
syn keyword modestConstant          tau
syn keyword modestLoop              do
syn keyword modestType              bool int action clock float property process
syn keyword modestBranch            break abort  
syn keyword modestExpression        relabel by extend const
syn keyword modestPrimitiveStmt     stop par palt

syn region modestLabelRegion        transparent matchgroup=modestLabel start="\<case\>" matchgroup=NONE end=":" contains=modestNumber

syn cluster modestTop add=modestConditional,modestLabel,modestBranch,modestBoolean,modestType,modestLoop,modestExpression,modestPrimitiveStmt,modestAgent,modestChannel,modestLabelRegion

"Comments
syn keyword modestTodo		 contained TODO FIXME XXX
if exists("modest_comment_strings")
  syn region  modestCommentString    contained start=+"+ end=+"+ end=+$+ end=+\*/+me=s-1,he=s-1 contains=modestSpecial,modestCommentStar,modestSpecialChar,@Spell
  syn region  modestComment2String   contained start=+"+	end=+$\|"+  contains=modestSpecial,modestSpecialChar,@Spell
  syn match   modestCommentCharacter contained "'\\[^']\{1,6\}'" contains=modestSpecialChar
  syn match   modestCommentCharacter contained "'\\''" contains=modestSpecialChar
  syn match   modestCommentCharacter contained "'[^\\]'"
  syn cluster modestCommentSpecial add=modestCommentString,modestCommentCharacter,modestNumber
  syn cluster modestCommentSpecial2 add=modestComment2String,modestCommentCharacter,modestNumber
endif
syn region  modestComment		 start="/\*"  end="\*/" contains=@modestCommentSpecial,modestTodo,@Spell
syn match   modestCommentStar	 contained "^\s*\*[^/]"me=e-1
syn match   modestCommentStar	 contained "^\s*\*$"
syn match   modestLineComment	 "//.*" contains=@modestCommentSpecial2,modestTodo,@Spell
ModestHiLink modestCommentString modestString
ModestHiLink modestComment2String modestString
ModestHiLink modestCommentCharacter modestCharacter
syn cluster modestTop add=modestComment,modestLineComment


"Documentation JAVA like
"
if !exists("modest_ignore_modestdoc") && main_syntax != 'jsp'
  syntax case ignore
  syntax spell default

  syn region  modestDocComment	start="/\*\*"  end="\*/" keepend contains=modestCommentTitle,@modestHtml,modestDocTags,modestDocSeeTag,modestTodo,@Spell
  syn region  modestCommentTitle	contained matchgroup=modestDocComment start="/\*\*"   matchgroup=modestCommentTitle keepend end="\.$" end="\.[ \t\r<&]"me=e-1 end="[^{]@"me=s-2,he=s-1 end="\*/"me=s-1,he=s-1 contains=@modestHtml,modestCommentStar,modestTodo,@Spell,modestDocTags,modestDocSeeTag

  syn region modestDocTags	 contained start="{@\(link\|linkplain\|inherit[Dd]oc\|doc[rR]oot\|value\)" end="}"
  syn match  modestDocTags	 contained "@\(param\|exception\|throws\|since\)\s\+\S\+" contains=modestDocParam
  syn match  modestDocParam	 contained "\s\S\+"
  syn match  modestDocTags	 contained "@\(version\|author\|return\|deprecated\|serial\|serialField\|serialData\)\>"
  syn region modestDocSeeTag	 contained matchgroup=modestDocTags start="@see\s\+" matchgroup=NONE end="\_."re=e-1 contains=modestDocSeeTagParam
  syn match  modestDocSeeTagParam  contained @"\_[^"]\+"\|<a\s\+\_.\{-}</a>\|\(\k\|\.\)*\(#\k\+\((\_[^)]\+)\)\=\)\=@ extend
  syntax case match
endif

" match the special comment /**/
syn match   modestComment		 "/\*\*/"


" Strings and constants
syn match   modestSpecialError	 contained "\\."
syn match   modestSpecialCharError contained "[^']"
syn match   modestSpecialChar	 contained "\\\([4-9]\d\|[0-3]\d\d\|[\"\\'ntbrf]\|u\x\{4\}\)"
syn region  modestString		start=+"+ end=+"+ end=+$+ contains=modestSpecialChar,modestSpecialError,@Spell
" next line disabled, it can cause a crash for a long line
"syn match   modestStringError	  +"\([^"\\]\|\\.\)*$+
syn match   modestCharacter	 "'[^']*'" contains=modestSpecialChar,modestSpecialCharError
syn match   modestCharacter	 "'\\''" contains=modestSpecialChar
syn match   modestCharacter	 "'[^\\]'"
syn match   modestNumber		 "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[lL]\=\>"
syn match   modestNumber		 "\(\<\d\+\.\d*\|\.\d\+\)\([eE][-+]\=\d\+\)\=[fFdD]\="
syn match   modestNumber		 "\<\d\+[eE][-+]\=\d\+[fFdD]\=\>"
syn match   modestNumber		 "\<\d\+\([eE][-+]\=\d\+\)\=[fFdD]\>"
syn match   modestNumber        "\d\+..\(\d\+\|[A-Z]\)"

" unicode characters
syn match   modestSpecial "\\u\d\{4\}"

syn cluster modestTop add=modestString,modestCharacter,modestNumber,modestSpecial,modestStringError



" catch errors caused by wrong parenthesis
syn region  modestParenT	transparent matchgroup=modestParen  start="("  end=")" contains=@modestTop,modestParenT1
syn region  modestParenT1 transparent matchgroup=modestParen1 start="(" end=")" contains=@modestTop,modestParenT2 contained
syn region  modestParenT2 transparent matchgroup=modestParen2 start="(" end=")" contains=@modestTop,modestParenT  contained
syn match   modestParenError	 ")"
" catch errors caused by wrong square parenthesis
syn region  modestParenT	transparent matchgroup=modestParen  start="\["  end="\]" contains=@modestTop,modestParenT1
syn region  modestParenT1 transparent matchgroup=modestParen1 start="\[" end="\]" contains=@modestTop,modestParenT2 contained
syn region  modestParenT2 transparent matchgroup=modestParen2 start="\[" end="\]" contains=@modestTop,modestParenT  contained
syn match   modestParenError	 "\]"

ModestHiLink modestParenError	modestError


" The default highlighting.
if version >= 508 || !exists("did_modest_syn_inits")
  if version < 508
    let did_modest_syn_inits = 1
  endif
  ModestHiLink modestBranch			Conditional
  ModestHiLink modestLabel			Label
  ModestHiLink modestConditional		Conditional
  ModestHiLink modestLoop			Repeat
  ModestHiLink modestBoolean		Boolean
  ModestHiLink modestSpecial		Special
  ModestHiLink modestSpecialError		Error
  ModestHiLink modestSpecialCharError	Error
  ModestHiLink modestString			String
  ModestHiLink modestCharacter		Character
  ModestHiLink modestSpecialChar		SpecialChar
  ModestHiLink modestNumber			Number
  ModestHiLink modestError			Error
  ModestHiLink modestStringError		Error
  ModestHiLink modestStatement		Statement
  ModestHiLink modestPrimitiveStmt      Statement
  ModestHiLink modestComment		Comment
  ModestHiLink modestDocComment		Comment
  ModestHiLink modestLineComment		Comment
  ModestHiLink modestConstant		Constant
  ModestHiLink modestTodo			Todo

  ModestHiLink modestCommentTitle		SpecialComment
  ModestHiLink modestDocTags		Special
  ModestHiLink modestDocParam		Function
  ModestHiLink modestDocSeeTagParam		Function
  ModestHiLink modestCommentStar		modestComment

  ModestHiLink modestType			Type
  ModestHiLink modestExternal		Include
  ModestHiLink modestExpression		Function
endif

delcommand ModestHiLink

let b:current_syntax = "modest"

if main_syntax == 'modest'
  unlet main_syntax
endif

let b:spell_options="contained"


" vim: ts=8
