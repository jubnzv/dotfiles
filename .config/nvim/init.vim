set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
let g:python3_host_prog  = '/usr/bin/python3.8'

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdtree'            " A tree explorer plugin for vim
Plug 'kshenoy/vim-signature'          " Extended marks support
Plug 'tpope/vim-eunuch'               " Helpers for Shell
Plug 'tpope/vim-speeddating'          " <C-a>/<C-x> for dates and timestamps
Plug 'justinmk/vim-sneak'             " The missing motion for Vim
Plug 'tpope/vim-repeat'               " Remap . in a way that plugins can tap into it
Plug 'will133/vim-dirdiff'            " Diff two directories
Plug 'andymass/vim-matchup'           " Better `%` for some modes
Plug 'junegunn/vim-easy-align'        " A Vim alignment plugin
Plug 'wesQ3/vim-windowswap'           " Swap windows without ruining the layout
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'              " Case-sensitive search/substitute/abbreviate
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-rsi'                  " Readline (emacs) keybindings in command and insert modes
Plug 'osyo-manga/vim-over'            " :substitute preview
Plug 'christoomey/vim-tmux-navigator' " tmux integration
Plug 'tyru/open-browser.vim'          " Open links in browser
Plug 'itchyny/lightline.vim'
Plug 'jubnzv/gruvbox'                 " Color scheme
Plug 'norcalli/nvim-colorizer.lua'    " Colorize color names and codes
Plug 'Yggdroot/indentLine'            " Show indentation as vertical lines
Plug 'haya14busa/incsearch.vim'       " Incrementally highlight search results
Plug 'jubnzv/vim-cursorword'          " Highlight word under cursor
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'airblade/vim-gitgutter'         " Shows git status on a gutter column
" TODO: Consider mhinz/vim-signify as replacement
" Plug 'mhinz/vim-signify'              " Shows diff on a gutter column
Plug 'sodapopcan/vim-twiggy'          " Git branch management
Plug 'rhysd/git-messenger.vim'        " Reveal the commit messages under the cursor
Plug 'mhinz/vim-grepper'              " Ag wrapper that works with quickfix window. Useful in large codebases.
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', {
  \ 'dir': '~/.local/opt/fzf',
  \ 'do': './install --all'
  \ }
Plug 'liuchengxu/vista.vim'           " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'   " Auto (re)generate tag files
Plug 'terryma/vim-expand-region'      " Visually select increasingly larger regions of text
Plug 'machakann/vim-swap'             " Reorder arguments in functions with `g>` and `g<`
Plug 'tyru/caw.vim'                   " Comment plugin
Plug 'sirver/ultisnips'               " Snippets plugin
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', {
  \ 'do': ':UpdateRemotePlugins'
  \ }
Plug 'Shougo/deoplete-lsp'             " Neovim's LSP Completion source for deoplete
Plug 'copy/deoplete-ocaml'             " Asynchronous completion for OCaml based on merlin
Plug 'sbdchd/neoformat'
" Native neovim LSP client
if has('nvim-0.5')
  Plug 'neovim/nvim-lsp'
endif
Plug 'jubnzv/DoxygenToolkit.vim'
Plug 'editorconfig/editorconfig-vim'  " EditorConfig Vim Plugin
Plug 'ocaml/vim-ocaml'                " Vim runtime files for OCaml
Plug 'jpalardy/vim-slime'
Plug 'bfrg/vim-cpp-modern'            " Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
Plug 'derekwyatt/vim-fswitch'         " This Vim plugin will help switching between companion files
Plug 'rhysd/vim-clang-format'         " Vim plugin for clang-format
Plug 'vim-python/python-syntax'       " Extended python syntax
Plug 'luochen1990/rainbow'            " Rainbow Parentheses improved
Plug 'pearofducks/ansible-vim'        " Ansible configuration files
Plug 'dhruvasagar/vim-table-mode'     " VIM Table Mode for instant table creation
Plug 'jubnzv/vim-markdown'            " Fork of tpope's vim-markdown with patches
Plug 'masukomi/vim-markdown-folding'  " Markdown folding by sections
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'lervag/vimtex'                  " LaTeX plugin
Plug 'cespare/vim-toml'
Plug 'LnL7/vim-nix'                   " Vim plugin for Nix expressions
Plug 'lervag/wiki.vim'
Plug 'ledger/vim-ledger'
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'othree/xml.vim', { 'for': [ 'xml', 'html' ] }
Plug 'elzr/vim-json', {'for': ['json'] }
Plug 'MTDL9/vim-log-highlighting' " Syntax highlighting for generic log files in VIM
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'jubnzv/IEC.vim'

