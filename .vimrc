set nocompatible        " Don't care about vi syntax
filetype off            " Needs to be off before vundle, on again later
let mapleader = ","     " and it needs to go above plugin loading

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype indent plugin on

set autoindent          " always set autoindenting on
set backspace=indent,eol,start
                        " traditional backspacing over everything
set smartindent
set smarttab            " insert tabs on the start of a line according to
                        "    shiftwidth, not tabstop
set expandtab           " expand tabs to whitespace
set ignorecase          " ignore case when searching
set smartcase           " ignore case if search pattern is all lowercase,
                        " case-sensitive otherwise

set hlsearch            " highlight search terms
set incsearch           " show search matches as you type
set relativenumber      " always show line numbers

set cinwords=if,else,while,do,for,switch,case

set shiftwidth=4        " tabs are 4 spaces
set wildignore=*.swp,*.pyc
                        " Don't open these
set visualbell          " don't beep
set pastetoggle=<F2>    " Press F2 for when you paste into vim and
                        "     the formatting goes crazy
set gdefault            " always find/replace global /g
set showmatch           " show matching parenthesis
set incsearch           " show search matches as you type

set colorcolumn=85      " show warning column at 85 chars
set hidden

set scrolloff=3         " Start scrolling 3 lines from bottom
nnoremap ; :

" learn to use hjkl
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" up/down goes to within wrapped lines instead of skipping
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" clear search highlights with ,/
nmap <silent> <leader>/ :nohlsearch<CR>

" write it with sudo
cmap w!! w !sudo tee % >/dev/null

" Ooops i'm pretty sure i didn't mean to hit help
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" correctly format certain files
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

" syntax overrides
autocmd filetype ruby set shiftwidth=2

" strip trailing whitespace from lines
autocmd BufWritePre * :%s/\s\+$//e

" reload vimrc if it changes
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

runtime macros/matchit.vim      " % tag/bracket matching

" set tabstop=4

set mat=5 " bracket matching

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" Tab naviagation by ALT+[number]
map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <A-0> :tablast<CR>

cabbr W w
cabbr Q q

nmap <F8> :TagbarToggle<CR>

if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window.
    set lines=999 columns=999

    set spelllang=en_au
    set spell
endif


" Setup:  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Run: open vim and run :BundleInstall

Bundle 'gmarik/vundle'
Bundle "YankRing.vim"
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle "tComment"
Bundle "snipMate"
Bundle 'gundo'
Bundle 'kana/vim-textobj-user'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'godlygeek/tabular'
Bundle 'sjbach/lusty'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-textobj-rubyblock'


