""" Leader key
let mapleader = "\<Space>"
"""

""" Misc
set nocompatible
"""

""" Plugins
call plug#begin('~/.local/share/nvim/plugged')
" Misc
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/rosenfeld/conque-term'
Plug 'https://github.com/kshenoy/vim-signature'
Plug 'https://github.com/easymotion/vim-easymotion'
" UI / appearance
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/chrisbra/Colorizer'
" Programming general
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/mattn/sonictemplate-vim'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/tyru/current-func-info.vim'
Plug 'https://github.com/brookhong/cscope.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'
" Golang
Plug 'https://github.com/fatih/vim-go'
" Python
Plug 'https://github.com/heavenshell/vim-pydocstring'
" Markdown & configuration support
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/cespare/vim-toml'
" Sandbox
"Plug '~/Dev/neovim-dev/iec-mode/'
Plug 'https://github.com/jubnzv/IEC.vim.git'
call plug#end()
"""

""" GUI & eye candy appearance
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set relativenumber
set cursorline
set laststatus=2   " always show status line
set t_Co=256       " 256-colors mode
set background=dark
set title
colorscheme gruvbox
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
set scrolloff=3  " 3 lines above/below cursor when scrolling
"""

""" Integrate with system clipboard
set clipboard=unnamedplus,unnamed
"""

""" Buffers list in the tabline
set hidden
nnoremap <C-K> :bnext<CR>
nnoremap <C-J> :bprev<CR>
"""

""" Keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv
"""

"""
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
"""

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction
"""

""" Folding settings
set foldmethod=indent
set foldnestmax=6
set nofoldenable " disable folding when open file
set foldlevel=2

" Markdown
let g:markdown_folding = 1
"""

""" Keybindings
" Misc
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>
nnoremap <F9> :call NumberToggle()<CR>
imap fd <Esc>
map <Leader>j <Esc>
map <Leader>w :w<cr>
map <Leader>x :x<cr>
map <Leader>q :q<cr>
map <Leader>` :qa!<cr>
map <Leader>a :Ack!<Space>
" Convient emacs-like binds
map <C-X><C-F> :FZF<cr>
imap <C-f> <right>
imap <C-b> <left>
"imap <C-p> <up>
"imap <C-n> <down>
"imap <A-f> <right>
"imap <A-b> <left>
" Coding
map <A-t> :NERDTreeToggle<CR>
map <A-e> :SyntasticCheck<CR>
map <C-A-e> :SyntasticReset<CR>

" Remove all trailing whitespaces
nnoremap <silent> <Leader>S :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
"""

""" Nerdcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
" Commenting by <C-/> like pycharm
if has('win32')
		nmap <C-/> <leader>c<Space>
		vmap <C-/> <leader>c<Space>
else
		nmap <C-_> <leader>c<Space>
		vmap <C-_> <leader>c<Space>
endif
"""

""" Fix python imports order
autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>
"""

""" Easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Leader>; <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
"""

""" Ag/Ack settings
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"""

""" Appearance
set wildmenu
set wildmode=longest,list
"""

""" Coding style
"source ~/.vim/scripts/linuxsty.vim  " Linux Kernel style
set tabstop=4
set shiftwidth=4
set expandtab  " on pressing tab insert 4 spaces
" 80+ characters line highlight
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

""" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
"""

""" ctags
set tags=./tags;
let g:ctags_statusline=1
"""

""" cscope
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
"""

""" Tag List plugin
nmap <F8> :TlistToggle<CR>
"""

""" golang mode settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>r <plug>(go-run)
au FileType go nmap <leader>d <plug>(go-doc)
au FileType go nmap <leader>f <plug>(go-fmt)
"""

""" python
"let g:python_highlight_all = 1
"let g:python_highlight_space_errors=0
"""

""" Conque term with ipython buffer
nnoremap <Leader><F10> :ConqueTermSplit ipython<CR>
nnoremap <Leader><F9> :exe ":ConqueTermSplit ipython " . expand("%")<CR>
"""

""" Syntastics setup
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <Leader><F3> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
let g:syntastic_loc_list_height=3
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint', 'ghc_mod']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"""

""" Show current function
nnoremap <Leader>f :echo cfi#format("%s", "")<CR>
"""

""" Other
autocmd Filetype css setlocal tabstop=4
autocmd Filetype html setlocal tabstop=4
"""
