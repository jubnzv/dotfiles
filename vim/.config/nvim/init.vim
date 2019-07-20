set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
let g:python3_host_prog  = '/usr/bin/python3.6'

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'            " A tree explorer plugin for vim
Plug 'kshenoy/vim-signature'          " Extended marks support
Plug 'justinmk/vim-sneak'             " Jump to any location specified by two characters.
Plug 'tpope/vim-eunuch'               " Helpers for Shell
Plug 'lambdalisue/suda.vim'           " Read or write files with sudo command. Required for neovim.
Plug 'tpope/vim-speeddating'          " <C-a>/<C-x> for dates and timestamps
Plug 'tpope/vim-repeat'               " Remap `.` in a way that plugins can tap into it
Plug 'will133/vim-dirdiff'            " Diff two directories
Plug 'andymass/vim-matchup'           " Better `%` for some modes
Plug 'godlygeek/tabular'              " Vim script for text filtering and alignment
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'              " Case-sensitive search/substitute/abbreviate
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-rsi'                  " Readline (emacs) keybindings in command and insert modes
Plug 'osyo-manga/vim-over'            " :substitute preview
Plug 'christoomey/vim-tmux-navigator' " tmux integration
Plug 'tyru/open-browser.vim'          " Open links in browser
Plug 'itchyny/lightline.vim'
Plug 'jubnzv/gruvbox'                 " Color scheme
Plug 'chrisbra/Colorizer'             " Colorize color names and codes
Plug 'junegunn/vim-peekaboo'          " Shows vim registers content into vertical split
Plug 'Yggdroot/indentLine'            " Show indentation as vertical lines
Plug 'haya14busa/incsearch.vim'       " Incrementally highlight search results
Plug 'jubnzv/vim-cursorword'          " Highlight word under cursor
Plug 'chrisbra/NrrwRgn'               " Narrowing feature from emacs
Plug 'thiagoalessio/rainbow_levels.vim' " Highlights code by indentation level
Plug 'luochen1990/rainbow'            " Rainbow Parentheses
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'airblade/vim-gitgutter'         " Shows git status on a gutter column
Plug 'sodapopcan/vim-twiggy'          " Git branch management
Plug 'rhysd/git-messenger.vim'        " Reveal the commit messages under the cursor
Plug 'mhinz/vim-sayonara'             " Sane buffer/window deletion
Plug 'vim-syntastic/syntastic'        " Syntax checking hacks for vim
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {
  \ 'dir': '~/.local/opt/fzf',
  \ 'do': './install --all'
  \ }
Plug 'kana/vim-textobj-user'          " Plugin for user-defined textobjs
Plug 'glts/vim-textobj-comment'       " textobj for comments
Plug 'bps/vim-textobj-python'         " Text objects for Python.
Plug 'liuchengxu/vista.vim'           " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'   " Auto (re)generate tag files
Plug 'terryma/vim-expand-region'      " Visually select increasingly larger regions of text
Plug 'machakann/vim-swap'             " Reorder arguments in functions with `g>` and `g<`
Plug 'scrooloose/nerdcommenter'       " Comment plugin
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', {
  \ 'do': ':UpdateRemotePlugins'
  \ }
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
  \ }
Plug 'jubnzv/DoxygenToolkit.vim'
Plug 'LucHermitte/lh-vim-lib'         " Dependency for alternate-lite
Plug 'LucHermitte/alternate-lite'     " Switch between source and header
Plug 'vhda/verilog_systemverilog.vim' " Verilog/SystemVerilog Syntax and Omni-completion
Plug 'KabbAmine/zeavim.vim'           " Query Zeal docs from vim
Plug 'jpalardy/vim-slime'             " Some slime in my vim.
Plug 'wlangstroth/vim-racket'         " Racket mode
Plug 'bfrg/vim-cpp-modern'            " Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
Plug 'rhysd/vim-clang-format'         " Vim plugin for clang-format
Plug 'luochen1990/rainbow'            " Rainbow Parentheses improved
Plug 'pearofducks/ansible-vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'tpope/vim-markdown'
Plug 'masukomi/vim-markdown-folding'  " Markdown folding by sections
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'lervag/vimtex'
Plug 'cespare/vim-toml'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'othree/xml.vim', { 'for': [ 'xml', 'html' ] }
Plug 'elzr/vim-json', {'for': ['json'] }
Plug 'rhysd/vim-grammarous' " A powerful grammar checker using LanguageTool
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug '~/Dev/IEC.vim'

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
set wildmode=longest,list,full
set wildignore+=*.o                         " Compiled object files
set wildignore+=*.pyc                       " Python bytecode
set wildignore+=*.aux,*.out,*.toc           " LaTeX output
set wildignore+=*.jpg,*.jpeg,*.gif,*.png    " Binary images
set wildignore+=.hg,.git,.svn               " VCS
set wildignore+=*~                          " Backup files
set timeoutlen=500                          " Time to wait for a mapped sequence to complete (ms)
set notimeout                               " Remove delay between complex keybindings.
set noautochdir                             " Set working directory to the current file
set autoindent                              " Autoindent when starting new line, or using o or O.
set noautoread                              " Don't reload unchanged files automatically.
set hidden
set tabstop=4
set shiftwidth=4
set expandtab                               " On pressing tab insert 4 spaces
set lazyredraw                              " Do not redraw screen in the middle of a macro. Makes them complete faster.
set nojoinspaces                            " Don't add two spaces when joining a line that ends with.,?, or !

