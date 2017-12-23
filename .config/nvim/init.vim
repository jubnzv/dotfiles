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
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/fatih/vim-go'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/neovimhaskell/haskell-vim'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
"Plug 'nvie/vim-flake8'
Plug 'https://github.com/rosenfeld/conque-term'
Plug 'https://github.com/chrisbra/Colorizer'
Plug 'https://github.com/godlygeek/tabular'
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

""" Buffers list in the tabline
set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
"""

""" Keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

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
" Misc
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
map <Leader>+ :bd<cr>
map <Leader>a :Ack!<Space>
" Convient emacs-like binds
map <C-X><C-F> :FZF<cr>
map <C-X><C-C> :qa<cr>
map <C-X><C-D> :bd<cr>
" Coding
inoremap <Leader>; <C-o>A;
inoremap <Leader>j; <C-o>A;<CR>
map <A-t> :NERDTreeToggle<CR>
map <A-e> :SyntasticCheck<CR>
map <C-A-e> :SyntasticReset<CR>

" Remove all trailing whitespaces
nnoremap <silent> <Leader><Space> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

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

"""Fix python imports order
autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>
"""

""" Easymotion settings
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap <C-x>z <Plug>(easymotion-overwin-f)
let g:EasyMotion_smartcase = 1
"map <C-j> <Plug>(easymotion-j)
"map <C-k> <Plug>(easymotion-K)

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
" Linux coding style plugin
"source ~/.vim/scripts/linuxsty.vim
set tabstop=4
set shiftwidth=4
set expandtab  " on pressing tab insert 4 spaces
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
nmap <F8> :TlistToggle<CR>
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

""" Other
"" css
autocmd Filetype css setlocal tabstop=4
"" html
autocmd Filetype html setlocal tabstop=4
"""