call plug#end()
" }}}

" {{{ General options
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
set wildcharm=<C-z>
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
set nojoinspaces                            " Don't add two spaces when joining a line that ends with.,?, or !
set eol
set fixeol                                  "<EOL> at the end of file will be restored if missing

" Add additional information in popups (VIM 8.0+ only)
if !has('nvim')
  set completeopt+=popup
  set completepopup=height:10,width:60,highlight:Pmenu,border:off
endif

if has('nvim-0.4')
  set termguicolors
  set winblend=10    " Transparency for floating windows
  set pumblend=10    " Transparency for popup menus
endif

" Default conceal settings.
" concealcuror could be overwritten by indentLine plugin in some modes: use g:indentLine_fileTypeExclude as workaround.
set conceallevel=0
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
let g:gruvbox_color_column='bg1'
let g:gruvbox_number_column='bg0'
colorscheme gruvbox

" Highlighting
highlight Todo ctermfg=130 guibg=#af3a03
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

function! OnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction
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

" Map Ctrl-Backspace to delete previous word or selected region
inoremap <C-BS> <C-W>
cnoremap <C-BS> <C-W>
" vnoremap <C-BS> d

" Reload vimrc
nnoremap <localleader>R :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

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
    au!
    au BufWritePre * if expand("<afile>")!~#'^\w\+:/' && !isdirectory(expand("%:h")) | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1) | redraw! | endif
augroup END

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>rm mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_yo<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_yo<CR>
" Fix previous error
noremap <A-u> [s1z=``
inoremap <A-u> <c-g>u<Esc>[s1z=`]a<c-g>u
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
map <leader>eC :cd ..<cr>

" Find and Replace
map <leader>rs :%s///g<left><left><left>
map <leader>rl :s///g<left><left><left>

" Refresh current buffer content
nnoremap <leader>B :checktime<CR>

" Convert the ^M linebreak to 'normal' linebreaks
nnoremap <silent> <leader>rl :set ff=unix<CR> :e ++ff=dos<CR>

cnoreabbrev enc_dos e! ++enc=cp1251
cnoreabbrev rep_n e! %s/\\n/\r/g

" Remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" ё -> е
nnoremap <silent> <leader>r` :%s/ё/е/g<cr>

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

" vim-easyalign
cnoreabbrev Tab EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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

" {{{ nvim-colorizer
if has('nvim')
lua << EOF
-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  'css';
  'javascript';
  'html';
  'markdown';
  'conf';
}
EOF
endif
" }}}

" {{{ WindowSwap.vim
let g:windowswap_map_keys = 0 "prevent default bindings
nnoremap <silent> <leader>wy :call WindowSwap#MarkWindowSwap()<CR>
nnoremap <silent> <leader>wp :call WindowSwap#DoWindowSwap()<CR>
nnoremap <silent> <leader>ww :call WindowSwap#EasyWindowSwap()<CR>
" }}}

" {{{ Integration with web-browser
let g:openbrowser_search_engines = extend(
\   get(g:, 'openbrowser_search_engines', {}),
\   {
\       'github': 'http://github.com/search?q=fork%3Afalse+{query}',
\       'github-vimscript': 'http://github.com/search?l=Vim+script&q=fork%3Afalse+language%3Avimscript+{query}&type=Code',
\       'github-python': 'http://github.com/search?l=Python&q=fork%3Afalse+language%3APython+{query}&type=Code',
\       'github-c': 'http://github.com/search?l=C&q=fork%3Afalse+language%3AC+{query}&type=Code',
\       'github-cpp': 'http://github.com/search?l=C%2B%2B&q=fork%3Afalse+language%3AC%2B%2B+{query}&type=Code',
\       'github-ocaml': 'http://github.com/search?l=OCaml&q=fork%3Afalse+language%3AOCaml+{query}&type=Code',
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
\       'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\   },
\   'keep'
\)
let g:openbrowser_default_search = 'google'

" Search selected visually selected word with appropriate search engine.
nnoremap <leader>os <Plug>(openbrowser-smart-search)
nnoremap <leader>osg :call openbrowser#smart_search(expand('<cword>'), "google")<CR>
" Translate
nnoremap <leader>otr :call openbrowser#smart_search(expand('<cword>'), "yandex-translate-en-ru")<CR>
" Github
nnoremap <leader>ogg :call openbrowser#smart_search(expand('<cword>'), "github")<CR>
nnoremap <leader>ogc :call openbrowser#smart_search(expand('<cword>'), "github-c")<CR>
nnoremap <leader>ogx :call openbrowser#smart_search(expand('<cword>'), "github-cpp")<CR>
nnoremap <leader>ogv :call openbrowser#smart_search(expand('<cword>'), "github-vimscript")<CR>
nnoremap <leader>ogp :call openbrowser#smart_search(expand('<cword>'), "github-python")<CR>
nnoremap <leader>ogo :call openbrowser#smart_search(expand('<cword>'), "github-ocaml")<CR>
" Documentation
nnoremap <leader>odx :call openbrowser#smart_search(expand('<cword>'), "cppreference")<CR>
nnoremap <leader>orx :call openbrowser#smart_search(expand('<cword>'), "cplusplus")<CR>
nnoremap <leader>odb :call openbrowser#smart_search(expand('<cword>'), "buildbot")<CR>
" }}}

" {{{ tmux integration
" Free my prefix key
map ` <Nop>

if exists('$TMUX')
  " Execute previous command in right pane
  nnoremap <silent> <leader>; :silent !tmux send-keys -t right Up Enter<cr>
  nnoremap <silent> <leader>: :silent !tmux clear-history -t right && tmux send-keys -t right C-l Up Enter<cr>
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

map <silent> <A-0> :call NERDTreeOpen()<CR>
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

" {{{ Grepper
let g:grepper = {}
let g:grepper.tools = ["ag"]
let g:grepper.jump = 1
nnoremap <leader>\ :GrepperAg<Space>
nnoremap gs :Grepper -cword -noprompt<CR>
xmap gs <Plug>(GrepperOperator)
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
nnoremap <leader>ft :Tags<CR>
nnoremap <A-t> :Tags<CR>
nnoremap <leader>xf :Files<CR>
nnoremap <A-p> :Files<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>wf :Windows<CR>
nnoremap <leader>xr :FZFMru <CR>
nnoremap <leader>fc :Cd .<CR>
nnoremap <leader>fs :Ag<CR>
nnoremap <leader>/ :Ag<CR>
nnoremap <leader>fw :Ag<Space><C-r><C-w><CR>

" Search in specific file types
command! -bang -nargs=* AgC call fzf#vim#ag(<q-args>, '-G \.c$', {'down': '~40%'})
command! -bang -nargs=* AgH call fzf#vim#ag(<q-args>, '-G \.h$', {'down': '~40%'})
command! -bang -nargs=* AgCC call fzf#vim#ag(<q-args>, '--cc', {'down': '~40%'})
command! -bang -nargs=* AgCxx call fzf#vim#ag(<q-args>, '--cpp', {'down': '~40%'})
command! -bang -nargs=* AgPython call fzf#vim#ag(<q-args>, '--python', {'down': '~40%'})
nnoremap <leader>fac :AgC<CR>
nnoremap <leader>faC :AgCC<CR>
nnoremap <leader>fah :AgH<CR>
nnoremap <leader>fax :AgCxx<CR>
nnoremap <leader>fap :AgPython<CR>

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 50% of the height
  let height = float2nr(&lines * 0.5)
  " 75% of the width
  let width = float2nr(&columns * 0.75)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (on the top)
  let vertical = 0

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

let g:fzf_colors =
\ { 'fg':      ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg':      ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'CursorLine', 'CursorColumn'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}

" {{{ caw.vim
if has('win32')
  nmap <C-/> gcc<Space>
  vmap <C-/> gcc<Space>
else
  nmap <C-_> gcc<Space>
  vmap <C-_> gcc<Space>
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

" {{{ ctags and vista.vim
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
au VimEnter * call vista#RunForNearestMethodOrFunction()

" Copy current function name to system clipboard.
function! FunctionNameToClipboard() abort
  redir @+
    let l:method = get(b:, 'vista_nearest_method_or_function', '')
    echon l:method
  redir END
endfunction
nnoremap <leader>yf :call FunctionNameToClipboard()<cr>

nnoremap <silent> <A-7> :Vista!!<CR>
" }}}

" {{{ vim-signature
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "m<Space>",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "]`",
        \ 'GotoPrevSpotByPos'  :  "[`",
        \ 'GotoNextMarker'     :  "]-",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListBufferMarks'    :  "m/",
        \ 'ListBufferMarkers'  :  "m?"
        \ }
nnoremap [1 :call signature#marker#Goto('prev', 1, v:count)<cr>
nnoremap ]1 :call signature#marker#Goto('next', 1, v:count)<cr>
nnoremap [2 :call signature#marker#Goto('prev', 2, v:count)<cr>
nnoremap ]2 :call signature#marker#Goto('next', 2, v:count)<cr>
nnoremap [3 :call signature#marker#Goto('prev', 3, v:count)<cr>
nnoremap ]3 :call signature#marker#Goto('next', 3, v:count)<cr>
nnoremap [4 :call signature#marker#Goto('prev', 4, v:count)<cr>
nnoremap ]4 :call signature#marker#Goto('next', 4, v:count)<cr>
nnoremap [5 :call signature#marker#Goto('prev', 5, v:count)<cr>
nnoremap ]5 :call signature#marker#Goto('next', 5, v:count)<cr>
nnoremap [6 :call signature#marker#Goto('prev', 6, v:count)<cr>
nnoremap ]6 :call signature#marker#Goto('next', 6, v:count)<cr>
nnoremap [7 :call signature#marker#Goto('prev', 7, v:count)<cr>
nnoremap ]7 :call signature#marker#Goto('next', 7, v:count)<cr>
nnoremap [8 :call signature#marker#Goto('prev', 8, v:count)<cr>
nnoremap ]8 :call signature#marker#Goto('next', 8, v:count)<cr>
nnoremap [9 :call signature#marker#Goto('prev', 9, v:count)<cr>
nnoremap ]9 :call signature#marker#Goto('next', 9, v:count)<cr>
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

set completeopt-=preview
" }}}

" {{{ UltiSnips
let g:UltiSnipsExpandTrigger='<A-l>'
let g:UltiSnipsJumpForwardTrigger='<A-l>'
let g:UltiSnipsJumpBackwardTrigger='<A-h>'

nnoremap <localleader>sr :call UltiSnips#RefreshSnippets()<cr>:echo "Snippets reloaded"<CR>
nnoremap <localleader>ss :UltiSnipsEdit<CR>
" }}}

" {{{ neoformat
nnoremap <leader>lf :Neoformat<CR>

let g:neoformat_enabled_xsd = ['tidy']
" }}}

" {{{ LSP-client
if has('nvim-0.5')
lua << EOF
require'nvim_lsp'.clangd.setup{
    cmd = { "clangd-11", "--background-index" }
  }
  require'nvim_lsp'.pyls.setup{}
  require'nvim_lsp'.ocamllsp.setup{}
EOF
endif

nnoremap <silent> gd             <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gt             <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <leader>lk     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>lr     <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> gD             <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k>          <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD            <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr             <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <leader>le     <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
" }}}

" {{{ EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
" }}}

" {{{ FSwitch bindings
nnoremap <silent> <A-o> :FSHere<cr>
nnoremap <silent> <localleader>oh :FSSplitLeft<cr>
nnoremap <silent> <localleader>oj :FSSplitBelow<cr>
nnoremap <silent> <localleader>ok :FSSplitAbove<cr>
nnoremap <silent> <localleader>ol :FSSplitRight<cr>
" }}}

" {{{ Doxygen
" Reference: http://www.doxygen.nl/manual/docblocks.html

" Enable syntax highlighting provided by default plugin
let g:load_doxygen_syntax=1

" Configure DoxygenToolchain
let g:DoxygenToolkit_commentType = "C"
let g:DoxygenToolkit_compactOneLineDoc = "no"
let g:DoxygenToolkit_compactDoc = "yes"
let g:DoxygenToolkit_keepEmptyLineAfterComment = "yes"
let g:DoxygenToolkit_authorName="Georgy Komarov <jubnzv@gmail.com>"

" Use C-style /** */ comments
function! Doxygen1Keymap()
  nnoremap <buffer><localleader>dd :Dox<CR>
  nnoremap <buffer><localleader>df $a /**<  */<Esc>hhi
endfunction
"}}}

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>(GitGutterPrevHunk)
nmap ]v <Plug>(GitGutterNextHunk)
nmap <leader>vv <Plug>(GitGutterPreviewHunk)
nmap <leader>v- <Plug>(GitGutterStageHunk)
nmap <leader>v_ <Plug>(GitGutterUndoHunk)
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

" {{{ Copy git link
function! CopyGitLink(...) range
  redir @+
  silent echo gitlink#GitLink(get(a:, 1, 0))
  redir END
endfunction
nmap <silent> <leader>vy :call CopyGitLink()<CR>
vmap <silent> <leader>vy :call CopyGitLink(1)<CR>
" }}}
" }}}

" {{{ table-mode
let g:table_mode_map_prefix = ',t'
let g:table_mode_delete_row_map = ',tdd'
let g:table_mode_delete_column_map = ',tdc'
" }}}

" {{{ C/C++
let g:clang_include_fixer_path = "clang-include-fixer-8"
let g:clang_rename_path = "clang-rename-8"

" {{{ Custom :ClangFormat with aware of my debug prints
function! s:JbzClangFormat()
  let save_cursor = getcurpos()

  if search("prdbg")
      echo "Remove debug prints before running clang-format"
  else
      :ClangFormat
  endif

  call setpos('.', save_cursor)
endfunction

command! -range=% -nargs=0 JbzClangFormat call s:JbzClangFormat()
" }}}

" {{{ Function to remove my debug prints
function! s:JbzRemoveDebugPrints()
  let save_cursor = getcurpos()
  :g/\/\/\ prdbg$/d
  call setpos('.', save_cursor)
endfunction

command! JbzRemoveDebugPrints call s:JbzRemoveDebugPrints()
" }}}

augroup c_cxx_group
  au!
  au FileType c,cpp setlocal commentstring=//\ %s
  au FileType c,cpp setlocal tw=80
  " Remove debug prints created with snippets
  au FileType c,cpp nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
  " Renaming with clang-rename
  au FileType c,cpp nnoremap <buffer><leader>lr :py3f ~/.config/nvim/clang-rename.py<CR>
  " Autoformatting with clang-format
  au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>
  au FileType c,cpp vnoremap <buffer><leader>lf :JbzMyClangFormat<CR>
  au FileType c,cpp nnoremap <leader>tf :ClangFormatAutoToggle<CR>
  " Align statements relative to case label
  au FileType c,cpp setlocal cinoptions+=l1
  " Include fixer
  au FileType c,cpp nnoremap <buffer><leader>l# :pyf /usr/lib/llvm-8/share/clang/clang-include-fixer.py<cr>
  " Set doxygen keybindings
  au FileType c,cpp call Doxygen1Keymap()
  " Enable rainbow parens
  au FileType c,cpp RainbowToggleOn
  " Use C filetype for headers by default
  " au BufReadPre,BufRead,BufNewFile *.h set filetype=c
  " Quick access to man pages
  " au FileType c,cpp noremap <buffer><leader>Ms :Man 2 syscalls<cr>/System call.*Kernel<cr>:noh<cr>3j
  " View standard lib mans with cppman
  " Note: Too slow. Disabled for now.
  " command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
  " au FileType cpp nnoremap <silent><buffer> K <Esc>:Cppman <cword><CR>
