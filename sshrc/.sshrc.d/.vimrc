let mapleader = " "
set nocompatible

" {{{ General
set viminfo='1000,f1                        " Save global marks for up to 1000 files
set scrolloff=7                             " 7 lines above/below cursor when scrolling
set scroll=7                                " Number of lines scrolled by <C-u> and <C-d>
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set clipboard=unnamedplus,unnamed           " Use system clipboard
set showmatch                               " Show matching brackets when text indicator is over them
set mat=1                                   " How many tenths of a second to blink when matching brackets
set wildmenu                                " wildmenu: command line completion
set wildmode=longest,list
set wildignore=*.o,*~,*.pyc,*.aux,*.out,*.toc
set timeoutlen=500                          " Time to wait for a mapped sequence to complete (ms)
set notimeout                               " Remove delay between complex keybindings.
set noautochdir                             " Set working directory to the current file
set autoindent                              " Autoindent when starting new line, or using o or O.
set noautoread                              " Don't reload unchanged files automatically.
set hidden
set tabstop=4
set shiftwidth=4
set expandtab                               " On pressing tab insert 4 spaces

" Cyrillic layout in normal mode
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]
" }}}

" {{{ UI options
set guioptions-=m                           " Remove menu bar
set guioptions-=T                           " Remove toolbar
set guioptions-=r                           " Remove right-hand scroll bar
set guioptions-=L                           " Remove left-hand scroll bar
set shortmess+=Ic                           " Don't display the intro message on starting vim
set noshowmode
set relativenumber
set cursorline
set laststatus=2                            " Always show status line
set title                                   " Show window title
set signcolumn=yes
set background=dark
" set t_Co=256                                " 256-colors mode
set guicursor+=c-ci-cr:block                " Cursor style

" Italic symbols in terminal
set t_ZH=^[[3m
set t_ZR=^[[23m
" }}}

" {{{ Keybindings
imap jj <Esc>
nnoremap <leader>b :ls<CR>:b<space>
" }}}

""" Appearance
set wildmenu
set wildmode=longest,list

" 80+ characters line highlight
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
