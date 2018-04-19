" File:        todo.txt.vim
" Description: Todo.txt filetype detection
" Author:      David Beniamine <David@Beniamine.net>, Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim

if exists("g:Todo_txt_loaded")
    finish
else
    let g:Todo_txt_loaded=0.8.1
endif

" Save context {{{1
let s:save_cpo = &cpo
set cpo&vim

" General options {{{1
" Some options lose their values when window changes. They will be set every
" time this script is invoked, which is whenever a file of this type is
" created or edited.
setlocal textwidth=0
setlocal wrapmargin=0

" Increment and decrement the priority use <C-A> and <C-X> on alpha
setlocal nrformats+=alpha

" Mappings {{{1

nnoremap <silent> <buffer> <Plug>TodotxtIncrementDueDateNormal :<C-u>call <SID>ChangeDueDateWrapper(1, "\<Plug>TodotxtIncrementDueDateNormal")<CR>
vnoremap <silent> <buffer> <Plug>TodotxtIncrementDueDateVisual :call <SID>ChangeDueDateWrapper(1, "\<Plug>TodotxtIncrementDueDateVisual")<CR>
nnoremap <silent> <buffer> <Plug>TodotxtDecrementDueDateNormal :<C-u>call <SID>ChangeDueDateWrapper(-1, "\<Plug>TodotxtDecrementDueDateNormal")<CR>
vnoremap <silent> <buffer> <Plug>TodotxtDecrementDueDateVisual :call <SID>ChangeDueDateWrapper(-1, "\<Plug>TodotxtDecrementDueDateVisual")<CR>

if !exists("g:Todo_txt_do_not_map") || ! g:Todo_txt_do_not_map
" Sort todo by (first) context
    noremap <silent><localleader>sc :call todo#HierarchicalSort('@', '', 1)<CR>

    noremap <silent><localleader>scp :call todo#HierarchicalSort('@', '+', 1)<CR>
" Sort todo by (first) project
    noremap <silent><localleader>sp :call todo#HierarchicalSort('+', '',1)<CR>
    noremap <silent><localleader>spc :call todo#HierarchicalSort('+', '@',1)<CR>

" Sort tasks {{{2
    nnoremap <script> <silent> <buffer> <LocalLeader>s :call todo#Sort()<CR>
    nnoremap <script> <silent> <buffer> <LocalLeader>s@ :sort /.\{-}\ze@/ <CR>
    nnoremap <script> <silent> <buffer> <LocalLeader>s+ :sort /.\{-}\ze+/ <CR>
" Priorities {{{2
    noremap <script> <silent> <buffer> <LocalLeader>j :call todo#PrioritizeIncrease()<CR>
    noremap <script> <silent> <buffer> <LocalLeader>k :call todo#PrioritizeDecrease()<CR>

    noremap <script> <silent> <buffer> <LocalLeader>a :call todo#PrioritizeAdd('A')<CR>
    noremap <script> <silent> <buffer> <LocalLeader>b :call todo#PrioritizeAdd('B')<CR>
    noremap <script> <silent> <buffer> <LocalLeader>c :call todo#PrioritizeAdd('C')<CR>

" Insert date {{{2
    inoremap <script> <silent> <buffer> date<Tab> <C-R>=strftime("%Y-%m-%d")<CR>

    inoremap <script> <silent> <buffer> due: due:<C-R>=strftime("%Y-%m-%d")<CR>
    inoremap <script> <silent> <buffer> DUE: DUE:<C-R>=strftime("%Y-%m-%d")<CR>

    noremap <script> <silent> <buffer> <localleader>d :call todo#PrependDate()<CR>

" Mark done {{{2
    noremap <script> <silent> <buffer> <Plug>DoToggleMarkAsDone :call todo#ToggleMarkAsDone('')<CR>
                \:silent! call repeat#set("\<Plug>DoToggleMarkAsDone")<CR>
    nmap <localleader>x <Plug>DoToggleMarkAsDone
    " noremap <script> <silent> <buffer> <localleader>x :call todo#ToggleMarkAsDone('')<CR>