" Default conceal settings.
" concealcuror could be overwritten by indentLine plugin in some modes: use g:indentLine_fileTypeExclude as workaround.
set conceallevel=1
set concealcursor=nc

" Cyrillic layout in normal mode
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]

" Allows to open files in external program with `gx` inside netrw
let g:netrw_browsex_viewer = "xdg-open"
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

" Jump to the last position when reopening a file (see `/etc/vim/vimrc` on Debian)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

" {{{ Keybindings

" {{{ Common
inoremap jj <Esc>
nnoremap <leader>h :noh<CR>
nnoremap <leader>xc :q<CR>
nnoremap <leader>s :w<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Insert newline without entering insert mode
" nmap zj o<Esc>k
" nmap zk O<Esc>j

" Reload vimrc
nnoremap <leader>Rc :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Update plugins
nnoremap <leader>Rp :PlugUpdate<CR>

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

" Command to manually create directory for current file
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
endfunction
command! Mkw call WriteCreatingDirs()

" Create directories before write
" [1]: https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>rm mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_yo<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_yo<CR>
" Fix previous error
noremap <A-u> [s1z=``
inoremap <A-u> <c-g>u<Esc>[s1z=`]a<c-g>u

" LanguageTool (https://www.languagetool.org/) integration
" Use above <Plug> mappings only after checking.
let g:grammarous#hooks = {}
function! g:grammarous#hooks.on_check(errs) abort
    nmap <buffer><C-n> <Plug>(grammarous-move-to-next-error)
    nmap <buffer><C-p> <Plug>(grammarous-move-to-previous-error)
endfunction
function! g:grammarous#hooks.on_reset(errs) abort
    nunmap <buffer><C-n>
    nunmap <buffer><C-p>
endfunction
nnoremap <leader>Ge :GrammarousCheck<cr>
vnoremap <leader>Ge :GrammarousCheck<cr>
nnoremap <leader>Gr :GrammarousCheck --lang=ru<cr>
vnoremap <leader>Gr :GrammarousCheck --lang=ru<cr>
nnoremap <leader>Gs :GrammarousReset<cr>
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
    " lopen
  endfunction
nnoremap <silent> <leader>q :call QuickFix_toggle()<cr>
" }}}

" Editing neighbors
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>ee :e 
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
nnoremap <silent> <leader>rl :set ff=unix<CR> :e ++ff=dos<CR>

" Remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" ё -> е
nnoremap <silent> <leader>r` :%s/ё/е/g<cr>

" Close buffer
nnoremap <C-F4> :Sayonara<CR>

" Switch to recent buffer
nnoremap <A-r> <C-^>

" Use Ctrl-W operation in insert mode
inoremap <C-w> <C-g>u<C-w>

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

" {{{ vim-sneak
" Use vim-sneak mappings instead default f/t
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" Poor man easymotion
let g:sneak#label = 1
map <A-;> <Plug>SneakLabel_s
" }}}

" Tabularize
cnoreabbrev Tab Tabularize
" }}}

" {{{ Lightline
let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left':  [ [ 'mode', 'paste' ],
  \              [ 'readonly', 'filename', 'modified' ],
  \              [ 'lsp_status'], ['method'] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ],
  \              [ 'gitbranch' ] ],
  \ },
  \ 'component': {
  \   'lsp_status': '%#LSPColor#%{LightlineLSPStatus()}',
  \   'gitbranch': ' %{fugitive#head()}'
  \ },
  \ 'component_function': {
  \   'method': 'NearestMethodOrFunction'
  \ },
  \ 'component_type': {
  \   'lsp_warnings': 'warning',
  \   'lsp_errors': 'error',
  \   'readonly': 'error',
  \ },
  \ }

let g:buftabline_indicators=1 " show modified
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
nnoremap <leader>osg :call openbrowser#smart_search(expand('<cword>'), "google")<CR>
nnoremap <leader>ogg :call openbrowser#smart_search(expand('<cword>'), "github")<CR>
nnoremap <leader>ogc :call openbrowser#smart_search(expand('<cword>'), "github-c")<CR>
nnoremap <leader>ogx :call openbrowser#smart_search(expand('<cword>'), "github-cpp")<CR>
nnoremap <leader>ogv :call openbrowser#smart_search(expand('<cword>'), "github-vimscript")<CR>
nnoremap <leader>orx :call openbrowser#smart_search(expand('<cword>'), "cplusplus")<CR>
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
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>xf :Files<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>xr :FZFMru <CR>

nnoremap <leader>fs :Ag<CR>
nnoremap <leader>fw :Ag<Space><C-r><C-w><CR>

" Search in specific file types
command! -bang -nargs=* AgC call fzf#vim#ag(<q-args>, '-G \.c$', {'down': '~40%'})
command! -bang -nargs=* AgH call fzf#vim#ag(<q-args>, '-G \.h$', {'down': '~40%'})
command! -bang -nargs=* AgCC call fzf#vim#ag(<q-args>, '--cc', {'down': '~40%'})
command! -bang -nargs=* AgCxx call fzf#vim#ag(<q-args>, '--cpp', {'down': '~40%'})
command! -bang -nargs=* AgPython call fzf#vim#ag(<q-args>, '--python', {'down': '~40%'})
command! -bang -nargs=* AgRust call fzf#vim#ag(<q-args>, '--rust', {'down': '~40%'})
command! -bang -nargs=* AgElisp call fzf#vim#ag(<q-args>, '--elisp', {'down': '~40%'})
command! -bang -nargs=* AgCSS call fzf#vim#ag(<q-args>, '--css', {'down': '~40%'})
nnoremap <leader>fac :AgCC<CR>
nnoremap <leader>fax :AgCxx<CR>
nnoremap <leader>fap :AgPython<CR>
nnoremap <leader>far :AgRust<CR>
nnoremap <leader>fae :AgElisp<CR>

" rga: ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, etc.
" https://github.com/phiresky/ripgrep-all
command! -bang -nargs=* Rga
  \ call fzf#vim#grep(
  \   'rga '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'enter': '!tmux new -d xdg-open'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'enter': '!tmux new -d xdg-open'}, 'right:50%:hidden', '?'),
  \ <bang>0)
nnoremap <leader>fS :Rga<cr>

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

" {{{ ctags and vista.vim configuration
set tags=./tags;
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']

" Show current method name in lightline
function! NearestMethodOrFunction() abort
  let l:method = get(b:, 'vista_nearest_method_or_function', '')
  if l:method != ''
    let l:method = '[' . l:method . ']'
  endif
  return l:method
endfunction
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

nnoremap <silent> <F7> :Vista!!<CR>
nnoremap <silent> <A-7>:Vista focus<CR>
" }}}

