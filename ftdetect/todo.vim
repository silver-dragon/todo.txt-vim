" File:        todo.txt.vim
" Description: Todo.txt filetype detection
" Author:      David Beniamine <david@beniamine.net>, Leandro Freitas <freitass@gmail.com>
" License:     Vim license
" Website:     http://github.com/dbeniamine/todo.txt-vim
" vim: ts=4 sw=4 :help tw=78 cc=80

autocmd BufNewFile,BufRead [Tt]odo.txt set filetype=todo
autocmd BufNewFile,BufRead [Tt]odo-\d\\\{4\}-\d\\\{2\}-\d\\\{2\}.txt set filetype=todo
autocmd BufNewFile,BufRead [Tt]odo-\d\\\{4\}-\d\\\{2\}.txt set filetype=todo
autocmd BufNewFile,BufRead \d\\\{4\}-\d\\\{2\}-\d\\\{2\}-[Tt]odo.txt set filetype=todo
autocmd BufNewFile,BufRead \d\\\{4\}-\d\\\{2\}-[Tt]odo.txt set filetype=todo
autocmd BufNewFile,BufRead [Tt]oday.txt set filetype=todo
autocmd BufNewFile,BufRead [Dd]one.txt set filetype=todo
autocmd BufNewFile,BufRead [Dd]one-\d\\\{4\}-\d\\\{2\}-\d\\\{2\}.txt set filetype=todo
autocmd BufNewFile,BufRead [Dd]one-\d\\\{4\}-\d\\\{2\}.txt set filetype=todo
autocmd BufNewFile,BufRead \d\\\{4\}-\d\\\{2\}-\d\\\{2\}-[Dd]one.txt set filetype=todo
autocmd BufNewFile,BufRead \d\\\{4\}-\d\\\{2\}-[Dd]one.txt set filetype=todo
autocmd BufNewFile,BufRead [Dd]one-[Tt]oday.txt set filetype=todo
