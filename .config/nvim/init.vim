set nocompatible
let mapleader = "\<Space>"
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" {{{1 Plugins
call plug#begin('~/.local/share/nvim/plugged')

" {{{2 General
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/kshenoy/vim-signature'          " Bookmarks extended
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/lyokha/vim-xkbswitch'           " ru keybinds in normal mode
Plug 'https://github.com/terryma/vim-multiple-cursors'
Plug 'https://github.com/rhysd/clever-f.vim'             " Convient `f` / `F`
" Plug 'https://github.com/christoomey/vim-tmux-navigator'
" Plug 'https://github.com/benmills/vimux'
Plug 'https://github.com/junegunn/fzf.vim'               " Fuzzy-finder integration
Plug 'https://github.com/junegunn/fzf', {
    \ 'dir': '~/.local/opt/fzf',
    \ 'do': './install --all'
    \ }
" }}}2

" {{{2 UI & appearance
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/ap/vim-buftabline'        " Show buffers in the tabline
Plug 'https://github.com/morhetz/gruvbox'          " Color scheme
Plug 'https://github.com/chrisbra/Colorizer'       " Color colornames and codes
Plug 'https://github.com/Yggdroot/indentLine'      " Show identation as vertical lines
Plug 'https://github.com/haya14busa/incsearch.vim' " Incrementaly highlight search results
Plug 'https://github.com/junegunn/goyo.vim'        " `Zen-mode`
Plug 'https://github.com/junegunn/limelight.vim'   " `Hyperfocused writing`
" }}}2

" {{{2 Text editing
Plug 'https://github.com/jubnzv/DoxygenToolkit.vim'      " Doxygen helper
Plug 'https://github.com/pearofducks/ansible-vim'        " Ansible format support
Plug 'https://github.com/cespare/vim-toml'               " .toml
Plug 'https://github.com/chr4/nginx.vim'                 " Nginx configuration files
Plug 'https://github.com/othree/xml.vim'                 " Extended XML/XSD features
Plug 'https://github.com/dhruvasagar/vim-table-mode'     " Simplifies plain text tables creation
Plug 'https://github.com/lervag/vimtex'                  " LaTeX support
Plug 'https://github.com/plasticboy/vim-markdown'        " Extended markdown support
Plug 'https://github.com/gu-fan/riv.vim'                 " .rst
" }}}2

" {{{2 Coding tools
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/tpope/vim-fugitive'         " Git wrapper
Plug 'https://github.com/airblade/vim-gitgutter'     " Show git diffs in the gutter
Plug 'https://github.com/godlygeek/tabular'          " Create fancy tabularized comments
Plug 'https://github.com/majutsushi/tagbar'          " Display sorted tags in a window
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/terryma/vim-expand-region'
Plug 'https://github.com/Shougo/neosnippet.vim'
Plug 'https://github.com/Shougo/neosnippet-snippets'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" {{{3 Language-specific
Plug 'https://github.com/vivien/vim-linux-coding-style' " Kernel style settings
Plug 'https://github.com/nacitar/a.vim'                 " Quick switch to .h
Plug 'https://github.com/fatih/vim-go'                  " Golang plugin
Plug 'https://github.com/dag/vim-fish'                  " fish scripting language support
Plug 'https://github.com/junegunn/vader.vim'            " vimscript testing framework
Plug 'https://github.com/Kuniwak/vint'                  " vimscript linter
Plug '~/Dev/IEC.vim'                                    " IEC 61131-3 support
" }}}3
" }}}2

call plug#end()
" }}}1

" {{{1 GUI / appearance
set guioptions-=m  " Remove menu bar
set guioptions-=T  " Remove toolbar
set guioptions-=r  " Remove right-hand scroll bar
set guioptions-=L  " Remove left-hand scroll bar
set relativenumber
set cursorline
set laststatus=2   " Always show status line
set background=dark
set t_Co=256       " 256-colors mode
colorscheme gruvbox
set title          " Show window title

