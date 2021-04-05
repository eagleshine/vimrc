
"===================================================================
" General "{{{
set enc=utf-8
set fenc=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set nocompatible	" be iMproved

set history=256		" number of thins to remember in history
set timeoutlen=260	" Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed	" Yanks go on clipboard instead.
set modeline
set modelines=5		" default numbers of lines to read for modeline instructions
set nobackup
set nowritebackup
" set directory=/tmp//	" prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile

"set autowrite		" Automatically save before commands like :next and :make

"set hidden		" The current buffer can be put to the background without writing to disk
"set hidden             " Hide buffers when they are abandoned
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hlsearch		" highlight search

set grepprg=grep\ -nri

let g:is_posix = 1	" vim's default is archaic bourne shell, bring it up to the 90s
let mapleader = ","	" set mapleader

" "}}}

" Formatting "{{{
set fo+=o		" Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r		" Do not automatically insert a comment leader after an enter
set fo-=t		" Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap		" don't wrap the line longer than the screen
set textwidth=0		" Don't wrap lines by default

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#	" do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case

" "}}}

" Visual "{{{
syntax on		" enable syntax

set mouse=a		" Enable mouse usage (all modes) in terminals
set mousehide		" Hide mouse after chars typed

set number		" set line numbers
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
set matchtime=2		" Bracket blinking

set nospell

set wildmode=longest,list   " At command line, complete longest common string, then list alternatives.

set novisualbell	" No blinking
set noerrorbells	" No noise.
set vb t_vb=		" disable any beeps or flashes on error

set laststatus=2	" always show status line.
set shortmess=atI	" shortens messages
set showcmd		" Show (partial) command in status line.

" set statusline=%<%f\	" custom statusline
" set stl+=[%{&ff}]	" show fileformat
" set stl+=%y%m%r
" set stl+=%{fugitive#statusline()}   " for tpope/vim-fugitive
" set stl+=%=
" set stl+=%-14.(%l,%c%V%)\ %P

set foldenable		" Turn on folding
set foldmethod=marker	" Fold on the marker
set foldlevel=100	" Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag  " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set splitbelow
set splitright

set nolist	" display unprintable characters f12 - switches
"set listchars=tab:\ ·,eol:¬
set listchars=tab:▸\ ,eol:¬
set listchars+=extends:»,precedes:«
"highlight NonText ctermfg=8 guifg=gray
"highlight SpecialKey ctermfg=8 guifg=gray
nmap <silent> <leader>lc <ESC><ESC>:set invlist<CR>

if has('gui_running')
    set guioptions=cMg	" console dialogs, do not show menu and toolbar

    " Fonts
    if has('mac')
	set guifont=Andale\ Mono:h13
    else
	set guifont=Terminus:h16
    end

    if has('mac')
	set noantialias
	" set fullscreen
	set fuoptions=maxvert,maxhorz ", background:#00AAaaaa
    endif
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark
" "}}}