augroup END
" }}}

" {{{ slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "1.2"}
let g:slime_dont_ask_default = 1
" }}}

" {{{ Python
" Enable extended Python syntax highlighting provided by vim-python/python-syntax.
let g:python_highlight_all = 1

let g:neoformat_enabled_python = ['autopep8']

" {{{ Remove pdb breakpoints created with snippets
function! s:JbzRemovePdbCalls()
  let save_cursor = getcurpos()

  :g/\import\ pdb;\ pdb\.set_trace\(\)$/d
  call setpos('.', save_cursor)
endfunction

command! JbzRemovePdbCalls call s:JbzRemovePdbCalls()
" }}}

augroup python_group
  au!
  au FileType python set tw=0
  au FileType python set foldmethod=indent foldnestmax=2
  au FileType python RainbowToggleOn
  au Filetype python set cinoptions=:0,l1,t0,g0,(0
  au FileType c,cpp nnoremap <buffer><leader>rd :JbzRemovePdbCalls<CR>
  au FileType python nnoremap <buffer> <leader>ri :!isort %<CR><CR>
  au FileType python nnoremap <buffer><leader>rd :g/pdb\.set_trace()/d<CR>
augroup END
" }}}

" {{{ OCaml
" Merlin
" See: https://github.com/ocaml/merlin/wiki/vim-from-scratch
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

let g:neoformat_enabled_ocaml = ['ocpindent']

augroup ocaml_group
  au!
  au FileType ocaml RainbowToggleOn
  au FileType dune RainbowToggleOn
  " FSwitch associations
  au! BufEnter *.ml  let b:fswitchdst = 'mli' | let b:fswitchlocs = 'ifrel:/././'
  au! BufEnter *.mli let b:fswitchdst = 'ml'  | let b:fswitchlocs = 'ifrel:/././'
augroup END
" }}}

" {{{ vimscript
let g:vim_indent_cont = 2

augroup vimscript_group
  au!
  au FileType vim setlocal sw=4 ts=4 expandtab
  au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
  au FileType vim nnoremap <silent><buffer> K <Esc>:help <C-R><C-W><CR>
  au FileType help noremap <buffer> q :q<cr>
augroup END
" }}}

" {{{ IEC611-31
let matiec_path = '/home/jubnzv/Work/Beremiz/matiec/'
let matiec_mkbuilddir = 1
augroup iec_group
  au!
  au! BufNewFile,BufReadPost *.{il,st} set filetype=iec
  au FileType iec setlocal sw=2 ts=2 expandtab
  au FileType iec let Comment="(*" | let EndComment="*)"
  au FileType iec RainbowToggleOn
augroup END
" }}}

" {{{ LaTeX
" References:
" [0] https://castel.dev/post/lecture-notes-1/
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_close_braces = 1
let g:tex_conceal='abdmg'

" Configure deoplete source
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

augroup tex_group
  au!
  au FileType tex set sw=2
  au FileType tex call Togglegjgk()
  au FileType tex set spell! spelllang=en_us,ru_yo
  au FileType tex nnoremap <buffer> <silent> <leader>p :call pasteimage#LatexClipboardImage()<CR>
  au FileType tex nnoremap <buffer> <silent> <leader>з :call pasteimage#LatexClipboardImage()<CR>
augroup end
" }}}

" {{{ reStructuredText
" Settings for gu-fan/riv.vim. I don't use it nowdays.
" Disable auto-folding on `:w`
let g:riv_fold_auto_update=0
" The position of fold info
let g:riv_fold_info_pos='left'

augroup rst_group
  au!
  au FileType rst setlocal sw=4 ts=4 expandtab
  au FileType rst setlocal textwidth=80
  au Filetype rst setlocal foldmethod=expr
  au FileType rst set spell! spelllang=en_us,ru_ru
  au FileType rst call Togglegjgk()
augroup END
" }}}

" {{{ JSON
let g:vim_json_syntax_conceal = 0
au FileType json syntax match Comment +\/\/.\+$+
" }}}

" {{{ Markdown
let g:markdown_fenced_languages = ['python', 'bash=sh', 'c', 'cpp', 'asm', 'go', 'python', 'ocaml', 'cmake', 'diff', 'yaml', 'haskell', 'json', 'tex', 'plantuml']
augroup markdown_group
  au!
  au FileType markdown set nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
  au FileType markdown set spell! spelllang=en_us,ru_yo
  au FileType markdown call Togglegjgk()
  " Folding by Tab like org-mode
  au FileType markdown nnoremap <buffer> <Tab> za<CR>k
  au FileType markdown nnoremap <buffer> <S-Tab> zA<CR>k
  " Insert code blocks
  au FileType markdown nnoremap <buffer> <leader>' i``
  au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
  au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
  au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
  " Abbrevations
  au FileType markdown inoremap <buffer> --<space> –<space>
  au FileType markdown inoremap <buffer> -><space> →<space>
  au FileType markdown inoremap <buffer> =><space> ⇒<space>
  " Paste links to URL from clipboard
  au FileType markdown nnoremap <buffer> <leader>L i()<Esc>hpl%i[]<C-o>h
  au FileType markdown nnoremap <buffer> <leader>Д i()<Esc>hpl%i[]<C-o>h
  au FileType markdown nnoremap <buffer> <leader>l i<><Esc>hpl
  au FileType markdown nnoremap <buffer> <leader>д i<><Esc>hpl
  " Paste image from clipboard
  au FileType markdown nnoremap <buffer> <silent> <leader>p :call pasteimage#MarkdownClipboardImage()<CR>
  au FileType markdown nnoremap <buffer> <silent> <leader>з :call pasteimage#MarkdownClipboardImage()<CR>
  " Generate TOC using https://github.com/ekalinin/github-markdown-toc.go
  au FileType markdown nnoremap <buffer> <leader>T :read !gh-md-toc --hide-footer --hide-header %:p<CR>
augroup end

" Markdown preview in web-browser
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" Open preview in a new firefox window
" [1]: https://github.com/iamcco/markdown-preview.nvim/issues/19#issuecomment-464338238
function! g:OpenBrowser(url)
  silent exec "!/home/jubnzv/.local/bin/firefox -new-window " . a:url " &"
endfunction
let g:mkdp_browserfunc = 'g:OpenBrowser'
cnoreabbrev mp MarkdownPreview
au FileType markdown nmap <silent> <leader>M :MarkdownPreview<CR>
" }}}

" {{{ org-mode
augroup org_mode_group
    au!
    au! BufNewFile,BufReadPost *.org set filetype=org
augroup END
" }}}

" {{{ wiki.vim
let g:wiki_root = '~/Org/Notes/'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = 'md'
let g:wiki_link_target_type = 'md'
let g:wiki_mappings_use_defaults = 0
let g:wiki_mappings_global = {
  \ '<plug>(wiki-index)'            : ',wi',
  \ '<plug>(wiki-journal)'          : ',wj',
  \ '<plug>(wiki-fzf-toc)'          : ',wc',
  \ '<plug>(wiki-list-toggle)'      : '<c-s>',
  \ 'i_<plug>(wiki-list-toggle)'    : '<c-s>',
  \ '<plug>(wiki-link-open)'        : '<cr>',
  \ '<plug>(wiki-link-open-split)'  : '<c-cr>',
  \ }

" Highligth TODO and DONE entries
highlight MdTodo ctermfg=red cterm=bold guifg=red gui=bold
highlight MdDone ctermfg=green cterm=bold guifg=green gui=bold
augroup HiglightTODO
    autocmd!
    au WinEnter,VimEnter,FileType {markdown,org} :silent! call matchadd('MdTodo', 'TODO', -1)
    au WinEnter,VimEnter,FileType {markdown,org} :silent! call matchadd('MdDone', 'DONE', -1)
augroup END
" }}}

" {{{ Plant UML
au! BufNewFile,BufReadPost *.{uml,puml} set filetype=plantuml
augroup plantuml_group
    au!
    au FileType plantuml set spell! spelllang=en_us,ru_yo
augroup END
" }}}

" {{{ Other ft-specific autocommands
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
au FileType yaml setlocal ts=2 sts=2 sw=2

au FileType conf set foldmethod=marker foldenable
au Filetype css setlocal ts=4
au Filetype html setlocal ts=4

au BufNewFile,BufRead .clang-format set ft=config
au BufNewFile,BufRead .pdbrc set ft=python

" neosnippet snippets
au BufNewFile,BufRead *.snip set ft=neosnippet fdm=marker foldlevel=0 fen tw=120 ts=4 noexpandtab

" ansible playbooks
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */ops/ansible/*.yml set filetype=yaml.ansible

" buildbot configuration files
au BufNewFile,BufRead   master.cfg      set ft=python foldmethod=marker foldenable tw=120
au BufNewFile,BufRead   buildbot.tac    set ft=python foldmethod=marker foldenable tw=120

" cppcheck dumps
au BufNewFile,BufRead *.c.dump      set filetype=xml tw=120
au BufNewFile,BufRead *.cpp.dump    set filetype=xml tw=120

" Taskwarrior tasks (`task <id> edit`)
au BufRead *.task /Description:

au FileType gitcommit inoremap <buffer> --<space> –<space>
au FileType gitcommit inoremap <buffer> -><space> →<space>
au FileType gitcommit inoremap <buffer> =><space> ⇒<space>
" }}}

" {{{ Toggle settings functions
if !exists('s:syn_on')      | let s:syn_on = 0      | endif
if !exists('s:gjgk_mode')   | let s:gjgk_mode = 0   | endif
if !exists('s:hex_mode')    | let s:hex_mode = 0    | endif
if !exists('s:scroll_mode') | let s:scroll_mode = 0 | endif

function! ToggleConceal()
  if (&conceallevel == 0)
    set conceallevel=1
    echo 'Enable conceal'
  else
    set conceallevel=0
    echo 'Disable conceal'
  endif
endfunction

function! ToggleSyntax()
  if s:syn_on==0
    syn on
    let s:syn_on = 1
  else
    syn off
    let s:syn_on = 0
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
  if s:gjgk_mode==0
    nnoremap j gj
    nnoremap k gk
    nnoremap gk k
    nnoremap gj j
    " echo 'Switch to gj/gk'
    let s:gjgk_mode = 1
  else
    nunmap j
    nunmap k
    nunmap gk
    nunmap gj
    " echo 'Switch to j/k'
    let s:gjgk_mode = 0
  endif
endfunction

function! ToggleHex()
  if (s:hex_mode == 0)
    execute ":%!xxd"
    let s:hex_mode = 1
  else
    execute ":%!xxd -r"
    let s:hex_mode = 0
  endif
endfunction

" Scroll all windows at the same time
function! ToggleScrollBind()
  if (s:scroll_mode == 0)
    execute ":windo set scrollbind!"
    let s:scroll_mode = 1
    echo 'Enable scrollbind'
  else
    execute ":windo set noscrollbind!"
    let s:scroll_mode = 0
    echo 'Disable scrollbind'
  endif
endfunction

nnoremap <leader>tc :call ToggleConceal()<CR>
nnoremap <leader>tg :call Togglegjgk()<CR>
nnoremap <leader>tx :call ToggleHex()<CR>
nnoremap <leader>ts :call ToggleSyntax()<CR>
nnoremap <leader>tn :call ToggleNumber()<CR>
nnoremap <leader>tS :call ToggleScrollBind()<CR>
nnoremap <leader>tp :setlocal paste!<CR>
nnoremap <leader>tC :ColorizerToggle<CR>
nnoremap <leader>tr :RainbowToggle<cr>
nnoremap <leader>tm :NeomakeToggle<cr>
nnoremap <leader>tt :TableModeToggle<cr>
" }}}

" vim:fdm=marker:fen:sw=2:tw=120
