" Vim syntax file
" Language:    Jupiter Ace Forth
" Maintainer:  Paul Marshall
" Last Change: 
" Filenames:   *.ja4
" URL:	       

" Based on this forth.vim file:
" Language:    FORTH
" Maintainer:  Christian V. J. Brüssow <cvjb@cvjb.de>
" Last Change: So 27 Mai 2012 15:56:28 CEST
" Filenames:   *.fs,*.ft
" URL:	       http://www.cvjb.de/comp/vim/forth.vim

" $Id: forth.vim,v 1.14 2012/05/27 15:57:22 bruessow Exp $

" Many Thanks to...
"
" 2012-05-13:
" Dominique Pellé <dominique dot pelle at gmail dot com> for sending the
" patch to allow spellchecking of strings, comments, ...
" 
" 2012-01-07:
" Thilo Six <T.Six at gmx dot de> send a patch for cpoptions.
" See the discussion at http://thread.gmane.org/gmane.editors.vim.devel/32151
"
" 2009-06-28:
" Josh Grams send a patch to allow the parenthesis comments at the
" beginning of a line. That patch also fixed a typo in one of the
" comments.
"
" 2008-02-09:
" Shawn K. Quinn <sjquinn at speakeasy dot net> send a big patch with
" new words commonly used in Forth programs or defined by GNU Forth.
"
" 2007-07-11:
" Benjamin Krill <ben at codiert dot org> send me a patch
" to highlight space errors.
" You can toggle this feature on through setting the
" flag forth_space_errors in you vimrc. If you have switched it on,
" you can turn off highlighting of trailing spaces in comments by
" setting forth_no_trail_space_error in your vimrc. If you do not want
" the highlighting of a tabulator following a space in comments, you
" can turn this off by setting forth_no_tab_space_error.
"
" 2006-05-25:
" Bill McCarthy <WJMc@...> and Ilya Sher <ilya-vim@...>
" Who found a bug in the ccomment line in 2004!!!
" I'm really very sorry, that it has taken two years to fix that
" in the official version of this file. Shame on me.
" I think my face will be red the next ten years...
"
" 2006-05-21:
" Thomas E. Vaughan <tevaugha at ball dot com> send me a patch
" for the parenthesis comment word, so words with a trailing
" parenthesis will not start the highlighting for such comments.
"
" 2003-05-10:
" Andrew Gaul <andrew at gaul.org> send me a patch for
" forthOperators.
"
" 2003-04-03:
" Ron Aaron <ron at ronware dot org> made updates for an
" improved Win32Forth support.
"
" 2002-04-22:
" Charles Shattuck <charley at forth dot org> helped me to settle up with the
" binary and hex number highlighting.
"
" 2002-04-20:
" Charles Shattuck <charley at forth dot org> send me some code for correctly
" highlighting char and [char] followed by an opening paren. He also added
" some words for operators, conditionals, and definitions; and added the
" highlighting for s" and c".
"
" 2000-03-28:
" John Providenza <john at probo dot com> made improvements for the
" highlighting of strings, and added the code for highlighting hex numbers.
"


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Synchronization method
syn sync ccomment
syn sync maxlines=200

" Jupiter Ace Forth is case insensitive
syn case ignore

" Some special, non-FORTH keywords
syn keyword forthTodo contained TODO FIXME XXX
syn match forthTodo contained 'Copyright\(\s([Cc])\)\=\(\s[0-9]\{2,4}\)\='

" Characters allowed in keywords
" 128-255 are reverse video versions of characters on Jupiter ACE and I 
" don't think they are allowed in dictionary words.
if version >= 600
    setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126
else
    set iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126
endif

" when wanted, highlight trailing white space
if exists("forth_space_errors")
    if !exists("forth_no_trail_space_error")
        syn match forthSpaceError display excludenl "\s\+$"
    endif
    if !exists("forth_no_tab_space_error")
        syn match forthSpaceError display " \+\t"me=e-1
    endif
endif

" Keywords

" basic mathematical and logical operators
syn keyword forthOperators + - * / MOD /MOD NEGATE ABS MIN MAX
syn keyword forthOperators AND OR XOR 1+
syn keyword forthOperators 1- 2+ 2- U* U/MOD
syn keyword forthOperators */ */MOD
syn keyword forthOperators D+ DNEGATE
syn keyword forthOperators F+ F- F* F/ FNEGATE INT UFLOAT
syn keyword forthOperators 0< 0= 0> < = > U<
syn keyword forthOperators D<