" Key mappings "{{{
" Duplication
nnoremap <leader>c mz"dyy"dp`z
vnoremap <leader>c "dymz"dP`z

" Tabs
nnoremap <M-h> :tabprev<CR>
nnoremap <M-l> :tabnext<CR>
" Esc
inoremap <leader>, <Esc>
inoremap ;; <Esc>
inoremap <C-return> <Esc>
inoremap <C-space> <Esc>

" Buffers operate
" edit next buffer
map <silent> <leader>bn <ESC><ESC>:bn<CR>
map <F12> <ESC><ESC>:bn<CR>
" Delete a buffer but keep layout
if has("eval")
    command! Kwbd enew|bw #
    nmap     <C-w>!   :Kwbd<CR>
endif

" Split line(opposite to S-J joining line)
nnoremap <C-J> gEa<CR><ESC>ew

" copy filename
map <silent> <leader>. :let @+=expand('%').':'.line('.')<CR>
" copy path
map <silent> <leader>/ :let @+=expand('%:p:h')<CR>

map <S-CR> A<CR><ESC>

map <leader>E :Explore<CR>
map <leader>EE :Vexplore!<CR><C-W>=

" Make control-direction switch between windows (like C-W h, etc)
nmap <C-k> <c-W>k
nmap <C-j> <C-W>j
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" vertical split with CommandT
nnoremap <leader>v :exec ':vnew \| CommandT'<CR>
" and without
nnoremap <leader>V :vnew<CR>

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
" noremap <C-S> :update<CR>
" vnoremap <C-S> <C-C>:update<CR>
" inoremap <C-S> <C-O>:update<CR>

" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

ab #e # encoding: UTF-8

" Paste toggle (,p)
set pastetoggle=<leader>p
map <leader>p :set invpaste paste?<CR>

" Number toggle (,n)
nmap <leader>n :set invnumber<CR>

" Strip trailing whitespace (,sw)
function! StripWhitespace ()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction
noremap <leader>sw :call StripWhitespace ()<CR>

" Indent/unident block (,]) (,[)
nnoremap <leader>] >i{<CR>
nnoremap <leader>[ <i{<CR>


" "}}}


" AutoCommands "{{{
" "}}}

" Scripts and Bundles "{{{
filetype off
"runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


Plugin 'VundleVim/Vundle.vim'

"Colorscheme
Plugin 'molokai'
Plugin 'nelstrom/vim-mac-classic-theme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'gmarik/ingretu'
Plugin 'sonph/onehalf', {'rtp': 'vim/'}

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
"  colorscheme evening
"  colorscheme ingretu
  colorscheme onehalflight
"  colorscheme molokai
"  colorscheme vim-mac-classic-theme
"  colorscheme solarized
endif


" =========   original repos on github
"Plugin 'vim-latex/vim-latex'
" Go
"Plugin 'fatih/vim-go'
" Git integration
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-fugitive'
" set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
" Gblame, Gread
nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <silent> <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S

Plugin 'vim-ruby/vim-ruby'

" Plugin 'vim-latex/vim-latex.github.com'
Plugin 'gerw/vim-latex-suite'
Plugin 'fs111/pydoc.vim.git'

Plugin 'mitechie/pyflakes-pathogen.git'
let g:pyflakes_use_quickfix=1

" syntacs checker
Plugin 'scrooloose/syntastic'
let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" tags
Plugin 'majutsushi/tagbar'
let g:Tlist_Ctags_Cmd='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
nmap <F10> :TagbarToggle<CR>

Plugin 'mkitt/browser-refresh.vim'
com! ONRRB :au! BufWritePost <buffer> :RRB
com! NORRB :au! BufWritePost <buffer>

" " like grep, binding for perl module App:Ack
" Plugin 'mileszs/ack.vim.git'
" nmap <leader>a <Esc>:Ack!

"Plugin 'tpope/unimpaired.vim'
Plugin 'unimpaired.vim'
" bubble current line
nmap <M-j> ]e
nmap <M-k> [e
" bubble visual selection lines
vmap <M-j> ]egv
vmap <M-k> [egv

"git gutter
Plugin 'airblade/vim-gitgutter'

" fuzzy finder
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" for writing notes
Plugin 'alok/notational-fzf-vim'
let g:nv_search_paths = ['~/Google\ Drive/notes/', '~/works/mynotes/']

" status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" airline font
"let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
" airline thems
let g:airline_theme = 'dark'
" airline extension
" let g:airline#extensions#syntastic#enabled = 1
" let g:airline#extensions#tagbar#enabled = 1
" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#show_close_button = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
let g:airline#extensions#tmuxline#enabled = 0



" Plugin 'wincent/Command-T.git'
" let g:CommandTMatchWindowAtTop=0 " show window at top
" "burke's
" nnoremap <silent> <leader>ct :CommandT<CR>
" nnoremap <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
" nnoremap <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
" nnoremap <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
" nnoremap <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
" nnoremap <leader>ga :CommandTFlush<cr>\|:CommandT app/assets<cr>
" nnoremap <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
" "nnoremap <leader>gr :topleft :vsplit config/routes.rb<cr>
" "nnoremap <leader>gg :topleft :vsplit Gemfile<cr>

" Plugin 'Lokaltog/vim-easymotion'
" let g:EasyMotion_leader_key='<LocalLeader>'

"Plugin 'gmarik/hlmatch.vim'
" nnoremap # :<C-u>HlmCword<CR>
" nnoremap <leader># :<C-u>HlmGrepCword<CR>
" vnoremap # :<C-u>HlmVSel<CR>
" vnoremap <leader># :<C-u>HlmGrepVSel<CR>
"
" nnoremap ## :<C-u>HlmPartCword<CR>
" nnoremap <leader>## :<C-u>HlmPartGrepCword<CR>
" vnoremap ## :<C-u>HlmPartVSel<CR>
" vnoremap <leader>## :<C-u>HlmPartGrepVSel<CR>

Plugin 'mustache/vim-mustache-handlebars'

" ============    vim-scripts repos
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" " FuF customisations "{{{
" let g:fuf_modesDisable = []
" nnoremap <leader>h :FufHelp<CR>
" nnoremap <leader>2 :FufFileWithCurrentBufferDir<CR>
" nnoremap <leader>@ :FufFile<CR>
" nnoremap <leader>3 :FufBuffer<CR>
" nnoremap <leader>4 :FufDirWithCurrentBufferDir<CR>
" nnoremap <leader>$ :FufDir<CR>
" nnoremap <leader>5 :FufChangeList<CR>
" nnoremap <leader>6 :FufMruFile<CR>
" nnoremap <leader>7 :FufLine<CR>
" nnoremap <leader>9 :FufTaggedFile<CR>
"
" nnoremap <leader>p :FufDir ~/src/<CR>
" nnoremap <leader>gg :FufDir ~/.rvm/gems/<CR>
"
" nnoremap <leader>gn :vnew \| :FufFile ~/src/notes/<CR>

" " }}}

" reST edit
Plugin 'Rykka/riv.vim'

" to do list
Plugin 'TaskList.vim'
nnoremap <silent> <F3> :TlistToggle<CR>

Plugin 'The-NERD-tree'
" programming
Plugin 'jQuery'

" (HT|X)ml tool
Plugin 'ragtag.vim'

" " Revision History
"Plugin 'Gundo'
"nnoremap <leader>g :GundoToggle<CR>
Plugin 'mbbill/undotree'

" indentation mark up
"Plugin 'Indent-Guides'
"let g:indent_guides_guide_size = 1
"Plugin 'Yggdroot/indentLine'

Plugin 'ZoomWin'
noremap <leader>o :ZoomWin<CR>
vnoremap <leader>o <C-C>:ZoomWin<CR>
inoremap <leader>o <C-O>:ZoomWin<CR>

Plugin 'tlib'
Plugin 'tComment'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Plugin 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1

" java unused imports
Plugin 'akhaku/vim-java-unused-imports'

" auto complete brackets
Plugin 'Townk/vim-autoclose'
"Plugin 'Raimondi/delimitMate'

Plugin 'vim-scripts/VimClojure'

" ============    non github repos

"  "}}}
"
"

