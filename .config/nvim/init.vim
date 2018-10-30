set nocompatible
let mapleader = "\<Space>"
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" {{{1 Plugins
call plug#begin('~/.local/share/nvim/plugged')

" {{{2 General
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/kshenoy/vim-signature'          " Extended marks support
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/lyokha/vim-xkbswitch'           " ru-RU key bindings in normal mode
Plug 'https://github.com/rhysd/clever-f.vim'             " Convenient `f` and `F`
Plug 'https://github.com/junegunn/vim-peekaboo'          " Shows vim registers content
" Plug 'https://github.com/christoomey/vim-tmux-navigator'
" Plug 'https://github.com/benmills/vimux'
Plug 'https://github.com/junegunn/fzf.vim'               " Fuzzy-finder integration
Plug 'https://github.com/tpope/vim-speeddating'          " <C-a>/<C-x> for dates and timestamps
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
Plug 'https://github.com/jubnzv/vim-cursorword'    " Highlight word under cursor
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

" {{{ General

" Scrolling options
set scrolloff=7     " 7 lines above/below cursor when scrolling
set scroll=7        " Number of lines scrolled by <C-u> and <C-d>

" Save global marks for up to 1000 files
set viminfo='1000,f1

" Don't parse modelines on temporary paths (google: "vim modeline vulnerability").
function! ParseModeline()
  let l:path = expand('%:p')
  if l:path =~ '/tmp' || l:path =~ '~/Downloads'
    setlocal nomodeline
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call ParseModeline()

" Use dash as word separator.
set iskeyword+=-

" Remove delay between complex keybindings.
" It also required for `vim-which-key` plugin.
set notimeout

" Undo options
set undofile
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000

" Edit files in the same directory
cabbr %% <C-R>=expand('%:p:h')<CR>

" Integrate with system clipboard
set clipboard=unnamedplus,unnamed

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=1

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" wildmenu: command line completion
set wildmenu
set wildmode=longest,list

" Time in milliseconds to wait for a mapped sequence to complete.
set timeoutlen=500

" Jump to the last position when reopening a file (see `/etc/vim/vimrc`)
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Set working directory to the current file
" set autochdir

" Autoindent when starting new line, or using o or O.
" set autoindent

" Reload unchanged files automatically.
" set autoread
" }}}

" {{{ General keybindings

" {{{2 Common
"
" Binds that changes default vim behavior, separated from plugins
" configuration.
"
inoremap jj <Esc>
nnoremap <A-h> :noh<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Insert newline without entering insert mode
nmap zj o<Esc>k
nmap zk O<Esc>j

" Emacs-like binds in command more
cmap <C-p> <Up>
cmap <C-n> <Down>
cmap <C-b> <Left>
cmap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-h> <BS>
cnoremap <C-k> <C-f>D<C-c><C-c>:<Up>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

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

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<CR>

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

" E45: 'readonly' option is set (add ! to override)
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Create directories before write
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
endfunction
command! Mkw call WriteCreatingDirs()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>em mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Open markdown *scratch*
map <leader>x :e ~/Org/buffer.md<CR>

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_ru<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_ru<CR>

" }}}2

" Highlight search results incrementally (haya14busa/incsearch.vim)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Suppress auto-pairs bind
let g:AutoPairsShortcutToggle = ''

" }}}

" {{{1 UI and appearance
set guioptions-=m  " Remove menu bar
set guioptions-=T  " Remove toolbar
set guioptions-=r  " Remove right-hand scroll bar
set guioptions-=L  " Remove left-hand scroll bar

" Don't display the intro message on starting Vim.
set shortmess+=I

set relativenumber
set cursorline
set laststatus=2   " Always show status line
set title          " Show window title
set signcolumn=yes
set background=dark
set t_Co=256       " 256-colors mode

" Cursor style
set guicursor+=c-ci-cr:block

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
hi ColorColumn ctermbg=236
hi Todo ctermfg=130 guibg=#af3a03

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

" {{{2 Switch between relative and absolute lines numbering
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
" }}}2

" {{{2 Goyo & Limelight settings
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
" }}}2

" }}}1

" {{{ Make normal mode compatible with ru keymap
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set keymap=russian-jcukenwin
let g:XkbSwitchLib = "/usr/local/lib/libxkbswitch.so"
" echo libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')
" call libcall(g:XkbSwitchLib, 'Xkb_Switch_setXkbLayout', 'us')
let g:XkbSwitchEnabled = 0
let g:XkbSwitchLoadRIMappings = 0
let g:XkbSwitchIMappings = ['ru']
" }}}

" {{{ Buffers/windows manipulation routines
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
" }}}

" {{{ tmux integration
if exists('$TMUX')
  map ` <Nop>
endif
" }}}

" {{{ Folding settings
set foldmethod=syntax
set foldnestmax=6
set nofoldenable " Disable folding when open file
set foldlevel=2
set foldcolumn=0
set fillchars=fold:\ 

" Customized `CustomFoldText` function:
" http://www.gregsexton.org/2011/03/improving-the-text-displayed-in-a-fold/
function! CustomFoldText()
  let fs = v:foldstart
  while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
  endwhile
  if fs > v:foldend
    let line = getline(v:foldstart)
  else
    let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
  endif

  let w = &l:textwidth - 3 - &foldcolumn - (&number ? 8 : 0)
  let foldSize = 1 + v:foldend - v:foldstart
  let foldLevelStr = string(v:foldlevel) . ""
  let lineCount = line("$")
  let foldSizeStr = printf("[" . foldSize . " lines | %.1f", (foldSize*1.0)/lineCount*100) . "%] "
  let expansionString = " " . repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return line . expansionString . foldSizeStr . foldLevelStr
endf
set foldtext=CustomFoldText()

function! ToggleFoldColumn()
  if(&foldcolumn != 0)
    set foldcolumn=0
  else
    set foldcolumn=3
  endif
endfunction
nnoremap <leader>q :call ToggleFoldColumn()<CR>
" }}}

" {{{ conceal
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
" }}}

" {{{ Default indentation settings
set tabstop=4
set shiftwidth=4
set expandtab  " On pressing tab insert 4 spaces
" }}}

" {{{ Browse files
map <A-1> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=[
  \ ".*\\.class$",
  \ ".*\\.o$",
  \ ".*\\.pyc$",
  \ ]
" }}}

" {{{ Datetime
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
" }}}

" {{{ Easymotion
" Note: Use <C-o><cmd> in insert mode.
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <A-;> <Plug>(easymotion-overwin-f)
map <A-l> <Plug>(easymotion-overwin-line)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3` & `#`)
let g:EasyMotion_use_smartsign_us = 1
" }}}

" {{{ FZF
let $FZF_DEFAULT_OPTS .= ' --bind alt-k:up,alt-j:down,alt-p:previous-history,alt-n:next-history,alt-m:accept,alt-q:cancel'
let g:fzf_history_dir = '~/.local/share/fzf-history'

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

nmap <A-z> <plug>(fzf-maps-n)
xmap <A-z> <plug>(fzf-maps-x)
omap <A-z> <plug>(fzf-maps-o)
nnoremap <A-x> :Commands<CR>
" nnoremap <leader>m :Marks<CR>
nnoremap <A-p> :Files<CR>
" Note: rg version should be >= 1.10 (colored I/O fix)
nnoremap <leader>fs :Rg<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <A-7> :BTags<CR>
nnoremap <leader>vc :Commits<CR>
nnoremap <leader>vs :GFiles?<CR>
nnoremap <A-b> :Buffers<CR>
nnoremap <leader>wl :Windows<CR>
" }}}

" {{{ Nerdcommenter settings
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
" }}}

" {{{ 80+ characters line highlight
function! s:SetColorColumn()
  if &textwidth == 0
    setlocal colorcolumn=80
  else
    setlocal colorcolumn=+0
  endif
endfunction

augroup colorcolumn
  autocmd!
  autocmd OptionSet textwidth call s:SetColorColumn()
  autocmd BufEnter * call s:SetColorColumn()
augroup end
" }}}

" {{{ Trailing whitespaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Remove all trailing whitespaces
nnoremap <silent> <Leader>es :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" }}}

" {{{ ctags
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
nnoremap <F7> :TagbarToggle<CR>
" }}}

" {{{ deoplete
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
" }}}

" {{{1 LSP settings
let g:LanguageClient_serverCommands = {
  \ 'python': ['/usr/local/bin/pyls', '--log-file=/tmp/pyls.log'],
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
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

nnoremap ]e :cnext <CR>
nnoremap [e :cprevious<CR>
nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> <M-,> :call LanguageClient_textDocument_references()<cr>
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
command! LSPToggle call LSPToggle()
" }}}1

" {{{ Doxygen
" Disable syntax highlighting provided by default plugin
let g:load_doxygen_syntax=0

" Configure DoxygenToolchain
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"
autocmd FileType c nnoremap <leader>d :Dox<CR>
"}}}

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>GitGutterPrevHunk
nmap ]v <Plug>GitGutterNextHunk
nnoremap <leader>vv :GitGutterPreviewHunk<CR>
nnoremap <leader>vu :GitGutterUndoHunk<CR>
" }}}

" {{{ C/C++ settings
autocmd bufreadpre *.c setlocal textwidth=80
autocmd bufreadpre *.cpp setlocal textwidth=80
autocmd bufreadpre *.h setlocal textwidth=80
autocmd bufreadpre *.h set filetype=c
nmap <A-a> :A<CR>

" Apply Linux Kernel settings
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]
" }}}

" {{{ Golang settings
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <leader>r <plug>(go-run)
au FileType go nmap <leader>d <plug>(go-doc)
au FileType go nmap <leader>f <plug>(go-fmt)
" }}}

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

" {{{ vimscript
let g:vim_indent_cont = 2
autocmd FileType vim setlocal sw=4 ts=4 expandtab
autocmd FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
" }}}

" {{{ HTML & CSS
autocmd Filetype css setlocal ts=4
autocmd Filetype html setlocal ts=4
" }}}

" {{{ IEC611-31
let matiec_path = '/home/jubnzv/Dev/Beremiz/matiec/'
let matiec_mkbuilddir = 1
" }}}

" {{{ reStructuredText and sphinx
autocmd FileType rst setlocal sw=4 ts=4 expandtab
autocmd FileType rst setlocal textwidth=80
autocmd Filetype rst setlocal foldmethod=syntax

" Disable auto-folding on `:w`
let g:riv_fold_auto_update=0

" The position of fold info
let g:riv_fold_info_pos='left'
" }}}

" {{{ Markdown
let vim_markdown_preview_github=0
let vim_markdown_preview_hotkey='<leader>mp'
let vim_markdown_preview_browser='Chromium'

autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'go', 'rust']
let g:markdown_folding = 1

" Used as '$x^2$', '$$x^2$$', escapable as '\$x\$' and '\$\$x\$\$'
let g:vim_markdown_math = 1
" }}}

" {{{ File triggers
" buildbot configuration files
au BufNewFile,BufRead   master.cfg      set ft=python foldmethod=marker foldenable tw=120
au BufNewFile,BufRead   buildbot.tac    set ft=python foldmethod=marker foldenable tw=120
" }}}

" {{{ which-key: redundant long keybindinds with mnemonics.
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
  \ 'p' : ['GitGutterPreviewHunk'     , 'preview'],
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
" }}}

" vim:foldmethod=marker:foldenable:sw=2:tw=100