" Mark done {{{2
    noremap <script> <silent> <buffer> <Plug>DoCancel :call todo#ToggleMarkAsDone('Cancelled')<CR>
                \:silent! call repeat#set("\<Plug>DoCancel")<CR>
    nmap <localleader>C <Plug>DoCancel

" Mark all done {{{2
    noremap <script> <silent> <buffer> <localleader>X :call todo#MarkAllAsDone()<CR>

" Remove completed {{{2
    nnoremap <script> <silent> <buffer> <localleader>D :call todo#RemoveCompleted()<CR>

" Sort by due: date {{{2
    nnoremap <script> <silent> <buffer> <localleader>sd :call todo#SortDue()<CR>
" try fix format {{{2
    nnoremap <script> <silent> <buffer> <localleader>ff :call todo#FixFormat()<CR>

" increment and decrement due:date {{{2
    nmap <localleader>p <Plug>TodotxtIncrementDueDateNormal
    vmap <localleader>p <Plug>TodotxtIncrementDueDateVisual
    nmap <localleader>P <Plug>TodotxtDecrementDueDateNormal
    vmap <localleader>P <Plug>TodotxtDecrementDueDateVisual

" Prefix creation date when opening a new line {{{2
    if exists("g:Todo_txt_prefix_creation_date")
        nnoremap <script> <silent> <buffer> o o<C-R>=strftime("%Y-%m-%d")<CR> 
        nnoremap <script> <silent> <buffer> O O<C-R>=strftime("%Y-%m-%d")<CR> 
        inoremap <script> <silent> <buffer> <CR> <CR><C-R>=strftime("%Y-%m-%d")<CR> 
    endif
endif

" Functions for maps {{{1
function! s:ChangeDueDateWrapper(by_days, repeat_mapping)
    call todo#CreateNewRecurrence(0)
    call todo#ChangeDueDate(a:by_days, 'd', '')
    silent! call repeat#set(a:repeat_mapping, v:count)
endfunction

" Folding {{{1
" Options {{{2
setlocal foldmethod=expr
setlocal foldexpr=TodoFoldLevel(v:lnum)
setlocal foldtext=TodoFoldText()

" Go to first completed task
let oldpos=getcurpos()
let g:Todo_fold_char='@'
let base_pos=search('^x\s', 'ce')
" Get next completed task
let first_incomplete = search('^\s*[^<x\s>]')
if (first_incomplete < base_pos)
    " Check if all tasks from
    let g:Todo_fold_char='x'
else
    " TODO detect if sorted on prjects
    let g:Todo_fold_char='@'
endif
call setpos('.', oldpos)

function! s:get_contextproject(line) abort "{{{2
    return matchstr(getline(a:line), g:Todo_fold_char.'[^ ]\+')
endfunction "}}}3

" TodoFoldLevel(lnum) {{{2
function! TodoFoldLevel(lnum)
    let this_context = s:get_contextproject(a:lnum)
    let next_context = s:get_contextproject(a:lnum - 1)

    if g:Todo_fold_char == 'x'
        " fold on cmpleted task
        return  match(getline(a:lnum),'\C^x\s') + 1
    endif

    let fold_level = 0

    if this_context ==# next_context
        let fold_level = '1'
    else
        let fold_level = '>1'
    endif

    return fold_level
endfunction

" TodoFoldText() {{{2
function! TodoFoldText()
    let this_context = s:get_contextproject(v:foldstart)
    if g:Todo_fold_char == 'x'
        let this_context = 'Completed tasks'
    endif
    " The text displayed at the fold is formatted as '+- N Completed tasks'
    " where N is the number of lines folded.
    return '+' . v:folddashes . ' '
                \ . (v:foldend - v:foldstart + 1)
                \ .' '. this_context
endfunction

" Restore context {{{1
let &cpo = s:save_cpo

" vim: tabstop=4 shiftwidth=4 softtabstop=4 expandtab foldmethod=marker