" {{{2 Modeline | tabline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \              [ 'readonly', 'filename', 'modified' ],
    \              [ 'tagbar' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ],
    \              [ 'gitbranch' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \ },
    \ }
let g:buftabline_indicators=1 " show modified
" }}}2

" }}}1

" {{{1 Goyo & Limelight settings
map <F11> :Goyo<CR>

function! s:goyo_enter()
    set scrolloff=999
    Limelight
    set showtabline=0
    set signcolumn=no
endfunction

function! s:goyo_leave()
    set scrolloff=7
    Limelight!
    set showtabline=2
    set signcolumn=yes
    call buftabline#update(0)
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}1

" Scrolling options
set scrolloff=7     " 7 lines above/below cursor when scrolling
set scroll=7        " Number of lines scrolled by C-u / C-d

" Autoindent when starting new line, or using o or O.
" set autoindent

" Reload unchanged files automatically.
" set autoread

" Don't parse modelines (google "vim modeline vulnerability").
set nomodeline

" Use dash as word separator.
set iskeyword+=-

" Don't display the intro message on starting Vim.
set shortmess+=I

" 1{{{ Make normal mode compatible with ru keymap
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set keymap=russian-jcukenwin
let g:XkbSwitchLib = "/usr/local/lib/libxkbswitch.so"
" echo libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
" call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us')
let g:XkbSwitchEnabled = 0
let g:XkbSwitchLoadRIMappings = 0
let g:XkbSwitchIMappings = ['ru']
" }}}1

" {{{1 Buffers/windows manipulation
set hidden
nnoremap <C-k> :bnext<CR>
nnoremap <C-j> :bprev<CR>
nnoremap <C-F4> :bdelete<CR>
nnoremap <leader>wh :only<CR>
" Switch between current and last buffer
nmap <A-r> <C-^>
" Reopen last closed buffer
" let MRU_File = $HOME.'/.vim/mru_file'
" let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'
" nmap <c-s-t> :MRU<CR><CR>
""" }}}1

" {{{1 tmux integration
if exists('$TMUX')
    " Prefix key
    map ` <Nop>
    " set termguicolors
endif
" }}}1

" Undo options
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Edit files in the same directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" Integrate with system clipboard
set clipboard=unnamedplus,unnamed

" Set working directory to the current file
" set autochdir

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Open markdown *scratch*
map <leader>x :e ~/Org/buffer.md<CR>

" {{{1 Misc keybinds
set timeoutlen=500
inoremap jj <Esc>
nnoremap <A-h> :noh<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Insert newline without entering insert mode
nmap zj o<Esc>k
nmap zk O<Esc>j

" Reload vimrc
nnoremap <leader>rr :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Free <F1>
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>

" Search visually selected
vnoremap // y/<C-R>"<CR>

" Keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

" Make C-S work as `Save`
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>i

" Disable annoying arrows
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Fix some common typos
:command! W w
:command! Q q
:command! E e
" }}}1

" Suppress auto-pairs bind
let g:AutoPairsShortcutToggle = ''

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=1

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" wildmenu: command line completion
set wildmenu
set wildmode=longest,list

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>

" {{{1 Switch between relative and absolute lines numering
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction
nnoremap <F9> :call NumberToggle()<CR>
" }}}1

" {{{1 Folding settings
set foldmethod=syntax
set foldnestmax=6
set nofoldenable " disable folding when open file
set foldlevel=2

" {{{2 Foldcolumn behaviour
set foldcolumn=0
function! ToggleFoldColumn()
    if(&foldcolumn != 0)
        set foldcolumn=0
    else
        set foldcolumn=3
    endif
endfunction
nnoremap <leader>q :call ToggleFoldColumn()<CR>
" }}}2
" }}}1

" E45: 'readonly' option is set (add ! to override)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Create directories before write
function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
endfunction
command! Mkw call WriteCreatingDirs()

" {{{1 Nerdcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDRemoveExtraSpaces = 1
let g:NERDCompactSexyComs = 1
let g:NERDCommentEmptyLines = 1
let g:NERDAltDelims_c = 1
" Commenting by <C-/> like Intellij
if has('win32')
    nmap <C-/> <leader>c<Space>
    vmap <C-/> <leader>c<Space>
else
    nmap <C-_> <leader>c<Space>
    vmap <C-_> <leader>c<Space>
endif
" }}}1

" {{{1 Multiple cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<A-i>'
let g:multi_cursor_select_all_word_key = '<A-u>'
" let g:multi_cursor_start_key           = 'g<C-n>'
" let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<A-i>'
let g:multi_cursor_prev_key            = '<A-o>'
let g:multi_cursor_skip_key            = '<A-q>'
let g:multi_cursor_quit_key            = '<Esc>'
" }}}1

" Browse files
map <A-1> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" {{{1 Easymotion
" Note: Use <C-o><cmd> in insert mode.
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <A-;> <Plug>(easymotion-overwin-f)
map <A-l> <Plug>(easymotion-overwin-line)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3` & `#`)
let g:EasyMotion_use_smartsign_us = 1
" }}}1

"{{{1 FZF settings
let $FZF_DEFAULT_OPTS .= ' --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-c:cancel'
let g:fzf_history_dir = '~/.local/share/fzf-history'
" Search vim keybinds
nmap <A-z> <plug>(fzf-maps-n)
xmap <A-z> <plug>(fzf-maps-x)
omap <A-z> <plug>(fzf-maps-o)
" Vim commands
nnoremap <A-x> :Commands<CR>
" List bookmarks
nnoremap <leader>m :Marks<CR>
" Files from current directory
nnoremap <A-p> :Files<CR>
" Ag search
nnoremap <leader>fs :Ag<CR>
" Search from tags in directory
nnoremap <leader>ft :Tags<CR>
" Tags from a current file
nnoremap <A-7> :BTags<CR>
nnoremap <F7> :TagbarToggle<CR>
" Commit messages search
nnoremap <leader>vc :Commits<CR>
" Staging files search
nnoremap <leader>vs :GFiles?<CR>
" List openned buffers
nnoremap <A-b> :Buffers<CR>
" List openned windows
nnoremap <leader>wl :Windows<CR>
" }}}1

" Default identation settings
set tabstop=4
set shiftwidth=4
set expandtab  " on pressing tab insert 4 spaces
autocmd Filetype css setlocal tabstop=4
autocmd Filetype html setlocal tabstop=4

" 79+ characters line highlight
highlight ColorColumn ctermbg=236
" call matchadd('ColorColumn', '\%79v', 100)
set colorcolumn=79

" {{{1 Trailing whitespaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
" Highlight
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Remove all trailing whitespaces
nnoremap <silent> <Leader>es :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" }}}1

" Highlight search results incrementally
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Apply kernel settings
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

" ctags
set tags=./tags;
let g:ctags_statusline=1

" {{{1 C/C++ settings
autocmd bufreadpre *.c setlocal textwidth=79
autocmd bufreadpre *.cpp setlocal textwidth=79
autocmd bufreadpre *.h setlocal textwidth=79
autocmd bufreadpre *.h set filetype=c
nmap <A-a> :A<CR>
" }}}1

" {{{1 Golang mode settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>r <plug>(go-run)
au FileType go nmap <leader>d <plug>(go-doc)
au FileType go nmap <leader>f <plug>(go-fmt)
" }}}1

" {{{1 Python settings
"let g:python_highlight_all = 1
"let g:python_highlight_space_errors=0

" Fix imports order
autocmd FileType python nnoremap <Leader>ei :!isort %<CR><CR>

let g:pymode_python = 'python3'
" }}}1

" Markdown {{{1
let vim_markdown_preview_github=0
let vim_markdown_preview_hotkey='<leader>m'
let vim_markdown_preview_browser='Chromium'

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'go']
let g:markdown_folding = 1

" Used as '$x^2$', '$$x^2$$', escapable as '\$x\$' and '\$\$x\$\$'
let g:vim_markdown_math = 1

nnoremap <leader>mt :Toch<CR>
" }}}1

" MatIEC configuration
let matiec_path = '/home/jubnzv/Dev/Beremiz/matiec/'
let matiec_mkbuilddir = 1

" {{{1 deoplete autocomplition
let g:deoplete#enable_at_startup = 1

" Set sources
" FIXME:
" let g:deoplete#sources = {}
" let g:deoplete#sources.c = ['LanguageClient']
" let g:deoplete#sources.cpp = ['LanguageClient']
" let g:deoplete#sources.python = ['LanguageClient']
" let g:deoplete#sources.python3 = ['LanguageClient']
" let g:deoplete#sources#go = ['vim-go']
" let g:deoplete#sources.vim = ['vim']

" Keybindings
inoremap <expr><A-q> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <expr><A-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><A-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}1

" {{{1 LSP settings
let g:LanguageClient_serverCommands = {
    \ 'python': ['/usr/local/bin/pyls', '--log-file=/tmp/pyls.log'],
    \ 'cpp': ['/usr/local/bin/cquery', '--log-file=/tmp/cq.log'],
    \ 'c': ['/usr/local/bin/cquery', '--log-file=/tmp/cq.log'],
    \ }
let g:LanguageClient_rootMarkers = {
    \ 'cpp': ['compile_commands.json', 'build'],
    \ 'c': ['compile_commands.json', 'build'],
    \ }
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'

" Keybindings
nnoremap ]e :cnext <CR>
nnoremap [e :cprevious<CR>
nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
" Symbol definition, similar to C-]
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" Symbol implementation
nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <M-,> :call LanguageClient_textDocument_references()<cr>
" All available symbols from curent project
nnoremap <silent> gs :call LanguageClient#workspace_symbol()<CR>

" {{{2 Diagnostic messages / linting
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_diagnosticsDisplay = {
    \   1: {
    \       "name": "Error",
    \       "texthl": "ALEError",
    \       "signText": ">>",
    \       "signTexthl": "ALEErrorSign",
    \   },
    \   2: {
    \       "name": "Warning",
    \       "texthl": "ALEWarning",
    \       "signText": "--",
    \       "signTexthl": "ALEWarningSign",
    \   },
    \   3: {
    \       "name": "Information",
    \       "texthl": "ALEInfo",
    \       "signText": "?i",
    \       "signTexthl": "ALEInfoSign",
    \   },
    \   4: {
    \       "name": "Hint",
    \       "texthl": "ALEInfo",
    \       "signText": "?h",
    \       "signTexthl": "ALEInfoSign",
    \   },}
" }}}2
" }}}1

" {{{1 Datetime options
" language time C
nnoremap <C-c>. "=strftime("%Y-%m-%d")<CR>P
inoremap <C-c>. <C-R>=strftime("%Y-%m-%d")<CR>
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
" }}}1

" {{{1 Doxygen
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"
autocmd FileType c nnoremap <leader>d :Dox<CR>
"}}}1

" Git workflow
let g:gitgutter_map_keys = 0
nmap [v <Plug>GitGutterPrevHunk
nmap ]v <Plug>GitGutterNextHunk
nnoremap <leader>vv :GitGutterPreviewHunk<CR>
nnoremap <leader>vu :GitGutterUndoHunk<CR>

" {{{1 Sphinx & RST
let g:riv_fold_auto_update = 0 " Disable auto-folding on `:w`

autocmd FileType rst setlocal sw=2 ts=2 expandtab
autocmd FileType rst setlocal textwidth=79
" }}}1

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_ru<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_ru<CR>

" vim: foldmethod=marker sw=4
