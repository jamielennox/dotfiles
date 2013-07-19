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

set spelllang=en_au     " Localized Spelling

set colorcolumn=80      " show warning column at 85 chars
set hidden              " don't unload buffers when it is not shown

set scrolloff=3         " Start scrolling 3 lines from bottom
nnoremap ; :

" learn to use hjkl
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>

" up/down goes to within wrapped lines instead of skipping
nnoremap j gj
nnoremap k gk

" select the most recent pasted region
nmap gV `[v`]

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" clear search highlights
nmap <silent> <leader>/ :nohlsearch<CR>

map <leader>y :YRShow<CR>
map <leader>v :tabedit $MYVIMRC<CR>
map <leader>s :set spell!<CR> " Toggle

" This is simply a screen refresh as for some reason I sometimes lose my cursor
map <leader>c :!echo > /dev/null<CR>

" This doesn't have a <CR> on purpose so you can choose what to align
map <leader>a :Tabularize/

" Show the full length filename:linenumber. Userful for breakpoints.
map <leader>b :echo printf("%s:%d", expand('%:p'), line('.'))<CR>

" write it with sudo
cmap w!! w !sudo tee % >/dev/null

" Ooops i'm pretty sure i didn't mean to hit help
inoremap <F1> <nop>
nnoremap <F1> <nop>
vnoremap <F1> <nop>

" http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")

  " Do the business:
  execute a:command

  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! StripTrailingWhiteSpaces()
  call Preserve("%s/\\s\\+$//e")
endfunction

" correctly format certain files
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru,*.gemspec} set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG,.stgit-*.txt} set ft=gitcommit

" syntax overrides
autocmd FileType ruby,yml set shiftwidth=2
" autocmd FileType c,cpp,python,ruby,java autocmd BufWritePre <buffer> call StripTrailingWhiteSpaces()
autocmd BufWritePre * call StripTrailingWhiteSpaces()

" reload vimrc if it changes
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source $MYVIMRC
augroup END

runtime macros/matchit.vim      " % tag/bracket matching

" set tabstop=4

set mat=5 " bracket matching
set completeopt+=longest " omni autocomplete use longest match

set backupdir=~/.vim/tmp
set directory=~/.vim/tmp

" Easy tab opening
nnoremap <C-S-t> :tabnew<CR>
inoremap <C-S-t> <Esc>:tabnew<CR>

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

" for when you accidently hit <S>w when you just mean w
cabbr W w
cabbr Q q

nmap <F3> :NumbersToggle<CR>
nmap <F5> :GundoToggle<CR>
nmap <F6> :ScratchToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>

if has("gui_running")
    " GUI is running or is about to start.
    set spelllang=en_au
    set spell
endif

" Setup:  git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" Run: open vim and run :BundleInstall

Bundle 'gmarik/vundle'
Bundle 'YankRing.vim'
Bundle 'L9'
Bundle 'tComment'
" Command-T requires compiling a c extension. see :help command-t-installation
Bundle 'Command-T'
Bundle 'snipMate'
Bundle 'Gundo'
Bundle 'Tagbar'
Bundle 'virtualenv.vim'
Bundle 'jamielennox/scratch.vim'
Bundle 'kana/vim-textobj-user'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'godlygeek/tabular'
Bundle 'ervandew/supertab'
Bundle 'sjbach/lusty'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'myusuf3/numbers.vim'

" use ctrl+space for auto complete, tab is annoying
let g:SuperTabMappingForward = '<c-space>'
let g:SuperTabMappingBackward = '<s-c-space>'

" Auto pop up syntax error list
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5

let g:syntastic_python_checkers=['flake8']
" let g:syntastic_python_flake8_tail='| grep -v "W802 undefined name _"'

" E501: Line length < 80
" E126: Under indented hanging line
" E128: Over indented hanging line
" W391: Blank line at end of file
" let g:syntastic_python_flake8_args='--ignore=E126,E128,W391'
