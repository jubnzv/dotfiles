set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
let g:python3_host_prog  = '/usr/bin/python3.8'

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'kshenoy/vim-signature'          " Extended marks support
Plug 'tpope/vim-eunuch'               " Helpers for Shell
Plug 'tpope/vim-speeddating'          " <C-a>/<C-x> for dates and timestamps
Plug 'justinmk/vim-sneak'             " The missing motion for Vim
Plug 'tpope/vim-repeat'               " Remap . in a way that plugins can tap into it
Plug 'will133/vim-dirdiff'            " Diff two directories
Plug 'andymass/vim-matchup'           " Better %
Plug 'junegunn/vim-easy-align'        " A Vim alignment plugin
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
Plug 'cohama/agit.vim'                " Git log viewer
" A tree explorer plugin for vim
Plug 'ms-jpq/chadtree', {
  \ 'branch': 'chad',
  \ 'do': ':UpdateRemotePlugins'
  \ }
Plug 'mbbill/undotree'
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
Plug 'ocaml/vim-ocaml'                 " Vim runtime files for OCaml
Plug 'jubnzv/virtual-types.nvim'       " Shows type annotations in virtual text
" Native neovim LSP client
if has('nvim-0.5')
  Plug 'neovim/nvim-lsp'
  Plug 'haorenW1025/diagnostic-nvim'  " A wrapper for neovim built in LSP diagnosis config
  " Plug 'weilbith/nvim-lsp-smag'       " Use LSP tags instead of ctags when LSP server is running
endif
" Treesitter integration
if has('nvim-0.5')
  Plug 'nvim-treesitter/nvim-treesitter'
endif
Plug 'sbdchd/neoformat'               " Integration with code formatters
Plug 'jubnzv/DoxygenToolkit.vim'      " Doxygen utilities
Plug 'editorconfig/editorconfig-vim'  " EditorConfig Vim Plugin
Plug 'jpalardy/vim-slime'             " REPL integraion
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
Plug 'wlangstroth/vim-racket'         " Racket support
Plug 'aklt/plantuml-syntax'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'othree/xml.vim', { 'for': [ 'xml', 'html' ] }
Plug 'elzr/vim-json', {'for': ['json'] }
Plug 'MTDL9/vim-log-highlighting' " Syntax highlighting for generic log files in VIM
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'jubnzv/IEC.vim'             " IEC61131-3 plugin

" LLVM plugin
" See: https://github.com/llvm/llvm-project/tree/master/llvm/utils/vim
if isdirectory('~/Dev/llvm-project/llvm/utils/vim/')
  Plug '~/Dev/llvm-project/llvm/utils/vim/'
endif

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
set fixeol                                  " <EOL> at the end of file will be restored if missing
set re=1                                    " Required for vista.vim: https://github.com/liuchengxu/vista.vim/issues/82
set mouse=a

" Add additional information in popups (VIM 8.0+ only)
if !has('nvim')
  set completeopt+=popup
  set completepopup=height:10,width:60,highlight:Pmenu,border:off
endif

" Live Substitution
" if has('nvim')
"   set inccommand=split
" endif

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
nnoremap <leader>w :w<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Insert newline without entering insert mode
" nmap zj o<Esc>k
" nmap zk O<Esc>j

" Map Ctrl-Backspace to delete previous word or selected region
inoremap <C-BS> <C-W>
cnoremap <C-BS> <C-W>

" Reload vimrc
nnoremap <localleader>R :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Killing local buffer without losing split
:command! Bc sb # | bd #

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