" {{{ syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
cabbrev <silent> bd <C-r>=(getcmdtype()==#':' && getcmdpos()==1 ? 'lclose\|bdelete' : 'bd')<CR>
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = 'ee'
let g:syntastic_style_error_symbol = 'se'
let g:syntastic_warning_symbol = 'ww'
let g:syntastic_style_warning_symbol = 'sw'
cnoreabbrev sc SyntasticCheck

" Run it only manually.
let g:syntastic_mode_map={'mode': 'passive'}

let g:syntastic_c_checkers = ['cppcheck', 'gcc']
let g:syntastic_cpp_checkers = ['cppcheck', 'gcc']
let g:syntastic_python_checkers = ['pyflakes']
let g:syntastic_bash_checkers = ['shellcheck']
" }}}

" {{{ deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><A-q> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <expr><A-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><A-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr><A-l> pumvisible() ? "\<CR>" : ""
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

" If your snippets trigger are same with builtin snippets, your snippets overwrite them.
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'

" Reload snippets
nnoremap <leader>Rs :call neosnippet#variables#set_snippets({})<cr>
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
  \ 'cpp': ['ccls', '--log-file=/tmp/ccls.log'],
  \ 'c': ['ccls', '--log-file=/tmp/ccls.log'],
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
" A bit complicated. See :he lightline-problem-12 for description.
function! LightlineLSPStatus() abort
  let map = { 'V': 'n', "\<C-v>": 'n', 's': 'n', 'v': 'n', "\<C-s>": 'n', 'c': 'n', 'R': 'n'}
  let mode = get(map, mode()[0], mode()[0])
  let bgcolor = {'n': [237, '#3c3836'], 'i': [239, '#504945']}
  let color = get(bgcolor, mode, bgcolor.n)
  if g:lsp_status == 1
    exe printf('hi LSPColor ctermbg=%d ctermfg=106 guifg=#98971a guibg=%d term=bold cterm=bold', color[0], color[1])
  else
    exe printf('hi LSPColor ctermbg=%d ctermfg=241 guifg=#665c54 guibg=%d', color[0], color[1])
  endif
  return ''
endfunction
" }}}

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
nmap <leader>vp :Gpull<cr>
nmap <leader>vP :Gpush 
nmap <leader>ve :Gedit 
nmap <leader>vd :Gdiff HEAD
nmap <leader>vD :Git! diff<cr>
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

" {{{ textobj (https://github.com/glts/vim-textobj-comment) configuration
let g:textobj_comment_no_default_key_mappings = 1
xmap a/ <Plug>(textobj-comment-a)
omap a/ <Plug>(textobj-comment-a)
xmap i/ <Plug>(textobj-comment-i)
omap i/ <Plug>(textobj-comment-i)
" }}}

" {{{ C/C++
au FileType c,cpp setlocal commentstring=//\ %s
au FileType c,cpp setlocal tw=80
au FileType c,cpp call LCDisableAutostart(['linux-', 'Kernel', 'Projects', 'Bugs', 'beremiz'])
au FileType c,cpp call LCKeymap()
au FileType c,cpp nnoremap <buffer><leader>rd :g/\/\/\ prdbg$/d<CR>

" Use C filetype for headers by default
" au BufReadPre,BufRead,BufNewFile *.h set filetype=c

" Switch between header and sources
nnoremap <A-a> :A<CR>

" clang include fixer
let g:clang_include_fixer_path = "clang-include-fixer-7"
au FileType c,cpp noremap <leader>ri :pyf /usr/lib/llvm-7/share/clang/clang-include-fixer.py<cr>

" Quick access to man pages
au FileType c,cpp noremap <leader>Ms :Man 2 syscalls<cr>/System call.*Kernel<cr>:noh<cr>3j

" Align statements relative to case label
au FileType c,cpp setlocal cinoptions+=l1

" Autoformatting with clang-format
autocmd FileType c,cpp,objc nnoremap <buffer><leader>lf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><leader>lf :ClangFormat<CR>
nmap <leader>tf :ClangFormatAutoToggle<CR>
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
au FileType python nnoremap <leader>ri :!isort %<CR><CR>
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

" {{{ JSON
let g:vim_json_syntax_conceal = 0
autocmd FileType json syntax match Comment +\/\/.\+$+
" }}}

" {{{ Markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'rust']
au FileType markdown set nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
au FileType markdown set spell! spelllang=en_us,ru_yo
au FileType markdown call Togglegjgk()
au FileType markdown nnoremap <buffer> <Tab> za<CR>k
au FileType markdown nnoremap <buffer> <S-Tab> zA<CR>k
au FileType markdown nnoremap <buffer> <leader>' i``
au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
au FileType markdown inoremap <buffer> --<space> –<space>
au FileType markdown inoremap <buffer> -><space> →<space>
au FileType markdown inoremap <buffer> =><space> ⇒<space>
au FileType markdown nnoremap <buffer> <silent> <leader>p :call pasteimage#MarkdownClipboardImage()<CR>
au FileType markdown nnoremap <buffer> <F7> :Vista toc<CR>

" Markdown preview in web-browser
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" Open preview in a new firefox window
" [1]: https://github.com/iamcco/markdown-preview.nvim/issues/19#issuecomment-464338238
function! g:OpenBrowser(url)
  silent exe 'silent !open -a "firefox --new-window " ' . a:url
endfunction
let g:mkdp_browserfunc = 'g:OpenBrowser'
cnoreabbrev mp MarkdownPreview
au FileType markdown nmap <silent> <leader>M :MarkdownPreview<CR>
" }}}

" {{{ Plant UML
au! BufNewFile,BufReadPost *.{uml,puml} set filetype=plantuml
au FileType plantuml set spell! spelllang=en_us,ru_yo
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
au FileType gitcommit inoremap <buffer> =><space> ⇒<space>
" }}}

" {{{ Toggle settings functions
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

let g:hex_mode = 0
function! ToggleHex()
  if (g:hex_mode == 0)
    execute ":%!xxd"
    let g:hex_mode = 1
  else
    execute ":%!xxd -r"
    let g:hex_mode = 0
  endif
endfunction

nnoremap <leader>tc :call ToggleConceal()<CR>
nnoremap <leader>tg :call Togglegjgk()<CR>
nnoremap <leader>tl :call ToggleLSP()<CR>
nnoremap <leader>tx :call ToggleHex()<CR>
nnoremap <leader>tn :call ToggleNumber()<CR>
nnoremap <leader>tp :setlocal paste!<CR>
nnoremap <leader>tC :ColorToggle<CR>
nnoremap <leader>ti :RainbowLevelsToggle<cr>
nnoremap <leader>tr :RainbowToggle<cr>
" }}}

" vim:fdm=marker:fen:sw=2:tw=120
