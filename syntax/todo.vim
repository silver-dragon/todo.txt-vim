" File:        todo.txt.vim
" Description: Todo.txt syntax settings
" Author:      David Beniamine <David@Beniamine.net>,Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim
" vim: ts=4 sw=4 :help tw=78 cc=80

if exists("b:current_syntax")
    finish
endif

syntax  match  TodoDone       '^[xX]\s.\+$'               contains=TodoKey,TodoDate,TodoProject,TodoContext
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

function! todo#GetDateRegexForPastDates(...)
    " Build a RegExp to match all dates prior to a reference date.
    "
    " Optionally accepts a (year, month, day) for the date, otherwise assumes the
    " reference date is the current date.
    "
    " In the end, the RegExp will look something like:
    "   =todo#GetDateRegexForPastDates(2017, 09, 15)
    "   \v(([01]\d{3}|200\d|201[0-6])\-\d{2}\-\d{2}|(2017\-(0[0-8])\-\d{2})|(2017\-09\-0\d)|(2017\-09\-1[0-4]))
    "
    " We split the RegExp into a few alternation groups:
    "   1. All dates prior to 2000, dates before this are not supported
    "   2. All previous decades for the reference date century
    "   3. The current decade up to the year prior to the reference year
    "   4. All months for the reference year up to the end of the previous month
    "   5. Days of the month part 1.
    "   6. Days of the month part 2.
    "
    " Will not work on reference dates past 2099, or before 2000.
    "
    " Invalid months and days are not checked, i.e. 2015-14-67 will match.
    "
    " Years must be 4 digits.
    "

    " Get the reference date
    let l:day=strftime("%d")
    let l:month=strftime("%m")
    let l:year=strftime("%Y")
    if a:0 >= 1
        let l:year=a:1
    endif
    if a:0 >= 2
        let l:month=a:2
    endif
    if a:0 >= 3
        let l:day=a:3
    endif

    " Use very magic mode, and start an alternation
    let l:overdueRex = '\v('

    " PART 1: 0000-1999
    " This sucker is static and won't change to year 3000. I'm not coding for the year 3000.
    let l:overdueRex = l:overdueRex . '([01]\d{3}'

    " PART 2. All previous decades for the reference date century
    " i.e. for 2017: "200\d", for 2035: "20[0-2]\d"
    "       for 2000: skip
    let l:decade = strpart(l:year, 2, 1)    " i.e. the 1 from 2017
    if l:decade > 0
        let l:overdueRex = l:overdueRex . '|20'
        if l:decade > 1
            let l:overdueRex = l:overdueRex . '[0-' . (l:decade - 1) . ']'
        else
            let l:overdueRex = l:overdueRex . '0'
        endif
        let l:overdueRex = l:overdueRex . '\d'
    endif

    " PART 3: This decade, to previous year
    " i.e. for 2017: "201[0-6]", for 2035: "203[0-4]", for 2000: skip
    let l:y = strpart(l:year, 3, 1) " Last digit of the year, i.e. 7 for 2017
    if l:y > 0
        if l:y > 1
            let l:overdueRex = l:overdueRex . '|20' . l:decade . '[0-' . (l:y - 1) . ']'
        else
            let l:overdueRex = l:overdueRex . '|20' . l:decade . '0'
        endif
    endif
    let l:overdueRex = l:overdueRex . ')\-\d{2}\-\d{2}|'

    " PART 4: All months to the end of the previous month
    " i.e. for a date of 2017-09-07, "2017-(0[1-8])-\d{2}"
    "       for 2017-11-30: "2017-(0\d|1[0-1])-\d{2}"
    "       for 2017-01-20: skip
    " This only applies if the reference date is not in January
    if l:month > 1
        let l:overdueRex = l:overdueRex . '(' . l:year . '\-(0'
        if l:month > 10
            let l:overdueRex = l:overdueRex . '\d|1'
        endif
        let l:y = strpart(printf('%02d', l:month), 1, 1) " Second digit of the month
        let l:overdueRex = l:overdueRex . '[0-' . (l:y - 1) . '])\-\d{2})|'
    endif

    " PART 5. Days of the month part 1.
    " i.e.  for 2017-09-07: skip
    "       for 2017-12-29: "2017-12-[0-1]\d"
    let l:y = strpart(printf('%02d', l:day), 0, 1) " First digit of the day
    if l:y > 0
        if l:y > 1
            let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-[0-' . (l:y - 1) . ']\d)|'
        else
            let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-0\d)|'
        endif
    endif

    " PART 6. Days of the month part 2.
    " i.e.  for 2017-09-07: "2017-09-0[0-6]"
    "       for 2017-12-29: "2017-12-2[0-8]"
    let l:y = strpart(printf('%02d', l:day), 0, 1) " First digit of the day
    let l:overdueRex = l:overdueRex . '(' . l:year . '\-' . printf('%02d', l:month) . '\-' . l:y
    let l:y = strpart(printf('%02d', l:day), 1, 1) " Last digit of the day
    if l:y > 0
        let l:overdueRex = l:overdueRex . '[0-' . (l:y - 1) . ']'
    else
        let l:overdueRex = l:overdueRex . '0'
    endif
    let l:overdueRex = l:overdueRex . ')'

    let l:overdueRex = l:overdueRex . ')'

    return l:overdueRex
endfunction

let b:curdir = expand('<sfile>:p:h')
let s:script_dir = b:curdir . "/python/"
if has('python3')
    execute "py3file " . s:script_dir. "todo.py"
elseif has('python')
    execute "pyfile " . s:script_dir. "todo.py"
else
    execute 'syntax match TodoOverDueDate /\v\c<due:' . todo#GetDateRegexForPastDates() . '>/'
    highlight default link TodoOverDueDate Error
endif

let b:current_syntax = "todo"