" Tabs managemenent
nnoremap <A-t> :tabnew<CR>
inoremap <A-t> <C-O>:tabnew<CR>
nnoremap <A-Tab> :tabnext<CR>
inoremap <A-Tab> <C-O>:tabnext<CR>
nnoremap <A-1>      1gt
inoremap <A-1> <C-O>1gt
nnoremap <A-2>      2gt
inoremap <A-2> <C-O>2gt
nnoremap <A-3>      3gt
inoremap <A-3> <C-O>3gt
nnoremap <A-4>      4gt
inoremap <A-4> <C-O>4gt
nnoremap <A-5>      5gt
inoremap <A-5> <C-O>5gt
nnoremap <A-6>      6gt
inoremap <A-6> <C-O>6gt
nnoremap <A-7>      7gt
inoremap <A-7> <C-O>7gt
nnoremap <A-8>      8gt
inoremap <A-8> <C-O>8gt
nnoremap <A-9>      9gt
inoremap <A-9> <C-O>9gt

" Find and Replace
map <leader>rs :%s///g<left><left><left>
map <leader>rl :s///g<left><left><left>

" Refresh current buffer content
nnoremap <leader>B :checktime<CR>

" Convert the ^M linebreak to 'normal' linebreaks
nnoremap <silent> <leader>rl :set ff=unix<CR> :e ++ff=dos<CR>

cnoreabbrev enc_dos e! ++enc=cp1251
cnoreabbrev enc_koi e! ++enc=koi8r
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

" {{{ indentLine configuration
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
" }}}

" {{{ Lightline
" {{{ Function to show stripped filepath
" This is modified version of:
" https://github.com/itchyny/lightline.vim/issues/87#issuecomment-324988609
function! LightLineFilename()
	let subs = split(expand('%'), "/")

    " Handle './filename' and 'filename' cases
    let subs_len = len(subs)
    if subs_len < 3
      if subs_len == 1
        return subs[0]
      endif
      if (subs_len == 2) && (subs[0] == '.')
        return subs[1]
      endif
    endif

	let name = ""
	let i = 1
	for s in subs
		let parent = name
		if  i == len(subs)
			let name = parent . '/' . s
		elseif i == 1
			let name = parent . strpart(s, 0, 2)
		else
			let name = parent . '/' . strpart(s, 0, 2)
		endif
		let i += 1
	endfor
  return name
endfunction
" }}}

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
  \   'method': 'NearestMethodOrFunction',
  \   'filename': 'LightLineFilename'
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
nnoremap <silent> <leader>os <Plug>(openbrowser-smart-search)
nnoremap <silent> <leader>osg :call openbrowser#smart_search(expand('<cword>'), "google")<CR>
" Translate
nnoremap <silent> <leader>otr :call openbrowser#smart_search(expand('<cword>'), "yandex-translate-en-ru")<CR>
" Github
nnoremap <silent> <leader>ogg :call openbrowser#smart_search(expand('<cword>'), "github")<CR>
nnoremap <silent> <leader>ogc :call openbrowser#smart_search(expand('<cword>'), "github-c")<CR>
nnoremap <silent> <leader>ogx :call openbrowser#smart_search(expand('<cword>'), "github-cpp")<CR>
nnoremap <silent> <leader>ogv :call openbrowser#smart_search(expand('<cword>'), "github-vimscript")<CR>
nnoremap <silent> <leader>ogp :call openbrowser#smart_search(expand('<cword>'), "github-python")<CR>
nnoremap <silent> <leader>ogo :call openbrowser#smart_search(expand('<cword>'), "github-ocaml")<CR>
" Documentation
nnoremap <silent> <leader>odx :call openbrowser#smart_search(expand('<cword>'), "cppreference")<CR>
nnoremap <silent> <leader>orx :call openbrowser#smart_search(expand('<cword>'), "cplusplus")<CR>
nnoremap <silent> <leader>odb :call openbrowser#smart_search(expand('<cword>'), "buildbot")<CR>
" }}}