function! SuperCleverTab()
    if strpart(getline('.'), 0, col('.') - 1) =~ '^\s*$'
        return "\<Tab>"
    else
        if &omnifunc != ''
            return "\<C-X>\<C-O>"
        elseif &dictionary != ''
            return "\<C-K>"
        else
            return "\<C-N>"
        endif
    endif
endfunction

inoremap <Tab> <C-R>=SuperCleverTab()<cr>


filetype plugin indent on


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.

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

  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " python setting
  autocmd FileType python setlocal ts=8 sts=4 sw=4 tw=72 ai et
  autocmd FileType python setlocal smartindent nosmarttab
  autocmd FileType python setlocal cinwords=def,if,elif,else,for,while,try,except,finall
  autocmd FileType python setlocal fileformat=unix
  autocmd FileType python setlocal textwidth=120

  " Use the below highlight group when displaying bad whitespace is desired.
  highlight BadWhitespace ctermbg=red guibg=red
  " Display tabs at the beginning of a line in Python mode as bad.
  au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
  " Make trailing whitespace be flagged as bad.
  autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.java,*.sh match BadWhitespace /\s\+$/

  " makefile setting
  autocmd BufRead,BufNewFile Makefile* setlocal noexpandtab

  " C++/C setting
  autocmd BufNewFile *.cpp,*.hpp,*.c,*.h setlocal fileformat=unix
  autocmd FileType c,cpp setlocal textwidth=120
  autocmd FileType c,cpp setlocal ts=4 sts=4 sw=4
  autocmd FileType c,cpp setlocal noexpandtab smarttab
  autocmd FileType c,cpp setlocal cindent smartindent autoindent

  " javascript setting
  autocmd FileType javascript setlocal ts=4 sts=2 sw=2 tw=72 ai expandtab
  autocmd FileType javascript setlocal smartindent nosmarttab
  autocmd FileType javascript setlocal fileformat=unix

  " ruby
  autocmd FileType ruby setlocal ts=4 sts=2 sw=2 ai et
  autocmd FileType ruby setlocal smartindent nosmarttab
  autocmd FileType python setlocal fileformat=unix

  augroup END

endif

"==================================================================
"
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
"let g:Tex_ViewRule_pdf ='evince $*.pdf >& /dev/null'
"let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview $*.pdf' 
let g:Tex_ViewRuleComplete_pdf = '/usr/bin/open -a Preview $*.pdf' 
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
"map <F2> <ESC><ESC>:redraw!<CR>
map <F2> <ESC><ESC>:tabp<CR>
map <F3> <ESC><ESC>gt<CR>
map <F4> <C-W>W

"---------------------------------------------------
"  NERDTree
"---------------------------------------------------
nmap <silent><leader>nt <ESC><ESC>:NERDTreeToggle<CR>
map <F9> <ESC><ESC>:NERDTreeToggle<CR>

"---------------------------------------------------
" fzf setting
"---------------------------------------------------
nnoremap <leader>f :Files<cr>

" spell check
map <silent> <leader>sp :setlocal spell! spelllang=en_us<CR>

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


":BundleInstall
" vim: textwidth=120:
