set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
let g:python3_host_prog  = '/usr/bin/python3.6'

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/scrooloose/nerdtree'       " A tree explorer plugin for vim
Plug 'https://github.com/kshenoy/vim-signature'     " Extended marks support
Plug 'https://github.com/easymotion/vim-easymotion'
Plug 'https://github.com/rhysd/clever-f.vim'        " Convenient `f` and `F`
Plug 'https://github.com/tpope/vim-eunuch'          " Helpers for Shell
Plug 'https://github.com/lambdalisue/suda.vim'      " Read or write files with sudo command
Plug 'https://github.com/tpope/vim-speeddating'     " <C-a>/<C-x> for dates and timestamps
Plug 'https://github.com/tpope/vim-repeat'          " Remap `.` in a way that plugins can tap into it
Plug 'https://github.com/will133/vim-dirdiff'       " Diff two directories
Plug 'https://github.com/andymass/vim-matchup'      " Better `%` for some modes
Plug 'https://github.com/godlygeek/tabular'         " Vim script for text filtering and alignment
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/jiangmiao/auto-pairs'      " Insert or delete brackets, parens, quotes in pair
Plug 'https://github.com/tpope/vim-rsi'             " Readline (emacs) keybindings in command and insert modes
Plug 'https://github.com/osyo-manga/vim-over'       " :substitute preview
Plug 'https://github.com/matze/vim-move'            " Move lines and selections up and down
Plug 'https://github.com/christoomey/vim-tmux-navigator' " tmux integration
Plug 'https://github.com/tyru/open-browser.vim'     " Open links in browser
Plug 'https://github.com/wsdjeg/vim-fetch'          " Provides `vim path/to/file.ext:12:3` in the shell to open file.ext on line 12 at column 3
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'https://github.com/jubnzv/gruvbox'           " Color scheme
Plug 'https://github.com/chrisbra/Colorizer'       " Colorize color names and codes
Plug 'https://github.com/junegunn/vim-peekaboo'    " Shows vim registers content into vertical split
Plug 'https://github.com/Yggdroot/indentLine'      " Show indentation as vertical lines
Plug 'https://github.com/haya14busa/incsearch.vim' " Incrementally highlight search results
Plug 'https://github.com/jubnzv/vim-cursorword'    " Highlight word under cursor
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/sodapopcan/vim-twiggy'         " Git branch management
Plug 'https://github.com/rhysd/git-messenger.vim'       " Reveal the commit messages under the cursor
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/junegunn/fzf', {
  \ 'dir': '~/.local/opt/fzf',
  \ 'do': './install --all'
  \ }
Plug 'https://github.com/kana/vim-textobj-user'    " Plugin for user-defined textobjs
Plug 'https://github.com/glts/vim-textobj-comment' " textobj for comments
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
Plug 'LucHermitte/lh-vim-lib'                        " Dependency for alternate-lite
Plug 'https://github.com/vim-scripts/a.vim'          " Switch between .c and .h
Plug '~/Dev/IEC.vim'
Plug 'https://github.com/KabbAmine/zeavim.vim'      " Query Zeal docs from vim
Plug 'https://github.com/jpalardy/vim-slime'        " Some slime in my vim.
Plug 'https://github.com/wlangstroth/vim-racket'    " Racket mode
Plug 'https://github.com/luochen1990/rainbow'       " Rainbow Parentheses improved
Plug 'https://github.com/pearofducks/ansible-vim'
Plug 'https://github.com/cespare/vim-toml'
Plug 'https://github.com/dhruvasagar/vim-table-mode'
Plug 'https://github.com/tpope/vim-markdown'
Plug 'https://github.com/masukomi/vim-markdown-folding' " Markdown folding by sections
Plug 'https://github.com/Scuilion/markdown-drawer'      " Simplify navigation in large markdown files
Plug 'https://github.com/lervag/vimtex'
Plug 'https://github.com/aklt/plantuml-syntax'          " PlantUML syntax support
Plug 'https://github.com/othree/xml.vim', { 'for': [ 'xml', 'html' ] }
Plug 'https://github.com/elzr/vim-json', {'for': ['json'] }
" Plug 'https://github.com/gu-fan/riv.vim', { 'for': [ 'rst' ] }

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

" Default conceal settings.
" concealcuror could be overwritten by indentLine plugin in some modes: use g:indentLine_fileTypeExclude as workaround.
set conceallevel=1
set concealcursor=nc

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
inoremap jj <Esc>
inoremap <M-t> TODO 
nnoremap <M-t> iTODO <ESC>4h
inoremap <M-x> xxx 
nnoremap <M-x> ixxx <ESC>3h
nnoremap <leader>h :noh<CR>
nnoremap <leader>xc :q<CR>
nnoremap <leader>s :w<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Insert newline without entering insert mode
" nmap zj o<Esc>k
" nmap zk O<Esc>j

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
noremap ;; :s///g<Left><Left><Left>
noremap ;' :s///cg<Left><Left><Left><Left>