" {{{ tmux and vim-slime configuration
" Free my prefix key
map ` <Nop>

if exists('$TMUX')
  " Execute previous command in the last active pane
  nnoremap <silent> <leader><tab> :silent !tmux send-keys -t \! Up Enter<cr>
  nnoremap <silent> <leader><leader><tab> :silent !tmux clear-history -t right && tmux send-keys -t \! C-l Up Enter<cr>
endif

" slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
let g:slime_default_config = {"socket_name": "default", "target_pane": "1.2"}
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1

" Configure slime for the right tmux pane in the current window
function! s:JbzSlimeRight()
  if !exists('$TMUX')
    echo "tmux is not running"
    return
  endif
  let win_num = split(system("tmux display-message -p '#I'"), "\n")[0]
  let sock = split($TMUX, ",")[0]
  let b:slime_config = {"socket_name": sock, "target_pane": win_num . '.2' }
  call slime#config()
endfunction
command! JbzSlimeRight call s:JbzSlimeRight()

" Open tmux pane with selected REPL and run slime configuration routine
function! s:JbzOpenSlimeREPL(repl_exe, ...)
  if !exists('$TMUX')
    echo "tmux is not running"
    return
  endif

  let cmd = a:repl_exe

  " Parse additional command to execute before running the REPL
  let cmd_aux = get(a:, 1, "")
  if !empty(cmd_aux) | let cmd = cmd_aux . " && " . cmd | endif

  call system("tmux split-window -h \"" . cmd . "\"")
  call system("tmux last-pane")
  call s:JbzSlimeRight()
endfunction
command! -nargs=+ JbzOpenSlimeREPL call s:JbzOpenSlimeREPL(<f-args>)

nnoremap <leader>sc :JbzSlimeRight
xmap <leader>ss <Plug>SlimeRegionSend
nmap <leader>ss <Plug>SlimeParagraphSend
nmap <leader>sl <Plug>SlimeLineSend
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

" {{{ CHADTree
nnoremap <A-0> <cmd>CHADopen<cr>
" }}}

" {{{ UndoTree
nnoremap <A-9> :UndotreeToggle<cr>
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
let g:grepper.side = 1
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

nnoremap <leader>ft :Tags<CR>
nnoremap <leader>xf :Files<CR>
nnoremap <A-p> :Files<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>b :Buffers<CR>
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

" Disable syntax highlighting for large files
au BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" {{{ ctags and vista.vim
set tags=./tags;
let g:gutentags_ctags_exclude = [
  \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls']
" Guttentags will exclude files from wildignore settings
let g:gutentags_ctags_exclude_wildignore = 1

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

nnoremap <silent> <C-7> :Vista!!<CR>
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
nnoremap <silent> [1 :call signature#marker#Goto('prev', 1, v:count)<cr>
nnoremap <silent> ]1 :call signature#marker#Goto('next', 1, v:count)<cr>
nnoremap <silent> [2 :call signature#marker#Goto('prev', 2, v:count)<cr>
nnoremap <silent> ]2 :call signature#marker#Goto('next', 2, v:count)<cr>
nnoremap <silent> [3 :call signature#marker#Goto('prev', 3, v:count)<cr>
nnoremap <silent> ]3 :call signature#marker#Goto('next', 3, v:count)<cr>
nnoremap <silent> [4 :call signature#marker#Goto('prev', 4, v:count)<cr>
nnoremap <silent> ]4 :call signature#marker#Goto('next', 4, v:count)<cr>
nnoremap <silent> [5 :call signature#marker#Goto('prev', 5, v:count)<cr>
nnoremap <silent> ]5 :call signature#marker#Goto('next', 5, v:count)<cr>
nnoremap <silent> [6 :call signature#marker#Goto('prev', 6, v:count)<cr>
nnoremap <silent> ]6 :call signature#marker#Goto('next', 6, v:count)<cr>
nnoremap <silent> [7 :call signature#marker#Goto('prev', 7, v:count)<cr>
nnoremap <silent> ]7 :call signature#marker#Goto('next', 7, v:count)<cr>
nnoremap <silent> [8 :call signature#marker#Goto('prev', 8, v:count)<cr>
nnoremap <silent> ]8 :call signature#marker#Goto('next', 8, v:count)<cr>
nnoremap <silent> [9 :call signature#marker#Goto('prev', 9, v:count)<cr>
nnoremap <silent> ]9 :call signature#marker#Goto('next', 9, v:count)<cr>
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
nnoremap <localleader>se :UltiSnipsEdit<CR>
" }}}

" {{{ neoformat
nnoremap <leader>lf :Neoformat<CR>

let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_java = ['astyle']
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_ocaml = ['ocpindent']
let g:neoformat_enabled_lua = ['luaformatter']

" TODO: Consider ocamlformat (need update CI for projects...)
" let g:neoformat_ocaml_ocamlformat = {
"            \ 'exe': 'ocamlformat',
"            \ 'no_append': 1,
"            \ 'stdin': 1,
"            \ 'args': ['--disable-outside-detected-project', '--name', '"%:p"', '-']
"            \ }
" let g:neoformat_enabled_ocaml = ['ocamlformat']
" }}}

" {{{ LSP-client
" Auxiliary configuration for haorenW1025/diagnostic-nvim
let g:diagnostic_enable_virtual_text = 0
call sign_define("LspDiagnosticsErrorSign", {"text" : "E", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "W", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticInformationSign", {"text" : "I", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticHintSign", {"text" : "H", "texthl" : "LspDiagnosticsHint"})
" Neovim's built-in LSP support will keep sending diagnostic messages when you're in insert mode.
let g:diagnostic_insert_delay = 1
let g:diagnostic_enable_underline = 1

function! LSPKeymap()
  nnoremap <buffer>]e :NextDiagnosticCycle<CR>
  nnoremap <buffer>[e :PrevDiagnosticCycle<CR>
endfunction
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
"}}}

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>(GitGutterPrevHunk)
nmap ]v <Plug>(GitGutterNextHunk)
nmap <localleader>v <Plug>(GitGutterPreviewHunk)
nmap <leader>v- <Plug>(GitGutterStageHunk)
nmap <leader>v_ <Plug>(GitGutterUndoHunk)
nmap <leader>vs :Gstatus<cr>
nmap <leader>vp :Gpull<cr>
nmap <leader>vP :Gpush 
nmap <leader>ve :Gedit 
nmap <leader>vd :Gdiff HEAD
nmap <leader>vD :Git! diff<cr>
nmap <leader>vb :Gblame<cr>
nmap <leader>vB :Twiggy<cr>
nmap <leader>vf :GFiles<cr>
nmap <leader>vl :Agit<cr>
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
  " Autoformatting with clang-format
  au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>
  au FileType c,cpp vnoremap <buffer><leader>lf :JbzMyClangFormat<CR>
  au FileType c,cpp nnoremap <leader>tf :ClangFormatAutoToggle<CR>
  " Align statements relative to case label
  au FileType c,cpp setlocal cinoptions+=l1
  " Include fixer
  au FileType c,cpp nnoremap <buffer><leader>l# :pyf /usr/lib/llvm-8/share/clang/clang-include-fixer.py<cr>
  " Set LSP keybindings
  au FileType c,cpp call LSPKeymap()
  au FileType c,cpp RainbowToggleOn
  au BufEnter *.h  let b:fswitchdst = "c,cpp,cc,m"
  au BufEnter *.cc let b:fswitchdst = "h,hpp"
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

" {{{ Lua
augroup lua_group
  au!
  au FileType lua RainbowToggleOn
augroup END
" }}}

" {{{ Python
" Enable extended Python syntax highlighting provided by vim-python/python-syntax.
let g:python_highlight_all = 1

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
  au Filetype python set cinoptions=:0,l1,t0,g0,(0
  au FileType python nnoremap <buffer><leader>rd :JbzRemovePdbCalls<CR>
  au FileType python nnoremap <buffer><leader>ri :!isort %<CR><CR>
  au FileType python nnoremap <buffer><leader>rd :g/pdb\.set_trace()/d<CR>
  au FileType python nnoremap <buffer><leader>sC :JbzOpenSlimeREPL ipython3 [[\ -d\ ./venv/\ ]]\ &&\ source\ venv/bin/activate<CR>
  au FileType python RainbowToggleOn
augroup END
" }}}

" {{{ OCaml and other MLs
" Merlin
" See: https://github.com/ocaml/merlin/wiki/vim-from-scratch
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

augroup ocaml_group
  au!
  au FileType ocaml inoremap <A-1> `
  au FileType dune setlocal foldmethod=marker
  au FileType ocaml nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "utop"<CR>
  au FileType ocaml setlocal tabstop=2 shiftwidth=2
  au FileType ocaml,dune RainbowToggleOn

  " Print types from .annot files.
  " au FileType ocaml nmap <buffer> <A-t> <Plug>OCamlPrintType
  " au FileType ocaml xmap <buffer> <A-t> <Plug>OCamlPrintType

  " Rebind switching keys defined at default ocaml.vim
  au FileType ocaml nmap <buffer> <silent><A-o> <Plug>OCamlSwitchEdit
  au FileType ocaml nmap <buffer> <silent><LocalLeader><A-o> <Plug>OCamlSwitchNewWin

  " FSwitch associations
  " au BufEnter *.ml  let b:fswitchdst = 'mli' | let b:fswitchlocs = 'ifrel:/././'
  " au BufEnter *.mli let b:fswitchdst = 'ml'  | let b:fswitchlocs = 'ifrel:/././'
