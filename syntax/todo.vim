" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      David Beniamine <David@Beniamine.net>,Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim
" vim: ts=4 sw=4 :help tw=78 cc=80

if exists("b:current_syntax")
    finish
endif

syntax  match  TodoDone       '^[xX]\s.\+$'               contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityA  '^([aA])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityB  '^([bB])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityC  '^([cC])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityD  '^([dD])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityE  '^([eE])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityF  '^([fF])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityG  '^([gG])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityH  '^([hH])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityI  '^([iI])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityJ  '^([jJ])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityK  '^([kK])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityL  '^([lL])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityM  '^([mM])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityN  '^([nN])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityO  '^([oO])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityP  '^([pP])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityQ  '^([qQ])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityR  '^([rR])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityS  '^([sS])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityT  '^([tT])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityU  '^([uU])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityV  '^([vV])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityW  '^([wW])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityX  '^([xX])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityY  '^([yY])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoPriorityZ  '^([zZ])\s.\+$'             contains=TodoKey,TodoDate,TodoProject,TodoContext,OverDueDate
syntax  match  TodoDate       '\d\{2,4\}-\d\{2\}-\d\{2\}' contains=NONE
syntax  match  TodoKey        '\S*\S:\S\S*'                   contains=TodoDate
syntax  match  TodoProject    '\(^\|\W\)+[^[:blank:]]\+'  contains=NONE
syntax  match  TodoContext    '\(^\|\W\)@[^[:blank:]]\+'  contains=NONE

" Other priority colours might be defined by the user
highlight  default  link  TodoKey        Special
highlight  default  link  TodoDone       Comment
highlight  default  link  TodoPriorityA  Identifier
highlight  default  link  TodoPriorityB  statement
highlight  default  link  TodoPriorityC  type
highlight  default  link  TodoDate       PreProc
highlight  default  link  TodoProject    Special
highlight  default  link  TodoContext    Special

let b:curdir = expand('<sfile>:p:h')
let s:script_dir = b:curdir . "/python/"
if has('python')
    execute "pyfile " . s:script_dir. "todo.py"
elseif has('python3')
    execute "py3file " . s:script_dir. "todo.py"
endif

let b:current_syntax = "todo"
