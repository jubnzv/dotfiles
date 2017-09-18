""" Leader
let mapleader = "-"
"""

""" Misc
set nocompatible
"""

""" Plugins
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/fatih/vim-go'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/neovimhaskell/haskell-vim'
Plug 'https://github.com/vim-syntastic/syntastic'
" Initialize plugin system
call plug#end()
"""

""" GUI & eye candy appearance
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set relativenumber
set cursorline
set laststatus=2 " always show status line
set t_Co=256       " 256-colors mode
set background=dark
colorscheme gruvbox
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'
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

""" Keybindings
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>
nnoremap <F9> :call NumberToggle()<CR>
imap jj <Esc>
imap <C-f> <right>
imap <C-b> <left>
imap <C-p> <up>
imap <C-n> <down>
imap <A-f> <right>
imap <A-b> <left>
map <Leader>j <Esc>
map <Leader>w :w<cr>
map <Leader>x :x<cr>
map <Leader>q :q<cr>
map <Leader>` :qa!<cr>
map <Leader>= :bn<cr>
map <Leader>- :bp<cr>
map <Leader>+ :bd<CR>
"""

""" Commenting by <C-/> like pycharm
if has('win32')
		nmap <C-/> <leader>c<Space>
		vmap <C-/> <leader>c<Space>
else
		nmap <C-_> <leader>c<Space>
		vmap <C-_> <leader>c<Space>
endif
"""

""" Easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap s <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
"map <C-j> <Plug>(easymotion-j)
"map <C-k> <Plug>(easymotion-K)

""" Appearance
set wildmenu
set wildmode=longest,list
"""

""" Coding style
" Linux coding style plugin
"source ~/.vim/scripts/linuxsty.vim
" Defaults
set tabstop=4
" 80+ characters line highlight
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

"""
" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

""" ctags
" configuration for ctags.vim script
"source ~/.vim/scripts/ctags.vim
"CTAGS
" autoload ctags
"set tags=tags;/
" show ctags function name in command line
"let g:ctags_statusline=1
"""

""" Tag List plugin
nmap <Esc>r :TlistToggle<CR>
"""

" Autopair

""" golang settings
"" Syntax highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"" IDE functional
au FileType go nmap <leader>r <plug>(go-run)
au FileType go nmap <leader>d <plug>(go-doc)
au FileType go nmap <leader>f <plug>(go-fmt)
"""

""" haskell
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

""" Syntastics setup
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint', 'ghc_mod']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

""" Other
"" css
autocmd Filetype css setlocal tabstop=4
"" html
autocmd Filetype html setlocal tabstop=4
"""
