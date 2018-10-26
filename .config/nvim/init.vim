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
Plug 'https://github.com/lyokha/vim-xkbswitch'           " ru-RU key bindings in normal mode
Plug 'https://github.com/rhysd/clever-f.vim'             " Convenient `f` and `F`
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
Plug 'https://github.com/chrisbra/Colorizer'       " Colorize color names and codes
Plug 'https://github.com/Yggdroot/indentLine'      " Show indentation as vertical lines
Plug 'https://github.com/haya14busa/incsearch.vim' " Incrementally highlight search results
Plug 'https://github.com/junegunn/goyo.vim'        " `Zen-mode`
Plug 'https://github.com/junegunn/limelight.vim'   " Highlight current paragraph
Plug 'https://github.com/reedes/vim-pencil'        " Convenient settings for text editing
Plug 'https://github.com/liuchengxu/vim-which-key' " Display available keybindings in popup
Plug 'https://github.com/jubnzv/vim-cursorword'    " Underlines word under cursor
" }}}2

" {{{2 Text editing
Plug 'https://github.com/jubnzv/DoxygenToolkit.vim'     " Doxygen helper
Plug 'https://github.com/pearofducks/ansible-vim'       " Ansible format support
Plug 'https://github.com/cespare/vim-toml'              " .toml
Plug 'https://github.com/chr4/nginx.vim'                " Nginx configuration files
Plug 'https://github.com/othree/xml.vim'                " Extended XML/XSD features
Plug 'https://github.com/dhruvasagar/vim-table-mode'    " Simplifies plain text tables creation
Plug 'https://github.com/lervag/vimtex'                 " LaTeX support
Plug 'https://github.com/plasticboy/vim-markdown'       " Extended markdown support
Plug 'https://github.com/gu-fan/riv.vim'                " .rst notekeeping
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
Plug 'https://github.com/terryma/vim-expand-region'  " Visually select increasingly larger regions
Plug 'https://github.com/ludovicchabant/vim-gutentags'
Plug 'https://github.com/Shougo/neosnippet.vim'
Plug 'https://github.com/Shougo/neosnippet-snippets'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" {{{3 Language-specific
Plug 'https://github.com/vivien/vim-linux-coding-style' " Kernel C codestyle
Plug 'https://github.com/nvie/vim-flake8'               " flake8 integration
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
set title          " Show window title
set signcolumn=yes
set background=dark
set t_Co=256       " 256-colors mode

" Italic symbols in terminal
set t_ZH=^[[3m
set t_ZR=^[[23m

" Gruvbox configuration
let g:gruvbox_sign_column='bg0'
let g:gruvbox_color_column='bg0'
let g:gruvbox_number_column='bg0'
colorscheme gruvbox
hi CursorLine ctermbg=236
hi CursorLineNr ctermbg=236

" {{{2 Modeline | tabline
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left':  [ [ 'mode', 'paste' ],
    \              [ 'readonly', 'filename', 'modified' ],
    \              [ 'tagbar' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'lsp_status' ],
    \              [ 'fileformat', 'fileencoding', 'filetype' ],
    \              [ 'gitbranch' ] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head'
    \ },
    \ 'component': {
    \   'tagbar': '%{tagbar#currenttag("[%s]", "", "f")}',
    \ },
    \ 'component_expand': {
    \   'lsp_status': 'LightlineLSPStatus'
    \ },
    \ 'component_type': {
    \   'lsp_warnings': 'warning',
    \   'lsp_errors': 'error',
    \   'readonly': 'error'
    \ },
    \ }
let g:buftabline_indicators=1 " show modified
" }}}2

" }}}1

" {{{ Goyo & Limelight settings
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
" }}}

" Scrolling options
set scrolloff=7     " 7 lines above/below cursor when scrolling
set scroll=7        " Number of lines scrolled by C-u / C-d

" Save global marks for up to 1000 files
set viminfo='1000,f1

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

" Remove delay between complex keybinds. Required for `vim-which-key`.
set notimeout

" Jump to the last position when reopening a file (see `/etc/vim/vimrc`)
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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
nnoremap <C-x>1 :only<CR>
nnoremap <C-x>2 :split<CR>
nnoremap <C-x>3 :vsplit<CR>
nnoremap <C-x>o <C-w><C-w><CR>
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
nnoremap <leader>R :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Free <F1>
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>

" Search visually selected
vnoremap // y/<C-R>"<CR>

" Replace with `F` / `f` / `t` / `T`
noremap ;; :%s///g<Left><Left><Left>
noremap ;' :%s///cg<Left><Left><Left><Left>

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

" Toggle conceal options
fu! ToggleConceal()
  if (&conceallevel == 0)
    set conceallevel=2
    set concealcursor=niv
  else
    set conceallevel=0
    set concealcursor=auto
  endif
endfunction
command! ToggleConceal call ToggleConceal()

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
let $FZF_DEFAULT_OPTS .= ' --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel'

" Command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

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

" 80+ characters line highlight
highlight ColorColumn ctermbg=236
set colorcolumn=80

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

let g:tagbar_type_rust = {
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \'T:types,type definitions',
      \'f:functions,function definitions',
      \'g:enum,enumeration names',
      \'s:structure names',
      \'m:modules,module names',
      \'c:consts,static constants',
      \'t:traits',
      \'i:impls,trait implementations',
  \]
  \}

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

" {{{ Python settings
"let g:python_highlight_all = 1
"let g:python_highlight_space_errors=0
let g:pymode_python = 'python3'

" Fix imports order
autocmd FileType python nnoremap <Leader>ei :!isort %<CR><CR>

" flake8
let no_flake8_maps = 1
autocmd FileType python map <buffer> <F3> :call Flake8()<CR>
" }}}

"{{{ Markdown
let vim_markdown_preview_github=0
let vim_markdown_preview_hotkey='<leader>mp'
let vim_markdown_preview_browser='Chromium'

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'go']
let g:markdown_folding = 1

" Used as '$x^2$', '$$x^2$$', escapable as '\$x\$' and '\$\$x\$\$'
let g:vim_markdown_math = 1

nnoremap <leader>mt :Toch<CR>
" }}}

" MatIEC configuration
let matiec_path = '/home/jubnzv/Dev/Beremiz/matiec/'
let matiec_mkbuilddir = 1

" {{{ deoplete autocomplition setup
let g:deoplete#enable_at_startup = 1
inoremap <expr><A-q> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <expr><A-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><A-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><A-o> deoplete#mappings#manual_complete()
" }}}

" {{{ Snippets configuration
imap <A-l> <Plug>(neosnippet_expand_or_jump)
smap <A-l> <Plug>(neosnippet_expand_or_jump)
xmap <A-l> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <expr><TAB>
  \ pumvisible() ? "\<A-j>" :
  \ neosnippet#expandable_or_jumpable() ?
  \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}

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

" FIXME: Can be broken with cquery on some projects. Use default `gq`.
" set formatexpr=LanguageClient_textDocument_rangeFormatting()
set formatexpr=""

let g:LanguageClient_loadSettings = 1
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'

" Keybindings
nnoremap ]e :cnext <CR>
nnoremap [e :cprevious<CR>
" Show hover info
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

" Use something different for highlighting
let sign_column_color=synIDattr(hlID('SignColumn'), 'bg#')
execute "hi LSPError gui=undercurl cterm=underline term=underline guisp=red"
execute "hi LSPErrorText guifg=yellow ctermbg=red  ctermfg=" . sign_column_color . "guibg=" . sign_column_color
execute "hi LSPWarning gui=undercurl cterm=underline term=underline guisp=yellow"
execute "hi LSPWarningText guifg=yellow ctermfg=yellow ctermbg=" . sign_column_color . "guibg=" . sign_column_color
execute "hi LSPInfo gui=undercurl cterm=underline term=underline guisp=yellow"
execute "hi LSPInfoText guifg=yellow ctermfg=yellow ctermbg=" . sign_column_color . "guibg=" . sign_column_color

let g:LanguageClient_diagnosticsDisplay = {
    \   1: {
    \       "name": "Error",
    \       "texthl": "LSPError",
    \       "signText": "ee",
    \       "signTexthl": "LSPErrorText",
    \   },
    \   2: {
    \       "name": "Warning",
    \       "texthl": "LSPWarning",
    \       "signText": "ww",
    \       "signTexthl": "LSPWarningText",
    \   },
    \   3: {
    \       "name": "Information",
    \       "texthl": "LSPInfo",
    \       "signText": "ii",
    \       "signTexthl": "LSPInfoText",
    \   },
    \   4: {
    \       "name": "Hint",
    \       "texthl": "LSPInfo",
    \       "signText": "hh",
    \       "signTexthl": "LSPInfoText",
    \   },}
" }}}2

" {{{2 Functions to show LSP status in modeline
augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted call LSPUpdateStatus(1)
    autocmd User LanguageClientStopped call LSPUpdateStatus(0)
augroup END
let g:lsp_status = 0
function! LSPUpdateStatus(status) abort
    let g:lsp_status = a:status
    call lightline#update()
endfunction
function! LightlineLSPStatus() abort
  return g:lsp_status == 1 ? 'Λ' : ''
endfunction
" 2}}}

function! LSPToggle()
    if (g:lsp_status == 0)
        execute ":LanguageClientStart"
    else
        execute ":LanguageClientStop"
    endif
endfunction
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
" Disable syntax highlighting provided by default plugin
let g:load_doxygen_syntax=0

" Configure DoxygenToolchain
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"
autocmd FileType c nnoremap <leader>d :Dox<CR>
"}}}1

" Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0
nmap [v <Plug>GitGutterPrevHunk
nmap ]v <Plug>GitGutterNextHunk
nnoremap <leader>vv :GitGutterPreviewHunk<CR>
nnoremap <leader>vu :GitGutterUndoHunk<CR>

" Sphinx & RST
let g:riv_fold_auto_update = 0 " Disable auto-folding on `:w`
autocmd FileType rst setlocal sw=2 ts=2 expandtab
autocmd FileType rst setlocal textwidth=80

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_ru<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_ru<CR>

" {{{ File triggers
" buildbot configuration file
au BufNewFile,BufRead   master.cfg  set ft=python
" }}}

" {{{1 which-key: redundant long keybindinds with mnemonics.
" Use it only when forget shorter keybind.
"
" Define prefix dictionary
let g:which_key_map =  {}

let g:which_key_map.l = {
      \ 'name' : '+lsp',
      \ 'a' : ['LanguageClient_textDocument_codeAction()'     , 'action']           ,
      \ 't' : ['LSPToggle()'                                  , 'toggle']           ,
      \ 'f' : ['LanguageClient#textDocument_formatting()'     , 'formatting']       ,
      \ 'h' : ['LanguageClient#textDocument_hover()'          , 'hover']            ,
      \ 'r' : ['LanguageClient#textDocument_references()'     , 'references']       ,
      \ 'R' : ['LanguageClient#textDocument_rename()'         , 'rename']           ,
      \ 's' : ['LanguageClient#textDocument_documentSymbol()' , 'document-symbol']  ,
      \ 'S' : ['LanguageClient#workspace_symbol()'            , 'workspace-symbol'] ,
      \ 'g' : {
        \ 'name': '+goto',
        \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']       ,
        \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']  ,
        \ 'i' : ['LanguageClient#textDocument_implementation()'  , 'implementation']  ,
        \ },
      \ }

let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 'c' : ['Gcommit', 'commit'],
      \ 's' : ['Gstatus', 'status'],
      \ 'b' : ['Gblame', 'blame'],
      \ 'd' : ['Gdiff', 'diff'],
      \ 'f' : ['Gfetch', 'fetch'] ,
      \ 'p' : ['Gpull', 'pull'] ,
      \ 'P' : ['Gpush', 'pull'] ,
      \ 'r' : ['Grebase', 'rebase'] ,
      \ 'm' : ['Gmerge', 'merge'] ,
      \ 'D' : ['Gdelete', 'delete'],
      \ 'e' : ['Gedit', 'edit'] ,
      \ 'M' : ['Gmove', 'move'] ,
      \ 'g' : {
        \ 'name': '+Gutter',
        \ 'p' : ['GitGutterPreviewHunk'     , 'preview']       ,
        \ },
      \ }

let g:which_key_map.r = {
      \ 'name' : '+riv',
      \ 'i' : ['RivProjectIndex', 'index'],
      \ 'r' : ['RivReload', 'reload'],
      \ 't' : {
        \ 'name': '+title',
        \ '0' : ['RivTitle0', '0'],
        \ '1' : ['RivTitle1', '1'],
        \ '2' : ['RivTitle2', '2'],
        \ '3' : ['RivTitle3', '3'],
        \ '4' : ['RivTitle4', '4'],
        \ '5' : ['RivTitle5', '5'],
        \ '6' : ['RivTitle6', '6'],
        \ },
      \ 'o' : {
        \ 'name': '+todo',
        \ 'a' : ['RivTodoAsk', 'ask'],
        \ 'd' : ['RivTodoDate', 'date'],
        \ 'D' : ['RivTodoDel', 'delete'],
        \ 'p' : ['RivTodoPrior', 'priority'],
        \ 't' : ['RivTodoToggle', 'toggle'],
        \ 'u' : ['RivTodoUpdateCache', 'update'],
        \ '1' : ['RivTodoType1', 'type: [  ] '],
        \ '2' : ['RivTodoType2', 'type: TODO '],
        \ '3' : ['RivTodoType2', 'type: FIXME'],
        \ '4' : ['RivTodoType4', 'type: START'],
        \ },
      \ 'a' : {
        \ 'name': '+table',
        \ 'c' : ['RivTableCreate', 'create'],
        \ 'f' : ['RivTableFormat', 'format'],
        \ 'n' : ['RivTableNextCell', 'next cell'],
        \ 'p' : ['RivTablePrevCell', 'prev cell'],
        \ },
      \ 'l' : {
        \ 'name': '+list',
        \ 't' : ['RivListToggle', 'toggle'],
        \ 'd' : ['RivListDelete', 'delete'],
        \ 'n' : ['RivListNew', 'new'],
        \ 'b' : ['RivListSub', 'sub'],
        \ 'p' : ['RivListSup', 'sup'],
        \ '0' : ['RivListType0', 'type: * '],
        \ '1' : ['RivListType1', 'type: 1.'],
        \ '2' : ['RivListType2', 'type: a.'],
        \ '3' : ['RivListType3', 'type: A)'],
        \ '4' : ['RivListType4', 'type: i)'],
        \ },
      \ 'c' : {
        \ 'name': '+create',
        \ 'c' : ['RivCreateContent', 'content'],
        \ 'd' : ['RivCreateDate', 'date'],
        \ 'e' : ['RivCreateEmphasis', 'emphasis'],
        \ 'm' : ['RivCreateExplicitMark', 'mark'],
        \ 'f' : ['RivCreateFoot', 'foot'],
        \ 'g' : ['RivCreateGitLink', 'git link'],
        \ 'h' : ['RivCreateHyperLink', 'hyperlink'],
        \ 'i' : ['RivCreateInterpreted', 'interpreted'],
        \ 'l' : ['RivCreateLink', 'link'],
        \ 'B' : ['RivCreateLiteralBlock', 'code block'],
        \ 'I' : ['RivCreateLiteralInline', 'code inline'],
        \ 's' : ['RivCreateStrong', 'strong'],
        \ 't' : ['RivCreateTime', 'time'],
        \ 'T' : ['RivCreateTransition', 'transition'],
        \ },
      \ 'h' : {
        \ 'name': '+help',
        \ 'd' : ['RivDirectives', 'directives'],
        \ 'q' : ['RivQuickStart', 'quick start'],
        \ 'f' : ['RivHelpFile', 'file?'],
        \ 's' : ['RivHelpSection', 'section?'],
        \ 't' : ['RivHelpTodo', 'todo?'],
        \ 'p' : ['RivPrimer', 'primer'],
        \ 'S' : ['RivSpecification', 'specification'],
        \ 'i' : ['RivInstruction', 'instruction'],
        \ 'I' : ['RivIntro', 'intro'],
        \ },
      \ }

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
" 1}}}

" vim: foldmethod=marker sw=4
