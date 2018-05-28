""" Leader key {{{1
let mapleader = "\<Space>"

""" Misc {{{1
set nocompatible

""" Plugins {{{1
call plug#begin('~/.local/share/nvim/plugged')

" Misc {{{2
Plug 'https://github.com/mileszs/ack.vim'
Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.local/opt/fzf', 'do': './install --all' }
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/rosenfeld/conque-term'
Plug 'https://github.com/kshenoy/vim-signature'
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/gcmt/wildfire.vim'

" UI & appearance {{{2
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/morhetz/gruvbox'
Plug 'https://github.com/ap/vim-buftabline'
Plug 'https://github.com/chrisbra/Colorizer'

" Coding tools {{{2
" General {{{3
" Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/vim-syntastic/syntastic'
Plug 'https://github.com/mattn/sonictemplate-vim'
Plug 'https://github.com/godlygeek/tabular'
Plug 'https://github.com/vim-scripts/taglist.vim'
Plug 'https://github.com/majutsushi/tagbar'
Plug 'https://github.com/tyru/current-func-info.vim'
Plug 'https://github.com/brookhong/cscope.vim'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/dag/vim-fish'
Plug 'https://github.com/Valloric/YouCompleteMe'
Plug 'https://github.com/SirVer/ultisnips'
Plug 'https://github.com/honza/vim-snippets'

" C {{{3
Plug 'https://github.com/vivien/vim-linux-coding-style'
Plug 'https://github.com/vim-scripts/a.vim'

" Golang {{{3
Plug 'https://github.com/fatih/vim-go'

" Python {{{3
Plug 'https://github.com/heavenshell/vim-pydocstring'

" IEC 61131-3 {{{3
" Plug 'https://github.com/jubnzv/IEC.vim.git'

" Markdown & config formats {{{2
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/cespare/vim-toml'
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview'
Plug 'https://github.com/nvie/vim-rst-tables'
Plug 'https://github.com/chr4/nginx.vim'

" Documentation {{{2
Plug 'https://github.com/vim-scripts/DoxygenToolkit.vim'

" Sandbox {{{2
Plug '~/Dev/IEC.vim'
Plug '~/Dev/nerdcommenter'

call plug#end()

""" Force python3 {{{1
" if has('python3')
" elif has('python')
" endif
" 1}}}

""" GUI & eye candy appearance {{{1
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

""" Undo options {{{1
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

""" Integrate with system clipboard {{{1
set clipboard=unnamedplus,unnamed

""" Buffers list in the tabline {{{1
set hidden
nnoremap <C-K> :bnext<CR>
nnoremap <C-J> :bprev<CR>
nnoremap <C-F4> :bdelete<CR>

""" Keep selected text selected when fixing indentation {{{1
vnoremap < <gv
vnoremap > >gv

""" Disable annoying arrows {{{1
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Relative or absolute number lines {{{1
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction

""" Folding settings {{{1
set foldmethod=syntax
set foldnestmax=6
set nofoldenable " disable folding when open file
set foldlevel=2
let g:markdown_folding = 1

""" Keybindings {{{1
set timeoutlen=200
" General {{{2
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
nnoremap <leader>vs :so $MYVIMRC<CR>
map <C-X><C-F> :FZF<cr>

" Show current function {{{1
nnoremap <Leader>f :echo cfi#format("%s", "")<CR>
nmap <F8> :TlistToggle<CR>

" E45: 'readonly' option is set (add ! to override) {{{1
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

""" Nerdcommenter settings {{{1
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

""" NerdTree {{{1
map <A-t> :NERDTreeToggle<CR>

""" Easymotion {{{1
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <A-;> <Plug>(easymotion-overwin-f)
map <A-l> <Plug>(easymotion-overwin-line)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

""" Ag/Ack {{{1
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

""" Coding style general {{{1
set tabstop=4
set shiftwidth=4
set expandtab  " on pressing tab insert 4 spaces
autocmd Filetype css setlocal tabstop=4
autocmd Filetype html setlocal tabstop=4

" 79+ characters line highlight {{{1
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%79v', 100)

""" Kernel settings {{{1
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

""" Trailing whitespaces {{{1
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Highlight
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Remove all trailing whitespaces
nnoremap <silent> <Leader>S :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

""" ctags {{{1
set tags=./tags;
let g:ctags_statusline=1

""" cscope {{{1
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find usages (functions calling this function)
nnoremap  <leader>fu :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

""" Syntastics setup {{{1
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_c_checkers=['make','gcc']
let g:syntastic_haskell_checkers = ['hdevtools', 'hlint', 'ghc_mod']
let g:syntastic_loc_list_height=3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
nnoremap <Leader><F3> :SyntasticCheck<CR> :SyntasticToggleMode<CR>
map <A-e> :SyntasticCheck<CR>
map <C-A-e> :SyntasticReset<CR>
nnoremap ]e :lnext <CR>
nnoremap [e :lprevious<CR>

""" Golang mode settings {{{1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>r <plug>(go-run)
au FileType go nmap <leader>d <plug>(go-doc)
au FileType go nmap <leader>f <plug>(go-fmt)

""" Python settings {{{1
"let g:python_highlight_all = 1
"let g:python_highlight_space_errors=0

""" Fix python imports order
autocmd FileType python nnoremap <Leader>i :!isort %<CR><CR>

""" Conque term with ipython buffer
nnoremap <Leader><F10> :ConqueTermSplit ipython<CR>
nnoremap <Leader><F9> :exe ":ConqueTermSplit ipython " . expand("%")<CR>

""" Markdown preview {{{1
let vim_markdown_preview_github=1  " Support grip
let vim_markdown_preview_hotkey='<leader><C-m>'

""" wildmenu options {{{1
set wildmenu
set wildmode=longest,list

""" MatIEC configuration {{{1
let matiec_path = '/home/jubnzv/Dev/Beremiz/matiec/'
let matiec_mkbuilddir = 1

""" Snippets & autocomplition {{{1
let g:UltiSnipsExpandTrigger="<M-i>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:ycm_show_diagnostics_ui = 0
let g:ycm_key_list_select_completion   = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']

""" Timestamp routines {{{1
" language time C
nnoremap <leader><leader>t "=strftime("%Y-%m-%d")<CR>P
inoremap <leader><leader>t <C-R>=strftime("%Y-%m-%d")<CR>
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()
""" }}}1

""" Doxygen {{{1
let g:DoxygenToolkit_commentType = "C"
autocmd FileType c nnoremap <leader>d :Dox<CR>
"""}}}1

" vim: foldmethod=marker sw=4
