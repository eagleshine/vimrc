set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" bundles "{{{
Bundle 'gmarik/vundle'

"Colorscheme
Bundle 'gmarik/ingretu'

" original repos on github
Bundle 'tpope/vim-fugitive'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'The-NERD-tree'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'

"  "}}}

filetype plugin indent on
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

"===================================================================
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
set noexpandtab
" set expandtab
set nospell

set modeline
"set spell

" set mapleader
let mapleader = ","

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

"===================================================================

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

"  autocmd BufRead, BufNewFile *.py, *.pyw setlocal sw=4
"  autocmd BufRead, BufNewFile *.py, *.pyw setlocal autoindent shiftwidth=4
"  autocmd BufRead, BufNewFile *.py, *.pyw setlocal expandtab 
"  autocmd BufRead, BufNewFile *.py, *.pyw setlocal smartindent 
"  autocmd BufRead, BufNewFile *.py, *.pyw setlocal cinwords=def,if,elif,else,for,while,try,except,finall 
  autocmd FileType python setlocal ts=8 sts=4 sw=4 tw=72 ai et
  autocmd FileType python setlocal smartindent nosmarttab
  autocmd FileType python setlocal cinwords=def,if,elif,else,for,while,try,except,finall 


  " Use the below highlight group when displaying bad whitespace is desired.
  highlight BadWhitespace ctermbg=red guibg=red
  
  " Display tabs at the beginning of a line in Python mode as bad.
  au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
  " Make trailing whitespace be flagged as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

  " autocmd BufRead, BufNewFile *.py, *.pyw set textwidth=120 
  autocmd BufRead, BufNewFile *.c,*.h,*.cpp,*.hpp set textwidth=120

  autocmd BufRead, BufNewFile Makefile* set noexpandtab  

  autocmd BufNewFile *.py, *.pyw, *.c, *.h set fileformat=unix

  augroup END

endif

"==================================================================
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
"  syntax on
  set hlsearch
  colorscheme evening
endif
set ruler               " show the cursor position all the time
"===================================================================
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                     LaTeX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the default tex flavor;
let g:tex_flavor='tex'
" Run latex, then dvipdf, then refresh the xpdf window.
"let g:Tex_FormatDependency_pdf = 'dvi,pdf'
"let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi; xpdf -remote 127.0.0.1 -reload -raise'
"let g:Tex_CompileRule_pdf = 'dvipdf $*.dvi'
"let g:Tex_CompileRule_pdf='pdflatex -interaction nonstopmode --shell-escape $* ; pgrep -f "xpdf -remote vimlatex" > /dev/null \|\| xpdf -remote vimlatex -reload'
let g:Tex_CompileRule_pdf ='(pdflatex -interaction nonstopmode --shell-escape $*; redraw)' 
"let g:Tex_ViewRule_pdf = 'xpdf -remote 127.0.0.1'
let g:Tex_ViewRule_pdf ='evince $*.pdf >& /dev/null'
let g:Tex_ViewRule_dvi ='evince $*.dvi >& /dev/null'
" Set the target format to pdf.
let g:Tex_DefaultTargetFormat ='pdf'

" Compiling multiple times
let g:Tex_MultipleCompileFormats ='dvi,pdf'

" set the warning messages to ignore.
let g:Tex_IgnoredWarnings =
			\"Underfull\n".
			\"Overfull\n".
			\"specifier changed to\n".
			\"You have requested\n".
			\"Missing number, treated as zero.\n".
			\"There were undefined references\n".
			\"Citation %.%# undefined\n".
			\'LaTeX Font Warning:'"
" This number N says that latex-suite should ignore the first N of the above.
let g:Tex_IgnoreLevel=8

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press Ctrl-N you will automatically cycle through
" all the figure labels. Very useful!

autocmd FileType tex set iskeyword+=:
set iskeyword+=_

" autocmd BufRead *.tex :NERDTree
" autocmd FileType tex :NERDTree<CR>


"===================================================================
" setting for minibufexpl
" let g:miniBufExplMapWindowNavVim = 1	" Configure CTRL-hjkl keys to move between windows
" let g:miniBufExplMapWindowNavArrows = 1 " Configure CTRL-arrow keys to move between windows 

let g:miniBufExplMapCTabSwitchBufs = 1  " Use C-Tab/C-S-Tab to navigate buffers
" let g:miniBufExplForceSyntaxEnable = 1  " Work around vim bug that causes buffers to lose syntax highlighting sometimes

let g:miniBufExplModSelTarget = 1	" Smarten up window selection logic so we don't clobber taglist windows

let g:miniBufExplWinFixHeight = 1
let g:miniBufExplWinMaxSize = 1

if has("autocmd")
    fun! <SID>FixMiniBufExplorerTitle()
        if "-MiniBufExplorer-" == bufname("%")
            setlocal statusline=%2*%-3.3n%0*
            setlocal statusline+=\[Buffers\]
            setlocal statusline+=%=%2*\ %<%P
        endif
    endfun

    au BufWinEnter *
                \ let oldwinnr=winnr() |
                \ windo call <SID>FixMiniBufExplorerTitle() |
                \ exec oldwinnr . " wincmd w"
endif
runtime! plugin/minibufexpl.vim


"===================================================================
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               for .vimrc edit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fast reloading of the .vimrc
map <silent> <leader>ss <ESC><ESC>:source ~/.vimrc<cr>
" Fast editing of .vimrc
map <silent> <leader>ee <ESC><ESC>:e ~/.vimrc<cr>
" When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"              global setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" global map
map <F2> <ESC><ESC>:redraw!<CR>
map <F3> <ESC><ESC>gt<CR>
map <F4> <C-W>W

"---------------------------------------------------
"  NERDTree
"---------------------------------------------------
nmap <silent><leader>nt <ESC><ESC>:NERDTreeToggle<CR>
map <F9> <ESC><ESC>:NERDTreeToggle<CR>


"---------------------------------------------------
"       scroll windows
"---------------------------------------------------
" scroll the window above down 2 lines
map <silent> <leader>ky <ESC><ESC><C-W>k2<C-Y><C-W>j
map <F5> <ESC><ESC><C-W>k2<C-Y><C-W>j
" scroll the window above up 2 lines
map <silent> <leader>ke <ESC><ESC><C-W>k2<C-E><C-W>j
map <F6> <ESC><ESC><C-W>k2<C-E><C-W>j

" scroll the window right down 2 lines
map <silent> <leader>ly <ESC><ESC><C-W>l2<C-Y><C-W>h
map <F7> <ESC><ESC><C-W>l2<C-Y><C-W>h
" scroll the window right up 2 lines
map <silent> <leader>le <ESC><ESC><C-W>l2<C-E><C-W>h
map <F8> <ESC><ESC><C-W>l2<C-E><C-W>h


"---------------------------------------------------
"       buffer operate
"---------------------------------------------------
" edit next buffer
map <silent> <leader>bn <ESC><ESC>:bn<CR>
map <F12> <ESC><ESC>:bn<CR>

" Delete a buffer but keep layout
if has("eval")
    command! Kwbd enew|bw #
    nmap     <C-w>!   :Kwbd<CR>
endif


" normal map
nmap <C-J> <C-W>j
nmap <C-k> <c-W>k