" Keep selected text selected when fixing indentation
vnoremap < <gv
vnoremap > >gv

" Fix common typos
:command! W w
:command! Q q
:command! E e

" E45: 'readonly' option is set (add ! to override)
" Does not work on neovim because job-control differs.
" See:
" https://github.com/neovim/neovim/issues/8217
" https://github.com/neovim/neovim/issues/1716#issuecomment-454519716
" https://github.com/neovim/neovim/pull/8389
" cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Use 'lambdalisue/suda.vim' as workaround
let g:suda#prefix = 'sudo://'
cnoremap e!! execute 'edit! sudo://%'
cnoremap w!! execute 'write sudo://% <bar> edit! sudo://%'

" Create directories before write
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
endfunction
command! Mkw call WriteCreatingDirs()

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>Em mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_ru<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_ru<CR>
" Fix previous error
noremap <C-l> [s1z=``
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
" }}}

" {{{ indentLine configuration
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
" }}}

" {{{ Toggle quickfix window
function! QuickFix_toggle()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor
    copen
endfunction
nnoremap <silent> <leader>q :call QuickFix_toggle()<cr>
" }}}

" Editing neighbors
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%
map <leader>ec :cd %%<cr>

" Find and Replace
map <leader>rs :%s///g<left><left><left>
map <leader>rl :s///g<left><left><left>

" Refresh current buffer content
nnoremap <leader>B :checktime<CR>

" Convert the ^M linebreak to 'normal' linebreaks
nnoremap <silent> <Leader>El :set ff=unix<CR> :e ++ff=dos<CR>

" Remove all trailing whitespaces
nnoremap <silent> <Leader>Es :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" ё -> е
nnoremap <silent> <Leader>E` :%s/ё/е/g<cr>

function! BufferClose()
  if (tabpagenr('$') == 1 && winnr() == 1 && len(expand('%'))==0 && len(getbufinfo({'buflisted':1})) == 1)
    exec ':q'
  else
    exec ':bd'
  endif
endfunction
nnoremap <C-F4> :call BufferClose()<CR>
nnoremap <leader>xk :call BufferClose()<CR>

" Switch to recent buffer
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

" Move selected lines with <C-j> / <C-k>
let g:move_key_modifier = 'C'

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

" {{{ netrw configuration
" Allows to open files in external program with `gx`
let g:netrw_browsex_viewer = "xdg-open"
" }}}

" {{{ Integration with web-browser
let g:openbrowser_search_engines = extend(
\   get(g:, 'openbrowser_search_engines', {}),
\   {
\       'github': 'http://github.com/search?q=fork%3Afalse+{query}',
\       'github-vimscript': 'http://github.com/search?l=Vim+script&q=fork%3Afalse+{query}&type=Code',
\       'github-python': 'http://github.com/search?l=Python&q=fork%3Afalse+{query}&type=Code',
\       'github-c': 'http://github.com/search?l=C&q=fork%3Afalse+{query}&type=Code',
\       'github-cpp': 'http://github.com/search?l=C%2B%2B&q=fork%3Afalse+{query}&type=Code',
\       'cplusplus': 'http://www.cplusplus.com/search.do?q={query}',
\       'gnome': 'https://developer.gnome.org/search?q={query}',
\       'buildbot': 'https://docs.buildbot.net/current/search.html?q={query}',
\       'google': 'http://google.com/search?q={query}',
\       'google-code': 'http://code.google.com/intl/en/query/#q={query}',
\       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
\       'yandex-translate-en-ru': 'https://translate.yandex.ru/?lang=en-ru&text={query}',
\       'debian-code-search': 'https://codesearch.debian.net/search?q={query}',
\       'wikipedia': 'http://en.wikipedia.org/wiki/{query}',
\       'wikipedia-ru': 'http://ru.wikipedia.org/wiki/{query}',
\   },
\   'keep'
\)
let g:openbrowser_default_search = 'google'

" Search selected visually selected word with appropriate search engine.
nnoremap <leader>os <Plug>(openbrowser-smart-search)
nnoremap <leader>ogs :call openbrowser#smart_search(expand('<cword>'), "google")<CR>
nnoremap <leader>ogg :call openbrowser#smart_search(expand('<cword>'), "github")<CR>
nnoremap <leader>ogc :call openbrowser#smart_search(expand('<cword>'), "github-c")<CR>
nnoremap <leader>ogx :call openbrowser#smart_search(expand('<cword>'), "github-cpp")<CR>
nnoremap <leader>ogl :call openbrowser#smart_search(expand('<cword>'), "cplusplus")<CR>
nnoremap <leader>ogp :call openbrowser#smart_search(expand('<cword>'), "github-python")<CR>
nnoremap <leader>odg :call openbrowser#smart_search(expand('<cword>'), "gnome")<CR>
nnoremap <leader>odb :call openbrowser#smart_search(expand('<cword>'), "buildbot")<CR>
nnoremap <leader>otr :call openbrowser#smart_search(expand('<cword>'), "yandex-translate-en-ru")<CR>
" }}}

" {{{ tmux integration
" Free my prefix key
map ` <Nop>

if exists('$TMUX')
  " Execute previous command in right pane
  nnoremap <silent> <leader>; :silent !tmux send-keys -t right Up Enter<cr>
else
  map <leader>; <Nop>
endif
" }}}

" {{{ Parens settings
let g:AutoPairsShortcutToggle = ''

" Free statusline from Matchup
let g:matchup_matchparen_status_offscreen=0

" Insert fold block
let g:surround_102 = split(&commentstring, '%s')[0] . " {{{ \r " . split(&commentstring, '%s')[0] . " }}}"
" }}}

" {{{ Folding settings
set foldmethod=syntax
set foldnestmax=6
set nofoldenable       " Disable folding when open file
set foldlevel=2
set foldcolumn=0
set fillchars=fold:\ 

" {{{ Custom fold function
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
"" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! NERDTreeOpen()
  if IsNERDTreeOpen()
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction

map <A-1> :call NERDTreeOpen()<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeIgnore=[
  \ ".*\\.class$",
  \ ".*\\.o$",
  \ ".*\\.pyc$",
  \ "depcomp$",
  \ "install-sh$",
  \ ]
" }}}

" {{{ DirDiff
let g:DirDiffWindowSize = 6
let g:DirDiffEnableMappings = 0
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*.pyc,tags"
" }}}

" {{{ Datetime
" language time C
nnoremap <silent> <leader>c. "=strftime("%Y-%m-%d")<CR>P
nnoremap <silent> <C-c>. "=strftime("%Y-%m-%d")<CR>P
inoremap <silent> <C-c>. <C-R>=strftime("%Y-%m-%d")<CR>
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
au FileType fzf tnoremap <buffer> <Esc> <c-g>

nnoremap <leader><space> :Commands<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>xf :Files<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <A-7> :BTags<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>xr :FZFMru <CR>

nnoremap <leader>fs :Ag<CR>
nnoremap <Leader>fw :Ag<Space><C-r><C-w><CR>

" Search in specific file types
command! -bang -nargs=* AgC call fzf#vim#ag(<q-args>, '-G \.c$', {'down': '~40%'})
command! -bang -nargs=* AgH call fzf#vim#ag(<q-args>, '-G \.h$', {'down': '~40%'})
command! -bang -nargs=* AgCC call fzf#vim#ag(<q-args>, '--cc', {'down': '~40%'})
command! -bang -nargs=* AgCpp call fzf#vim#ag(<q-args>, '--cpp', {'down': '~40%'})
command! -bang -nargs=* AgPython call fzf#vim#ag(<q-args>, '--python', {'down': '~40%'})
command! -bang -nargs=* AgRust call fzf#vim#ag(<q-args>, '--rust', {'down': '~40%'})
command! -bang -nargs=* AgElisp call fzf#vim#ag(<q-args>, '--elisp', {'down': '~40%'})
command! -bang -nargs=* AgCSS call fzf#vim#ag(<q-args>, '--css', {'down': '~40%'})
nnoremap <leader>fac :AgCC<CR>
nnoremap <leader>faC :AgCpp<CR>
nnoremap <leader>fap :AgPython<CR>
nnoremap <leader>far :AgRust<CR>
nnoremap <leader>fae :AgElisp<CR>

" TODO entries in current directory
command! -bang -nargs=* AgTODO call fzf#vim#ag("TODO", <q-args>, {'down': '~40%'})
command! -bang -nargs=* Agxxx call fzf#vim#ag("xxx", <q-args>, {'down': '~40%'})
command! -bang -nargs=* AgFIXME call fzf#vim#ag("FIXME", <q-args>, {'down': '~40%'})
nnoremap <leader>fxt :AgTODO<CR>
nnoremap <leader>fxx :Agxxx<CR>
nnoremap <leader>fxf :AgFIXME<CR>
" }}}

" {{{ Nerdcommenter
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
" }}}

" Avoid syntax highlighting for large files
au BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

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

set completeopt-=preview
" }}}

" {{{ neosnippet
imap <A-l> <Plug>(neosnippet_expand_or_jump)
smap <A-l> <Plug>(neosnippet_expand_or_jump)
xmap <A-l> <Plug>(neosnippet_expand_target)

" let g:neosnippet#enable_completed_snippet = 1
" let g:neosnippet#enable_complete_done = 0

" If your snippets trigger are same with builtin snippets, your snippets overwrite them.
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Reload snippets
nnoremap <leader>rS :call neosnippet#variables#set_snippets({})<cr>
" }}}

" {{{ LanguageClient settings
" let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_loadSettings = 1
let g:LanguageClient_autoStart = 0
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_waitOutputTimeout = 5
let g:LanguageClient_useVirtualText = 0
let g:LanguageClient_useFloatingHover = 1
" let g:LanguageClient_hoverPreview = "Never"
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

" FIXME: Can be broken with cquery on some projects: use default `gq` instead.
" set formatexpr=LanguageClient_textDocument_rangeFormatting()
set formatexpr=""

" {{{ Keybindings
" I keep it as separated function to use this hotkeys when LSP is not started, e.g. use ctags/cscope binds for goto
" definition / goto implementation in large C projects when LSP is slow.
function! LCKeymap()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    " General
    nnoremap gD :only<bar>vsplit<cr>gd
    nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<cr>
    nnoremap <silent> <F5> :call LanguageClient_contextMenu()<CR>
    nnoremap <silent> <leader>k :call LanguageClient#textDocument_hover()<cr>
    " Movement
    nnoremap <silent> gd :call LanguageClient#textDocument_definition()<cr>
    nnoremap <silent> gi :call LanguageClient#textDocument_implementation()<cr>
    nnoremap <silent> gr :call LanguageClient_textDocument_references()<cr>
    nnoremap <silent> gs :call LanguageClient#workspace_symbol()<cr>
    " Editing
    nnoremap <silent> <leader>lf :call LanguageClient#textDocument_formatting()<cr>
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
  return g:lsp_status == 1 ? 'LSP' : ''
endfunction
" }}}

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
let g:DoxygenToolkit_commentType = "C"
let g:DoxygenToolkit_compactOneLineDoc = "no"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"
au FileType c nnoremap <leader>d :Dox<CR>
"}}}

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>GitGutterPrevHunk
nmap ]v <Plug>GitGutterNextHunk
nmap <leader>vv <Plug>GitGutterPreviewHunk
nmap <leader>v- <Plug>GitGutterUndoHunk
nmap <leader>v= <Plug>GitGutterStageHunk
nmap <leader>vs :Gstatus<cr>
nmap <leader>ve :Gedit 
nmap <leader>vd :Gdiff 
nmap <leader>vb :Gblame<cr>
nmap <leader>vl :Glog<cr>:copen<cr>
nmap <leader>vB :Twiggy<cr>
nmap <leader>m <Plug>(git-messenger)
" }}}

