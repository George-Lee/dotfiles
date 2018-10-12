" based off of https://dougblack.io/words/a-good-vimrc.html
" Colours {{{
colorscheme badwolf     " colorscheme
syntax enable           " enable syntax processing
" }}}
" Misc {{{
set ttyfast
set backspace=indent,eol,start
" enable :Q as :q
:command Q q
" enable :W as :w
:command W w
" enable :WQ as :wq
:command WQ wq
" set gb to return to previous file (:e#)
nnoremap gb :e# <CR>
" }}}
" Spaces and Tabs {{{
set modeline
set tabstop=2           " visual spaces per TAB
set softtabstop=2       " number of spaces in tab when editing
set shiftwidth=2        " number of spaces indented with >> and <<
set expandtab           " tabs are spaces
filetype indent on
filetype plugin on
set autoindent
" }}}
" UI Layout {{{
set relativenumber              " show line numbers
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to
set showmatch           " highlight matching [{()}]
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
" seach automatically uses 'very magic' (extended regex)
nnoremap / /\v
vnoremap / /\v
nnoremap ? *
vnoremap ? *
" }}}
" Folding {{{
set foldenable          " enable folding
set foldlevelstart=10   " enable most folds by default
set foldnestmax=10      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
set foldmethod=indent   " fold based on indent level
" }}}
" Line Shortcuts {{{
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" move to beginning/end of line
nnoremap B ^
nnoremap E $
" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
" highight last insterted text
nnoremap gV `[v`]
" }}}
" Leader Shortcuts {{{
let mapleader=","       " leader is comma
" jk is escape
inoremap jk <esc>
" toggle gundo
nnoremap <leader>u :GundoToggle<CR>
" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
" save session
nnoremap <leader>s :mksession<CR>
" Move splits
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
" Swap between relative/absolute line numbers
nnoremap <leader>tn :call ToggleNumber()<CR>
" Open file under cursor as vertical split
"nnoremap <silent> <leader>f :call writefile([], expand("<cfile>"), "t")<cr> <C-w>f <C-w>H
nnoremap <leader>f <C-w>f <C-w>H
" Open file under cursor as horizontal split
"nnoremap <leader>F :sp expand("<cfile>")<cr>
nnoremap <leader>F <C-w>f
" }}}
"AutoGroups {{{
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.yml setlocal tabstop=2
    autocmd BufEnter *.yml setlocal shiftwidth=2
    autocmd BufEnter *.yml setlocal softtabstop=2
augroup END
" }}}
" Backups {{{
" move backup folder elsewhere
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}
" Functions {{{
" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

function SplitFile()
    call writefile([], expand("<cfile>"), "t")<cr>
    <C-w>f
    <C-w>H
endfunction
" }}}

" vim: foldmethod=marker:foldlevel=0