" stack manipulations
syn keyword forthStack DROP DUP OVER SWAP ROT ?DUP PICK ROLL
syn keyword forthRStack >R R>

" address operations
syn keyword forthMemory @ ! C@ C!
syn keyword forthAdrArith ALLOT HERE

" conditionals
syn keyword forthCond IF ELSE THEN

" iterations
syn keyword forthLoop BEGIN WHILE REPEAT UNTIL
syn keyword forthLoop LOOP I J DO +LOOP I'
syn keyword forthLoop LEAVE EXIT

" new words
syn match forthColonDef '\<:\s*[^ \t]\+\>'
syn keyword forthEndOfColonDef ;
syn keyword forthDefine CONSTANT VARIABLE
syn keyword forthDefine CREATE DOES> IMMEDIATE DEFINER
syn keyword forthDefine COMPILER RUNS>
syn keyword forthDefine EXECUTE
syn keyword forthDefine LITERAL
syn keyword forthDefine ]
syn keyword forthDefine , C,
syn match forthDefine '\<\[\>'

" basic character operations
syn keyword forthCharOps FIND WORD TYPE EMIT
syn keyword forthCharOps CR ASCII SPACE SPACES QUERY RETYPE INKEY U. F.
syn region forthCharOps start=+."\s+ skip=+\\"+ end=+"+

" char-number conversion
syn keyword forthConversion <# # #> #S CONVERT
syn keyword forthConversion HOLD NUMBER SIGN

" interpreter, wordbook, compiler
syn keyword forthForth ABORT HERE CALL QUIT
syn keyword forthForth PAD FORGET REDEFINE LIST EDIT
syn keyword forthForth )
syn keyword forthForth CLS AT SLOW FAST BEEP IN OUT INVIS VIS LINE PLOT

" vocabularies
syn keyword forthVocs FORTH CONTEXT
syn keyword forthVocs VOCABULARY DEFINITIONS VLIST CURRENT

" File keywords
syn keyword forthFileWords LOAD SAVE VERIFY BLOAD BSAVE BVERIFY

" numbers
syn keyword forthMath DECIMAL BASE
syn match forthInteger '\<-\=[0-9.]*[0-9.]\+\>'
syn match forthInteger '\<&-\=[0-9.]*[0-9.]\+\>'
syn match forthFloat '\<-\=\d*[.]\=\d\+[DdEe]\d\+\>'
syn match forthFloat '\<-\=\d*[.]\=\d\+[DdEe][-+]\d\+\>'

" Strings
syn region forthString start=+\.*\"+ end=+"+ contains=@Spell

" Comments
syn match forthComment '\.(\s[^)]*)' contains=@Spell,forthTodo,forthSpaceError
syn region forthComment start='\(^\|\s\)\zs(\s' skip='\\)' end=')' contains=@Spell,forthTodo,forthSpaceError

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_forth_syn_inits")
    if version < 508
	let did_forth_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif

    " The default methods for highlighting. Can be overridden later.
    HiLink forthTodo Todo
    HiLink forthOperators Operator
    HiLink forthMath Number
    HiLink forthInteger Number
    HiLink forthFloat Float
    HiLink forthStack Special
    HiLink forthRstack Special
    HiLink forthFStack Special
    HiLink forthMemory Function
    HiLink forthAdrArith Function
    HiLink forthCond Conditional
    HiLink forthLoop Repeat
    HiLink forthColonDef Define
    HiLink forthEndOfColonDef Define
    HiLink forthDefine Define
    HiLink forthAssembler Include
    HiLink forthCharOps Character
    HiLink forthConversion String
    HiLink forthForth Statement
    HiLink forthVocs Statement
    HiLink forthString String
    HiLink forthComment Comment
    HiLink forthDeprecated Error " if you must, change to Type
    HiLink forthFileWords Statement
    HiLink forthSpaceError Error

    delcommand HiLink
endif

let b:current_syntax = "jaforth"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim:ts=8:sw=4:nocindent:smartindent:
