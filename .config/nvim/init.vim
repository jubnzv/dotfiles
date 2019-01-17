" TODO:
" * Alternative C keymap when LSP is off
" * Try https://github.com/neoclide/coc.nvim instead deoplete + LanguageClient
" * ccls language server: https://github.com/MaskRay/ccls
" * Rust: `cargo doc` integration
" * Tmux splits support

set nocompatible
let mapleader = "\<Space>"
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
let g:python3_host_prog  = '/usr/bin/python3.6'

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

" {{{ Common: motion, navigation, extended commands
Plug 'https://github.com/scrooloose/nerdtree'       " A tree explorer plugin for vim
Plug 'https://github.com/kshenoy/vim-signature'     " Extended marks support
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/rhysd/clever-f.vim'        " Convenient `f` and `F`
Plug 'https://github.com/tpope/vim-eunuch'          " Helpers for Shell
Plug 'https://github.com/tpope/vim-speeddating'     " <C-a>/<C-x> for dates and timestamps
Plug 'https://github.com/tpope/vim-repeat'          " Remap `.` in a way that plugins can tap into it
Plug 'https://github.com/will133/vim-dirdiff'       " Diff two directories
Plug 'https://github.com/andymass/vim-matchup'      " Better `%` for some modes
Plug 'https://github.com/godlygeek/tabular'         " Vim script for text filtering and alignment
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'      " Insert or delete brackets, parens, quotes in pair
Plug 'https://github.com/tpope/vim-rsi'             " Readline (emacs) keybindings in command and insert modes
" }}}

" {{{ UI & appearance
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/jubnzv/gruvbox'           " Color scheme
Plug 'https://github.com/chrisbra/Colorizer'       " Colorize color names and codes
Plug 'https://github.com/junegunn/vim-peekaboo'    " Shows vim registers content into vertical split
Plug 'https://github.com/Yggdroot/indentLine'      " Show indentation as vertical lines
Plug 'https://github.com/haya14busa/incsearch.vim' " Incrementally highlight search results
Plug 'https://github.com/liuchengxu/vim-which-key' " Display available keybindings in popup
Plug 'https://github.com/jubnzv/vim-cursorword'    " Highlight word under cursor
" }}}

" {{{ Git
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/junegunn/gv.vim'
Plug 'https://github.com/sodapopcan/vim-twiggy'         " Git branch management
" }}}

" {{{ fzf
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/junegunn/fzf', {
  \ 'dir': '~/.local/opt/fzf',
  \ 'do': './install --all'
  \ }
" }}}

" {{{ Writing text/configuration/markdown
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/cespare/vim-toml'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/lervag/vimtex'
Plug 'https://github.com/plasticboy/vim-markdown'
" Plug 'https://github.com/gu-fan/riv.vim'
Plug 'https://github.com/othree/xml.vim', { 'for': [ 'xml', 'html' ] }
" }}}

" {{{ Writing code
Plug 'https://github.com/majutsushi/tagbar'            " Vim plugin that displays tags in a window
Plug 'https://github.com/ludovicchabant/vim-gutentags' " Auto (re)generate tag files
Plug 'https://github.com/terryma/vim-expand-region'    " Visually select increasingly larger regions of text
Plug 'https://github.com/Shougo/echodoc.vim'           " Displays function signatures from completions in the command line
Plug 'https://github.com/scrooloose/nerdcommenter'
Plug 'https://github.com/Shougo/neosnippet.vim'
Plug 'https://github.com/Shougo/neosnippet-snippets'
Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'https://github.com/jubnzv/DoxygenToolkit.vim'
Plug 'https://github.com/vivien/vim-linux-coding-style'
Plug 'https://github.com/nacitar/a.vim'
Plug 'https://github.com/raimon49/requirements.txt.vim', { 'for': 'requirements' }
Plug 'https://github.com/fatih/vim-go', { 'for': 'go' }
Plug 'https://github.com/alfredodeza/pytest.vim', { 'for': 'python' }
Plug 'https://github.com/tpope/vim-scriptease'
Plug '~/Dev/IEC.vim'
" }}}

call plug#end()
" }}}

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
set t_Co=256                                " 256-colors mode
set guicursor+=c-ci-cr:block                " Cursor style

" Italic symbols in terminal
set t_ZH=^[[3m
set t_ZR=^[[23m

" Gruvbox configuration
let g:gruvbox_sign_column='bg0'
let g:gruvbox_color_column='bg0'
let g:gruvbox_number_column='bg0'
colorscheme gruvbox

" Highlighting
hi CursorLine ctermbg=236
hi CursorLineNr ctermbg=236
hi ColorColumn ctermbg=236
hi Todo ctermfg=130 guibg=#af3a03
" }}}

" {{{ Common functions and commands

" Don't parse modelines on temporary paths (google: "vim modeline vulnerability").
function! ParseModeline()
  let l:path = expand('%:p')
  if l:path =~ '/tmp' || l:path =~ '~/Downloads'
    setlocal nomodeline
  endif
endfunction
au! BufReadPost,BufNewFile * call ParseModeline()

" Jump to the last position when reopening a file (see `/etc/vim/vimrc`)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

" {{{ Keybindings

" {{{ Common
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

" Reload vimrc
nnoremap <leader>R :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Free <F1>
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>

" Disable the ever-annoying Ex mode shortcut key
nnoremap Q @@

" Navigate to errors list
nnoremap ]e :cnext <CR>
nnoremap [e :cprevious<CR>

" Search visually selected text
vnoremap // y/<C-R>"<CR>

" Search in visal selected area
vnoremap <M-/> <Esc>/\%V

" Replace with `F` / `f` / `t` / `T`
noremap ;; :%s///g<Left><Left><Left>
noremap ;' :%s///cg<Left><Left><Left><Left>

" Keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

nmap <leader>xc :q<CR>

" Save buffer
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>i
nmap <leader>xs :w<CR>

" Fix common typos
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

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_yo<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_yo<CR>
" }}}

nnoremap <silent>gb :bn<CR>
nnoremap <silent>gB :bp<CR>

" Editing neighbors
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Refresh current buffer content
nnoremap <leader>B :checktime<CR>

function! BufferClose()
  if (tabpagenr('$') == 1 && winnr() == 1 && len(expand('%'))==0 && len(getbufinfo({'buflisted':1})) == 1)
    exec ':q'
  else
    exec ':bd'
  endif
endfunction
nnoremap <C-F4> :call BufferClose()<CR>
nnoremap <leader>xk :call BufferClose()<CR>

" Switch between current and last buffer
nnoremap <A-r> <C-^>

" {{{ Copy file path to system clipboard
if has('win32')
  nmap <silent> <leader>cr :let @+=substitute(expand("%"), "/", "\\", "g")<CR>:echo "Copied: " . expand("%")<CR>
  nmap <silent> <leader>ca :let @+=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo "Copied: " . expand("%:p")<CR>
else
  nmap <silent> <leader>cr :let @+=expand("%")<CR>:echo "Copied: " . expand("%")<CR>
  nmap <silent> <leader>ca :let @+=expand("%:p")<CR>:echo "Copied: " . expand("%:p")<CR>
endif
" }}}

" Highlight search results incrementally (haya14busa/incsearch.vim)
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Tabularize
cnoreabbrev Tab Tabularize
" }}}

" {{{ Lightline
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
" }}}

" {{{ neovim's terminal configuration
" Close terminal buffer after exit from shell process.
" https://www.reddit.com/r/neovim/comments/7xonzm/how_to_close_a_terminal_buffer_automatically_if/dud0vxn
function! OnTermClose()
    try
        $;?.
    catch
        return
    endtry
    if match(getline('.'), 'make: \*\*\* \[[^\]]\+] Error ') == -1
        call feedkeys('\<CR>')
    endif
endfunction

" Terminal-mode keybinds
tnoremap <C-v><Esc> <C-\><C-n>
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <A-y> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Highlight unfocused cursor
highlight TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=96 guibg=#8f3f71 cterm=NONE gui=NONE

augroup Term
    autocmd!
    au TermOpen * startinsert
    au TermClose * silent call OnTermClose()
augroup END
" }}}

" {{{ tmux integration
if exists('$TMUX')
  map ` <Nop>
endif
" }}}

" {{{ Parens settings
" Suppress auto-pairs bind
let g:AutoPairsShortcutToggle = ''

" Free statusline from Matchup
let g:matchup_matchparen_status_offscreen=0

" Insert fold block
let g:surround_102 = split(&commentstring, '%s')[0] . " {{{ \r " . split(&commentstring, '%s')[0] . " }}}"
" }}}

" {{{ Folding settings

" {{{ Folding options
set foldmethod=syntax
set foldnestmax=6
set nofoldenable                            " Disable folding when open file
set foldlevel=2
set foldcolumn=0
set fillchars=fold:\
" }}}

" {{{ Customized `CustomFoldText` function:
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
  let foldLevelStr = "" . string(v:foldlevel)
  let lineCount = line("$")
  let foldSizeStr = printf("[%4dL|%4.1f%%]", foldSize, (foldSize*1.0)/lineCount*100)
  let expansionString = " " . repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return  line . expansionString . foldLevelStr . " " . foldSizeStr
endf
set foldtext=CustomFoldText()
" }}}
" }}}

" {{{ NerdTREE
map <A-1> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=[
  \ ".*\\.class$",
  \ ".*\\.o$",
  \ ".*\\.pyc$",
  \ "depcomp$",
  \ "install-sh$",
  \ ]
" }}}

" {{{ Datetime
" language time C
nnoremap <leader>c. "=strftime("%Y-%m-%d")<CR>P
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
au BufWritePre * call LastModified()
" }}}

" {{{ Easymotion
" Note: Use <C-o><cmd> in insert mode.
let g:EasyMotion_do_mapping = 0                     " Disable default mappings
let g:EasyMotion_smartcase = 1                      " Turn on case insensitive feature
let g:EasyMotion_use_smartsign_us = 1               " Smartsign (type `3` and match `3` & `#`)
map <A-;> <Plug>(easymotion-overwin-f)
" }}}

" {{{ FZF
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Pass raw arguments directly to ag command
command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Recently used files
command! FZFMru call fzf#run({
\  'source':  v:oldfiles,
\  'sink':    'e',
\  'options': '-m -x +s',
\  'down':    '40%'})

function! s:all_files()
return extend(
\ filter(copy(v:oldfiles),
\        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
\ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

" Augmenting Ag command using fzf#vim#with_preview function
" :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
" :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, '--path-to-ignore ~/.ignore',
\                 <bang>0 ? fzf#vim#with_preview('up:60%')
\                         : fzf#vim#with_preview('right:50%', '?'),
\                 <bang>0)

nmap <A-z> <plug>(fzf-maps-n)
xmap <A-z> <plug>(fzf-maps-x)
omap <A-z> <plug>(fzf-maps-o)
nnoremap <A-x> :Commands<CR>
nnoremap <leader>fs :Ag<CR>
nnoremap <Leader>fw :Ag<Space><C-r><C-w><CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <A-7> :BTags<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>vc :Commits<CR>
nnoremap <leader>vs :GFiles?<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>er :FZFMru <CR>

nnoremap <leader>xf :Files<CR>

autocmd FileType fzf tnoremap <buffer> <Esc> <c-g>
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
  au!
  au OptionSet textwidth call s:SetColorColumn()
  au BufEnter * call s:SetColorColumn()
augroup end
" }}}

" {{{ Trailing whitespaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Remove all trailing whitespaces
nnoremap <silent> <Leader>Es :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>
" }}}

" Convert the ^M linebreak to 'normal' linebreaks
nnoremap <silent> <Leader>El :set ff=unix<CR> :e ++ff=dos<CR>

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
inoremap <expr><A-l> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><A-o> deoplete#mappings#manual_complete()

call deoplete#custom#source('_',
  \ 'matchers', ['matcher_full_fuzzy'])
call deoplete#custom#source('LanguageClient',
  \ 'min_pattern_length',
  \ 2)

set completeopt+=preview
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}

" {{{ Snippets configuration
imap <A-l> <Plug>(neosnippet_expand_or_jump)
smap <A-l> <Plug>(neosnippet_expand_or_jump)
xmap <A-l> <Plug>(neosnippet_expand_target)

" If your snippets trigger are same with builtin snippets, your snippets overwrite them.
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
" }}}

" {{{ LanguageClient settings
" let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_autoStart = 1
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
let g:LanguageClient_serverCommands = {
  \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'nightly', 'rls'],
  \ 'cpp': ['/usr/local/bin/cquery', '--log-file=/tmp/cquery.log'],
  \ 'c': ['/usr/local/bin/cquery', '--log-file=/tmp/cquery.log'],
  \ }
let g:LanguageClient_rootMarkers = {
  \ 'cpp': ['compile_commands.json', 'build'],
  \ 'c': ['compile_commands.json', 'build'],
  \ }

let g:LanguageClient_waitOutputTimeout = 5
" let g:LanguageClient_hoverPreview = "Never"

" There are some problems with LC cquery autosuggestions expanding when using neosnippet:
" https://github.com/autozimu/LanguageClient-neovim/issues/379
" https://github.com/Shougo/deoplete.nvim/issues/724#issuecomment-381312149
let g:LanguageClient_hasSnippetSupport = 0

" FIXME: Can be broken with cquery on some projects: use default `gq` instead.
" set formatexpr=LanguageClient_textDocument_rangeFormatting()
set formatexpr=""

" {{{ Keybindings
" I keep it as separated function to use this hotkeys when LSP is not started, e.g. use ctags/cscope binds for goto
" definition / goto implementation in large C projects when LSP is slow.
function! LCKeymap()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
    nnoremap gD :only<bar>vsplit<cr>gd
    nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<cr>
    nnoremap <silent> K :call LanguageClient#textDocument_hover()<cr>
    nnoremap <silent> gm :call LanguageClient_contextMenu()<CR>
    nnoremap <silent> gr :call LanguageClient_textDocument_references()<cr>
    nnoremap <silent> gs :call LanguageClient#workspace_symbol()<cr>
    nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<cr>
  endif
endfunction
" }}}

" Suppress autostart for large codebases
function! LCDisableAutostart(ignored_paths)
  let l:path = expand('%:p')
  for ign_path in a:ignored_paths
    if l:path =~ ign_path
      let g:LanguageClient_autoStart = 0
      break
    endif
  endfor
endfunction

" {{{ Format options for LSP diagnostic messages in signcolumn
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
" }}}

" {{{ Functions to show LanguageClient status in modeline
augroup LanguageClient_config
  au!
  au User LanguageClientStarted call LSPUpdateStatus(1)
  au User LanguageClientStopped call LSPUpdateStatus(0)
augroup END
let g:lsp_status = 0
function! LSPUpdateStatus(status) abort
  let g:lsp_status = a:status
  call lightline#update()
endfunction
function! LightlineLSPStatus() abort
  return g:lsp_status == 1 ? 'Λ' : ''
endfunction
" }}}

" }}}

" {{{ Notekeeping
nnoremap <leader>oN :Files ~/Org/Notes/<CR>
nnoremap <leader>oB :Files ~/Idie/content/<CR>
nnoremap <leader>on :e ~/Org/Notes/
nnoremap <leader>os :e ~/Org/scratch.md<CR>
" }}}

" {{{ echodoc
let g:echodoc#enable_at_startup=1
let g:echodoc#enable_force_overwrite=1
let g:echodoc#type="echo"
" }}}

" {{{ Doxygen
" Enable syntax highlighting provided by default plugin
let g:load_doxygen_syntax=1

" Configure DoxygenToolchain
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"
au FileType c nnoremap <leader>d :Dox<CR>
"}}}

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nnoremap [v <Plug>GitGutterPrevHunk
nnoremap ]v <Plug>GitGutterNextHunk
" }}}

" {{{ C/C++ settings
au FileType c,cpp setlocal tw=80
au FileType c,cpp setlocal commentstring=//\ %s
au FileType c,cpp call LCDisableAutostart(['linux-', 'Kernel', 'Projects', 'Bugs', 'beremiz'])
au FileType c,cpp call LCKeymap()

" Use C filetype for headers by default
au BufReadPre,BufRead,BufNewFile *.h set filetype=c

" Switch between header and sources
nmap <A-a> :A<CR>

" clang include fixer
let g:clang_include_fixer_path = "clang-include-fixer-7"
au FileType c,cpp noremap <leader>Ei :pyf /usr/lib/llvm-7/share/clang/clang-include-fixer.py<cr>

" Apply Linux Kernel settings
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

" {{{ Rust settings
au FileType rust call LCKeymap()
" }}}

" {{{ Commands and binds
au FileType c call CmdC()
function! CmdC()
    " Clean debug prints from `prdbg` snippet
    command! CleanDebugPrints :g/\/\/\ prdbg$/d

    " `ag` in C sources
    command! -bang -nargs=* AgC call fzf#vim#ag(<q-args>, '-G \.c$', {'down': '~40%'})
    command! -bang -nargs=* AgH call fzf#vim#ag(<q-args>, '-G \.h$', {'down': '~40%'})
    command! -bang -nargs=* AgFileType call fzf#vim#ag(<q-args>, '--cc', {'down': '~40%'})
    nnoremap <leader>ff :AgFileType<CR>