augroup END

" PolyML sources
au BufNewFile,BufRead *.ML set ft=sml

" ML-Yacc & ML-Lex
au BufNewFile,BufRead *.grm set ft=sml
au BufNewFile,BufRead *.lex set ft=sml

" SML interfaces
au BufNewFile,BufRead *.sig set ft=sml
au BufEnter *.sig let b:fswitchdst = 'sml' | let b:fswitchlocs = 'ifrel:/././' | let b:fsnonewfiles = 1
au BufEnter *.sml let b:fswitchdst = 'sig' | let b:fswitchlocs = 'ifrel:/././' | let b:fsnonewfiles = 1
" }}}

" {{{ Racket
augroup rkt_group
  au!
  " au FileType racket inoremap <A-1> `()<Esc>i
  au FileType racket inoremap <A-1> `
  au FileType racket inoremap <A-2> '
  au FileType racket setlocal foldmethod=marker
  au FileType racket setlocal commentstring=;\ %s
  au FileType racket nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "racket"<CR>
  au FileType racket RainbowToggleOn
augroup END
" }}}

" {{{ vimscript
let g:vim_indent_cont = 2
augroup vim_group
  au!
  au FileType vim setlocal sw=4 ts=4 expandtab
  au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
  au FileType vim nnoremap <silent><buffer> K <Esc>:help <C-R><C-W><CR>
  au FileType help noremap <buffer> q :q<cr>
augroup END
" }}}

" {{{ nix language
augroup nix_group
  au!
  au FileType nix setlocal sw=2 ts=2 expandtab
  au FileType nix RainbowToggleOn
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
let g:markdown_fenced_languages = [
  \'python', 'py=python', 'bash=sh', 'c', 'cpp', 'c++=cpp',
  \'asm', 'go', 'ocaml', 'cmake', 'diff', 'yaml', 'haskell',
  \'json', 'tex', 'plantuml', 'html', 'sql', 'nix'
  \]
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
    au BufNewFile,BufReadPost *.org set filetype=org
augroup END
" }}}

" {{{ Highligth TODO and DONE entries in the documents
highlight MdTodo ctermfg=red cterm=bold guifg=red gui=bold
highlight MdDone ctermfg=green cterm=bold guifg=green gui=bold
augroup HiglightTODO
    autocmd!
    au WinEnter,VimEnter,FileType {markdown,org} syntax match todoCheckbox "\[\ \]" conceal cchar=
    au WinEnter,VimEnter,FileType {markdown,org} syntax match todoCheckbox "\[x\]" conceal cchar=
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
nnoremap <leader>ti :IndentLinesToggle<cr>
" }}}

if has('nvim')
lua require'init'.setup()
endif

" vim:fdm=marker:fen:sw=2:tw=120