" {{{ Search in Zeal docsets
nmap <leader>z <Plug>Zeavim
vmap <leader>z <Plug>ZVVisSelection
nmap gz <Plug>ZVOperator
nmap <leader><leader>z <Plug>ZVKeyDocset
" }}}

" {{{ C/C++
" au FileType c,cpp setlocal commentstring=//\ %s
au FileType c,cpp setlocal tw=80
au FileType c,cpp call LCDisableAutostart(['linux-', 'Kernel', 'Projects', 'Bugs', 'beremiz'])
au FileType c,cpp call LCKeymap()

" Use C filetype for headers by default
au BufReadPre,BufRead,BufNewFile *.h set filetype=c

" Switch between header and sources
nnoremap <silent> <A-a> :silent A<CR>

" clang include fixer
let g:clang_include_fixer_path = "clang-include-fixer-7"
au FileType c,cpp noremap <leader>Ei :pyf /usr/lib/llvm-7/share/clang/clang-include-fixer.py<cr>

" Mans quick access
au FileType c,cpp noremap <leader>Ms :Man 2 syscalls<cr>

" Align statements relative to case label
au FileType c,cpp setlocal cinoptions+=l1

" Autoformat on save
au BufWritePre *.cpp :call LanguageClient#textDocument_formatting_sync()
au BufWritePre *.hpp :call LanguageClient#textDocument_formatting_sync()

" Apply Linux Kernel settings
let g:linuxsty_patterns = [ "/usr/src/", "/linux" ]

" {{{ Commands and binds
au FileType c call CmdC()
function! CmdC()
    " Clean debug prints from `prdbg` snippet
    command! CleanDebugPrints :g/\/\/\ prdbg$/d
    nnoremap <leader>Ec :CleanDebugPrints<CR>
endfunction
" }}}

" }}}

" {{{ Lisp-family languages
function! LispKeymap()
  inoremap <M-\> λ
endfunction

let g:vim_parinfer_globs = ['*.scm', '*.rkt']
let g:vim_parinfer_filetypes = ['scheme', 'racket']

let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "1.2"}
let g:slime_dont_ask_default = 1
au FileType racket RainbowToggle
au FileType racket call LispKeymap()
" }}}

" {{{ Rust
au FileType rust call LCKeymap()
au FileType rust nnoremap <buffer> <f9> :!cargo build<cr>
let g:rustfmt_autosave = 1
" }}}

" {{{ Python
au FileType python nnoremap <Leader>Ei :!isort %<CR><CR>
au FileType python set tw=0
au FileType python set foldmethod=indent foldnestmax=2
au FileType python call LCKeymap()
au Filetype python set cinoptions=:0,l1,t0,g0,(0
" }}}

" {{{ vimscript
let g:vim_indent_cont = 2
au FileType vim setlocal sw=4 ts=4 expandtab
au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
au FileType vim nnore <silent><buffer> K <Esc>:help <C-R><C-W><CR>
au FileType help noremap <buffer> q :q<cr>
" }}}

" {{{ IEC611-31
let matiec_path = '/home/jubnzv/Work/Beremiz/matiec/'
let matiec_mkbuilddir = 1
" }}}

" {{{ LaTeX
" See awesome LaTeX setup guide:
" https://castel.dev/post/lecture-notes-1/
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_close_braces = 1
let g:tex_conceal='abdmg'
au FileType tex set sw=2
au FileType tex call Togglegjgk()
au FileType tex set spell! spelllang=en_us,ru_yo
" }}}

" {{{ reStructuredText
au FileType rst setlocal sw=4 ts=4 expandtab
au FileType rst setlocal textwidth=80
au Filetype rst setlocal foldmethod=expr
au FileType rst set spell! spelllang=en_us,ru_ru
au FileType rst call Togglegjgk()

" Disable auto-folding on `:w`
let g:riv_fold_auto_update=0

" The position of fold info
let g:riv_fold_info_pos='left'
" }}}

" JSON
let g:vim_json_syntax_conceal = 0

" {{{ Markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'rust']
au FileType markdown set nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
au FileType markdown set spell! spelllang=en_us,ru_ru
au FileType markdown call Togglegjgk()
au FileType markdown nnoremap <buffer> <F3> :MarkDrawer<CR>
au FileType markdown nnoremap <buffer> <Tab> za<CR>k
au FileType markdown nnoremap <buffer> <S-Tab> zA<CR>k
au FileType markdown nnoremap <buffer> <leader>' i``
au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
au FileType markdown inoremap <buffer> --<space> –<space>
au FileType markdown inoremap <buffer> -><space> →<space>
" }}}

" {{{ Other ft-specific autocommands
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2

au FileType conf set foldmethod=marker foldenable
au Filetype css setlocal ts=4
au Filetype html setlocal ts=4

au BufNewFile,BufRead .clang-format set ft=config
au BufNewFile,BufRead   .pdbrc set ft=python

" ansible playbooks
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */ops/ansible/*.yml set filetype=yaml.ansible

" buildbot configuration files
au BufNewFile,BufRead   master.cfg      set ft=python foldmethod=marker foldenable tw=120
au BufNewFile,BufRead   buildbot.tac    set ft=python foldmethod=marker foldenable tw=120

" Taskwarrior tasks (`task [id] edit`)
au BufRead *.task /Description:

au FileType gitcommit call setpos('.', [0, 1, 1, 0])
au FileType gitcommit inoremap <buffer> --<space> –<space>
au FileType gitcommit inoremap <buffer> -><space> →<space>
" }}}

" {{{ Toggle features
function! ToggleConceal()
  if (&conceallevel == 0)
    set conceallevel=1
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

nnoremap <leader>tfc :call ToggleFoldColumn()<CR>
nnoremap <leader>tc :call ToggleConceal()<CR>
nnoremap <leader>tg :call Togglegjgk()<CR>
nnoremap <leader>tl :call ToggleLSP()<CR>
nnoremap <leader>tp :setlocal paste!<CR>
nnoremap <leader>tn :call ToggleNumber()<CR>
nnoremap <leader>tC :ColorToggle<CR>
" }}}

" vim:fdm=marker:fen:sw=2:tw=120