endfunction
" }}}

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
au FileType python nnoremap <Leader>ei :!isort %<CR><CR>
au FileType python set tw=0
au FileType python set foldmethod=indent foldnestmax=2
au FileType python call LCKeymap()

" {{{ Commands and binds
au FileType python call CmdPy()
function! CmdPy()
    command! -bang -nargs=* AgFileType call fzf#vim#ag(<q-args>, '--python', {'down': '~40%'})
    nnoremap <leader>ff :AgFileType<CR>
endfunction
" }}}
" }}}

" {{{ vimscript
let g:vim_indent_cont = 2
au FileType vim setlocal sw=4 ts=4 expandtab
au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
au FileType vim nnore <silent><buffer> K <Esc>:help <C-R><C-W><CR>
au FileType help noremap <buffer> q :q<cr>
" }}}

" {{{ IEC611-31
let matiec_path = '/home/jubnzv/Dev/Beremiz/matiec/'
let matiec_mkbuilddir = 1
" }}}

" {{{ reStructuredText
au FileType rst setlocal sw=4 ts=4 expandtab
au FileType rst setlocal textwidth=80
au Filetype rst setlocal foldmethod=expr

" Disable auto-folding on `:w`
let g:riv_fold_auto_update=0

" The position of fold info
let g:riv_fold_info_pos='left'
" }}}

" {{{ Markdown
let vim_markdown_preview_github=0
let vim_markdown_preview_hotkey='<leader>mp'
let vim_markdown_preview_browser='Chromium'

let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'go', 'rust']

let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_folding_disabled = 0
let g:vim_markdown_conceal = 0
" Used as '$x^2$', '$$x^2$$', escapable as '\$x\$' and '\$\$x\$\$'
let g:vim_markdown_math = 1
let g:vim_markdown_new_list_item_indent = 0

au BufNewFile,BufReadPost *.md set filetype=markdown foldenable
" }}}

" {{{ Other files
au FileType conf set foldmethod=marker foldenable
au Filetype css setlocal ts=4
au Filetype html setlocal ts=4

" buildbot configuration files
au BufNewFile,BufRead   master.cfg      set ft=python foldmethod=marker foldenable tw=120
au BufNewFile,BufRead   buildbot.tac    set ft=python foldmethod=marker foldenable tw=120

au BufNewFile,BufRead   .pdbrc set ft=python

" Taskwarrior tasks (`task [id] edit`)
au BufRead *.task /Description:

" Always start on first line of git commit message
au FileType gitcommit call setpos('.', [0, 1, 1, 0])

au BufNewFile,BufRead .clang-format set ft=config
" }}}

" {{{ Toggling features
function! ToggleConceal()
  if (&conceallevel == 0)
    set conceallevel=2
    echo 'Enable conceal'
  else
    set conceallevel=0
    echo 'Disable conceal'
  endif
endfunction

function! ToggleNumber()
  if(&nu == 1)
    set nu!
    set rnu
  else
    set nornu
    set nu
  endif
endfunction

function! ToggleFoldColumn()
  if(&foldcolumn != 0)
    set foldcolumn=0
  else
    set foldcolumn=3
  endif
endfunction

function! Togglegjgk()
  if !exists("g:togglegjgk") || g:togglegjgk==0
    let g:togglegjgk=1
    nnoremap j gj
    nnoremap k gk
    nnoremap gk k
    nnoremap gj j
    echo 'Switch to gj/gk'
  else
    let g:togglegjgk=0
    nunmap j
    nunmap k
    nunmap gk
    nunmap gj
    echo 'Switch to j/k'
  endif
endfunction

function! ToggleLSP()
  if (g:lsp_status == 0)
    execute ":LanguageClientStart"
    let g:LanguageClient_autoStart = 1
    echo 'Enable LSP'
  else
    execute ":LanguageClientStop"
    let g:LanguageClient_autoStart = 0
    echo 'Disable LSP'
  endif
endfunction

nnoremap <leader>Tfc :call ToggleFoldColumn()<CR>
nnoremap <leader>Tc :call ToggleConceal()<CR>
nnoremap <leader>Tg :call Togglegjgk()<CR>
nnoremap <leader>TL :call ToggleLSP()<CR>
nnoremap <leader>Tp :setlocal paste!<CR>
nnoremap <leader>Tn :call ToggleNumber()<CR>
nnoremap <leader>TC :ColorToggle<CR>
" }}}

" Load redundant which-key bindings
source ~/.config/nvim/which-key.vim

" vim:foldmethod=marker:foldenable:sw=2:tw=120
