set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" A path to Python interpreter required for some plugins.
" On Windows you should add python.exe to your system-level PATH to make it work.
" And do: pip install neovim.
" if !has('win32')
"   let g:python3_host_prog  = '/usr/bin/python3.10'
" else
"   let g:python3_host_prog  = '\Users\<>\AppData\Local\Programs\Python\Python39\python.exe'
" endif

" We have to tweak PATH on Windows to make *nix tools from git-bash work.
if has('win32')
  let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
endif

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'kshenoy/vim-signature'                 " Extended marks support
Plug 'tpope/vim-eunuch'                      " Helpers for Shell
Plug 'tpope/vim-repeat'                      " Remap . in a way that plugins can tap into it
Plug 'andymass/vim-matchup'                  " Better %
Plug 'junegunn/vim-easy-align'               " A Vim alignment plugin
Plug 'tpope/vim-surround'                    " Surround text w/ brackets
Plug 'tpope/vim-abolish'                     " Case-sensitive search/substitute/abbreviate
Plug 'jiangmiao/auto-pairs'                  " Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-rsi'                         " Readline (emacs) keybindings in command and insert modes
Plug 'osyo-manga/vim-over'                   " :substitute preview
Plug 'christoomey/vim-tmux-navigator'        " tmux integration
Plug 'tyru/open-browser.vim'                 " Plugin for openning links in the browser
Plug 'itchyny/lightline.vim'                 " Statusline plugin
Plug 'jubnzv/gruvbox'                        " Color scheme
Plug 'norcalli/nvim-colorizer.lua'           " Colorize color names and codes
Plug 'haya14busa/incsearch.vim'              " Incrementally highlight search results
Plug 'itchyny/vim-cursorword'                " Plugin to highlight the word under the cursor
Plug 'tpope/vim-fugitive'                    " Git wrapper
Plug 'cohama/agit.vim'                       " gitk clone for vim
Plug 'airblade/vim-gitgutter'                " Shows git status on a gutter column
Plug 'statox/vim-compare-lines'              " Compares symbol in two lines in the buffer
Plug 'kyazdani42/nvim-tree.lua'              " A tree explorer plugin for vim
Plug 'kyazdani42/nvim-web-devicons'          " devicons for nvim-tree.lua
Plug 'mbbill/undotree'                       " Emacs' undotree
Plug 'rhysd/git-messenger.vim'               " Reveal the commit messages under the cursor
Plug 'liuchengxu/vista.vim'                  " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'          " Auto (re)generate tag files
Plug 'terryma/vim-expand-region'             " Visually select increasingly larger regions of text
Plug 'machakann/vim-swap'                    " Reorder arguments in functions with `g>` and `g<`
Plug 'tyru/caw.vim'                          " Comment plugin
Plug 'Shougo/deoplete.nvim', {
  \ 'do': ':UpdateRemotePlugins' }           " Autocomplition
Plug 'sirver/ultisnips'                      " Snippets plugin
Plug 'honza/vim-snippets'                    " A collection of snippets
Plug 'lukas-reineke/indent-blankline.nvim'   " Display indent levels in code
Plug 'ocaml/vim-ocaml'                       " Vim runtime files for OCaml
Plug 'neovim/nvim-lspconfig'                 " Configuration for native Neovim LSP client
Plug 'jubnzv/virtual-types.nvim'             " Plugin that shows type annotations in virtual text
Plug 'Shougo/deoplete-lsp'                   " Neovim's LSP Completion source for deoplete
Plug 'sbdchd/neoformat'                      " Integration with code formatters
Plug 'jpalardy/vim-slime'                    " REPL integraion
Plug 'bfrg/vim-cpp-modern'                   " Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
Plug 'derekwyatt/vim-fswitch'                " This Vim plugin will help switching between companion files
Plug 'vim-python/python-syntax'              " Extended python syntax
Plug 'luochen1990/rainbow'                   " Rainbow Parentheses improved
Plug 'dhruvasagar/vim-table-mode'            " VIM Table Mode for instant table creation
Plug 'tpope/vim-markdown'                    " Extra settings for markdown
Plug 'masukomi/vim-markdown-folding'         " Markdown folding by sections
Plug 'jbyuki/nabla.nvim'                     " Previewing LaTeX formulas in popup windows
Plug 'iamcco/markdown-preview.nvim', {
  \ 'do': { -> mkdp#util#install() } }       " Live markdown preview in the browser
Plug 'lervag/vimtex', { 'for': ['tex'] }     " LaTeX plugin
Plug 'wlangstroth/vim-racket', {
  \ 'for': ['rkt'] }                         " Racket syntax highlight
Plug 'rust-lang/rust.vim', {
  \ 'for': ['rust'] }                        " Rust plugin
Plug 'fatih/vim-go', { 'for': ['go'] }       " (bloated) golang environment
Plug 'tomlion/vim-solidity', {
  \ 'for': ['sol'] }                         " Solidity syntax highlight
Plug 'aklt/plantuml-syntax', {
  \ 'for': ['uml', 'puml'] }                 " Syntax highlight for PlantUML
Plug 'weirongxu/plantuml-previewer.vim', {
  \ 'for': ['uml', 'puml'] }                 " Show interactive preview for PlantUML diagrams
Plug 'jubnzv/IEC.vim', {
  \ 'for': ['st', 'il'] }                    " IEC61131-3 languages
Plug 'jubnzv/vim-scilla', {
  \ 'for': ['scilla'] }                      " Scilla language (Zilliqa blockchain)
Plug 'leafgarland/typescript-vim', {
  \ 'for': ['typescript'] }                  " Typescript syntax highlight
Plug 'Cian911/vim-cadence', {
  \ 'for': ['cdc'] }                         " Cadence plugin (Flow blockchain)
Plug 'othree/xml.vim', {
  \ 'for': ['xml', 'html'] }                 " More convient working w/ html and xml tags
Plug 'whonore/Coqtail', { 'for': ['coq'] }   " Coq plugin
Plug 'florentc/vim-tla', {
  \ 'for': ['tla'] }                         " TLA+ plugin
Plug 'elzr/vim-json', {'for': ['json'] }
Plug 'jubnzv/mdeval.nvim'                    " Execute code in markdown documents
Plug 'akinsho/toggleterm.nvim'               " Wrapper for Neovim's built-in :terminal
Plug 'nvim-lua/plenary.nvim'                 " Various utilities used by other plugins
Plug 'nvim-telescope/telescope.nvim'         " Fuzzy-finder
Plug 'nvim-telescope/telescope-project.nvim' " Emacs' Projectile
Plug 'nvim-telescope/telescope-symbols.nvim' " Insert unicode symbols w/ telescope
Plug 'folke/trouble.nvim'                    " Show persistent telescope results
Plug 'nvim-treesitter/nvim-treesitter'       " tree-sitter integration
Plug 'nvim-orgmode/orgmode.nvim'             " org-mode clone

" LLVM plugin
" See: https://github.com/llvm/llvm-project/tree/master/llvm/utils/vim
if isdirectory('/home/jubnzv/Sources/llvm-project/llvm/utils/vim/')
  Plug '/home/jubnzv/Sources/llvm-project/llvm/utils/vim/'
endif

call plug#end()
" }}}

" {{{ Disable some builtin plugins
let g:loaded_gzip         = 1
let g:loaded_tar          = 1
let g:loaded_tarPlugin    = 1
let g:loaded_zipPlugin    = 1
let g:loaded_2html_plugin = 1
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
set eol
set fixeol                                  " <EOL> at the end of file will be restored if missing
set re=1                                    " Required for vista.vim: https://github.com/liuchengxu/vista.vim/issues/82
set mouse=a

" Disable syntax highlighting for large files
au BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax clear | endif

" Enable spellchecking everywhere
set spell spelllang=en_us,ru_yo

" Default conceal settings
set conceallevel=0
set concealcursor=nc

" Cyrillic layout in the normal mode
set langmap+=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ
set langmap+=фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set langmap+=ЖжЭэХхЪъ;\:\;\"\'{[}]

" Allows to open files in external program with `gx` inside netrw
let g:netrw_browsex_viewer = "xdg-open"
" }}}

" {{{ UI options
set termguicolors
set winblend=5    " Transparency for floating windows
set pumblend=5    " Transparency for popup menus

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
let g:gruvbox_italic=0
colorscheme gruvbox

" Highlighting
highlight Todo ctermfg=130 guibg=#af3a03
" }}}

" {{{ Setup neovim-qt
if (has('nvim') && len(nvim_list_uis()) > 0 && (!nvim_list_uis()[0]['ext_termcolors'] == 1))
  if has('win32')
    set guifont=JetBrainsMono\ NF:h11
  else
    " set guifont=JetBrainsMono\ NF\ \[JB\]:h11
  endif
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

  " toggleterm
  nnoremap <silent>`" <Cmd>exe v:count1 . "ToggleTerm"<CR>
  nnoremap <silent>`% <Cmd>exe v:count1 . "ToggleTerm direction=vertical size=50"<CR>
  nnoremap <silent>`t :call system('kitty -e '.shellescape(getcwd()).' &')<CR>
endif
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
nnoremap <leader>w :w<CR>

" Y yanks from the cursor to the end of line as expected. See :help Y.
nnoremap Y y$

" Replace-paste without yanking deleted lines
" nnoremap <leader>y "0y
" nnoremap <leader>p "0p

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
" NOTE: Use LSP mappings instead
" nnoremap ]e :cnext <CR>
" nnoremap [e :cprevious<CR>

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

" Tabs management
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

" Refresh content of the current buffer
nnoremap <silent> <leader>B :checktime<CR>

" Convert the ^M linebreaks to the normal linebreaks
nnoremap <silent> <leader>rl :set ff=unix<CR> :e ++ff=dos<CR>

" EOL format
menu EOL.unix :set fileformat=unix<CR>
menu EOL.dos  :set fileformat=dos<CR>
menu EOL.mac  :set fileformat=mac<CR>

" Change encoding
menu EEnc.cp1251     :e ++enc=cp1251<CR>
menu EEnc.koi8-r     :e ++enc=koi8-r<CR>
menu EEnc.cp866      :e ++enc=ibm866<CR>
menu EEnc.utf-8      :e ++enc=utf-8<CR>
menu EEnc.ucs-2le    :e ++enc=ucs-2le<CR>

" Convert file encoding
menu FEnc.cp1251    :set fenc=cp1251<CR>
menu FEnc.koi8-r    :set fenc=koi8-r<CR>
menu FEnc.cp866     :set fenc=ibm866<CR>
menu FEnc.utf-8     :set fenc=utf-8<CR>
menu FEnc.ucs-2le   :set fenc=ucs-2le<CR>

" Remove all trailing whitespaces
nnoremap <silent> <leader>rs :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" ё -> е
nnoremap <silent> <leader>r` :%s/ё/е/g<cr>

" Find all cyrillic characters
nnoremap <silent> <leader>/c /[\d1040-\d1103]<cr>

" Re-select the text you just pasted
nnoremap gp `[v`]

" Switch to the recent buffer
nnoremap <A-r> <C-^>

" Use Ctrl-W operation in insert mode
inoremap <C-w> <C-g>u<C-w>

" {{{ Copy file path to the system clipboard
if has('win32')
  nmap <silent> <leader>cr :let @+=substitute(expand("%"), "/", "\\", "g")<CR>:echo "Copied: " . expand("%")<CR>
  nmap <silent> <leader>ca :let @+=substitute(expand("%:p"), "/", "\\", "g")<CR>:echo "Copied: " . expand("%:p")<CR>
else
  nmap <silent> <leader>cr :let @+=expand("%")<CR>:echo "Copied: " . expand("%")<CR>
  nmap <silent> <leader>ca :let @+=expand("%:p")<CR>:echo "Copied: " . expand("%:p")<CR>
endif
" }}}

" {{{ gF with column support
function! GoToColumnInFile (fileInfoString)
  let fileInfo = split(a:fileInfoString, ":")
  let column = 0
  normal! gF
  if len(fileInfo) > 2
    " Cut trailing `"`
    let column = split(fileInfo[2], "\"")[0]
    echo column
    execute 'normal! ' . column . '|'
  endif
endfunction
nnoremap <localleader>f :call GoToColumnInFile(expand("<cWORD>"))<CR>
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
let g:buftabline_indicators=1 " show modified

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left':  [ [ 'mode', 'paste' ],
  \              [ 'readonly', 'filename', 'modified' ],
  \              [ 'current_function'] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype' ],
  \              [ 'gitbranch' ] ],
  \ },
  \ 'component_expand': {
  \   'lsp_warnings': 'LightlineLspWarnings',
  \   'lsp_errors': 'LightlineLspErrors',
  \ },
  \ 'component_function': {
  \   'filename': 'LightlineStrippedFilename',
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'component_type': {
  \   'lsp_warnings': 'warning',
  \   'lsp_errors': 'error',
  \   'readonly': 'error',
  \ },
  \ }

function! LightlineLspWarnings() abort
let sl = ''
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
       let warnings = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), [[Warning]])")
       return warnings.' ◆'
    else
        return ''
    endif
    return sl
endfunction

function! LightlineLspErrors() abort
let sl = ''
    if luaeval('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
       let errors = luaeval("vim.lsp.diagnostic.get_count(vim.fn.bufnr('%'), [[Error]])")
       return errors.' ✕'
    else
        return ''
    endif
    return sl
endfunction

function! LightlineCurrentFunctionVista() abort
  let l:method = get(b:, 'vista_nearest_method_or_function', '')
  if l:method != ''
    let l:method = '[' . l:method . ']'
  endif
  return l:method
endfunction
if &loadplugins
  au VimEnter * call vista#RunForNearestMethodOrFunction()
endif

function! LightlineStrippedFilename() abort
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

" {{{ Web-browser integration (tyru/open-browser.vim)
let g:openbrowser_search_engines = extend(
\   get(g:, 'openbrowser_search_engines', {}),
\   {
\       'github': 'http://github.com/search?q={query}',
\       'github-c': 'http://github.com/search?l=C&q=language%3AC+{query}&type=Code',
\       'github-cpp': 'http://github.com/search?l=C%2B%2B&q=language%3AC%2B%2B+{query}&type=Code',
\       'github-python': 'http://github.com/search?l=Python&q=language%3APython+{query}&type=Code',
\       'github-rust': 'http://github.com/search?l=Rust&q=language%3ARust+{query}&type=Code',
\       'github-go': 'http://github.com/search?l=Go&q=language%3AGo+{query}&type=Code',
\       'github-ocaml': 'http://github.com/search?l=OCaml&q=language%3AOCaml+{query}&type=Code',
\       'github-vimscript': 'http://github.com/search?l=Vim+Script&language%3Avimscript+{query}&type=Code',
\       'grep-app': 'https://grep.app/search?q={query}&case=true',
\       'google': 'http://google.com/search?q={query}',
\       'yandex-translate-en-ru': 'https://translate.yandex.ru/?lang=en-ru&text={query}',
\       'ludwig-en': 'https://ludwig.guru/ru/s/{query}',
\       'debian-code-search': 'https://codesearch.debian.net/search?q={query}',
\       'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\       'hotexamples': 'https://cpp.hotexamples.com/search/{query}',
\       'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
\       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
\   },
\   'keep'
\)
let g:openbrowser_default_search = 'google'

function! s:JbzGetVisual()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return substitute(l:ret, '\n\+$', '', '') " chomp
endfunction

function! s:JbzSetOpenbrowserBindings(keybind, name)
  silent! exe 'nnoremap <silent> ' . a:keybind . " :call openbrowser#smart_search(expand('<cword>'), " . '"' . a:name . '")<CR>'
  silent! exe 'vnoremap <silent> ' . a:keybind . ' :<C-U>execute "call openbrowser#smart_search(\"" . <SID>JbzGetVisual() . "\", \"' . a:name . '\")"<CR>'
endfunction

nnoremap <silent> <leader>os <Plug>(openbrowser-smart-search)
call s:JbzSetOpenbrowserBindings("<leader>osg", "google")
call s:JbzSetOpenbrowserBindings("<leader>otr", "yandex-translate-en-ru")
call s:JbzSetOpenbrowserBindings("<leader>otl", "ludwig-en")
call s:JbzSetOpenbrowserBindings("<leader>ogs", "github")
call s:JbzSetOpenbrowserBindings("<leader>ogc", "github-c")
call s:JbzSetOpenbrowserBindings("<leader>ogx", "github-cpp")
call s:JbzSetOpenbrowserBindings("<leader>ogp", "github-python")
call s:JbzSetOpenbrowserBindings("<leader>ogr", "github-rust")
call s:JbzSetOpenbrowserBindings("<leader>ogg", "github-go")
call s:JbzSetOpenbrowserBindings("<leader>ogo", "github-ocaml")
call s:JbzSetOpenbrowserBindings("<leader>ogv", "github-vimscript")
call s:JbzSetOpenbrowserBindings("<leader>osa", "grep-app")
call s:JbzSetOpenbrowserBindings("<leader>osh", "hotexamples")
call s:JbzSetOpenbrowserBindings("<leader>osx", "cppreference")
call s:JbzSetOpenbrowserBindings("<leader>osq", "qt")
call s:JbzSetOpenbrowserBindings("<leader>osp", "python")
" }}}

" {{{ vim-maximizer
let g:maximizer_default_mapping_key = '<localleader>z'
let g:maximizer_restore_on_winleave = 0
let g:maximizer_handle_window_resize = 1
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
  echoerr "cmd=" . cmd
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
set nofoldenable " Disable folding when openning a file
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

" {{{ Highlight specific lines
highlight LineHighlight ctermbg=darkgray guibg=#458588
nnoremap <silent><leader>m :call matchadd('LineHighlight', '\%'.line('.').'l')<cr>
nnoremap <silent><leader>M :call clearmatches()<cr>
" }}}

" {{{ UndoTree
nnoremap <A-U> :UndotreeToggle<cr>
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

" {{{ ctags and vista.vim
set tags=./tags;
let g:gutentags_ctags_exclude = [
  \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']
" Guttentags will exclude files from wildignore settings
let g:gutentags_ctags_exclude_wildignore = 1

let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']

" Copy current function name to system clipboard.
function! FunctionNameToClipboard() abort
  redir @+
    let l:method = get(b:, 'vista_nearest_method_or_function', '')
    echon l:method
  redir END
endfunction
nnoremap <leader>yf :call FunctionNameToClipboard()<cr>

nnoremap <silent> <A-6> :Vista!!<CR>
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

" Otherwise autocompletion in Telescope writes to files when typing <Enter>.
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

call deoplete#custom#source('_',
  \ 'matchers', ['matcher_full_fuzzy'])

set completeopt-=preview

" Add Icons for LSP_KINDS.
" See: https://github.com/deoplete-plugins/deoplete-lsp/pull/46/files
let g:deoplete#lsp#use_icons_for_candidates = 1
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

" Enable for debugging
" let g:neoformat_verbose = 1

let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_java = ['astyle']
let g:neoformat_enabled_python = ['autopep8']
" let g:neoformat_enabled_ocaml = ['ocpindent']
let g:neoformat_enabled_ocaml = ['ocamlformat']
let g:neoformat_enabled_lua = ['luaformatter']
let g:neoformat_enabled_haskell = ['ormolu']
let g:neoformat_enabled_scilla = ['scilla_fmt']
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

" {{{ Git workflow
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>(GitGutTerPrevHunk)
nmap ]v <Plug>(GitGutterNextHunk)
nmap <leader>v- <Plug>(GitGutterStageHunk)
nmap <leader>v_ <Plug>(GitGutterUndoHunk)
nmap <leader>vr <Plug>(GitGutterRefresh)
nmap <localleader>v <Plug>(GitGutterPreviewHunk)
nmap <localleader>b <Plug>(git-messenger)
nmap <localleader>vs :Git<cr>
nmap <localleader>vp :Gpull<cr>
nmap <localleader>vP :Gpush 
nmap <localleader>vD :Git! diff<cr>
nmap <localleader>vb :Git blame<cr>
nmap <localleader>vf :GFiles<cr>
nmap <localleader>vl :Agit<cr>

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

" {{{ :terminal
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoscroll = 1
if has('win32')
  let g:neoterm_eof = "\r"
  let g:neoterm_shell = "powershell.exe"
endif
" }}}

" {{{ nvim-tree.lua
nnoremap <silent><A-0> :NvimTreeToggle<CR>
hi NvimTreeIndentMarker guifg=#3c3836
hi NvimTreeFolderIcon guifg=#7c6f64
hi NvimTreeGitDirty guifg=#689d6a
lua << EOF
require 'nvim-tree'.setup{
  git                 = { ignore = true },
  disable_netrw       = true,
  update_focused_file = { enable = true },
  update_cwd          = true,
  filters             = { custom = { '.git', 'node_modules', '.cache', '__pycache__', '.clangd' } },
}
EOF
" }}}

" {{{ telescope.nvim and related plugins
lua << EOF
local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")
telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
}
telescope.load_extension("project")
EOF
nnoremap <A-p>      <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>b  <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader>fp <cmd>lua require'telescope'.extensions.project.project{}<cr>
nnoremap <A-u> <cmd>lua require('telescope.builtin').spell_suggest()<cr>
nnoremap gr <cmd>lua require('telescope.builtin').lsp_references()<cr>
nnoremap gs <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap gd <cmd>lua require('telescope.builtin').lsp_definitions()<cr>
nnoremap gi <cmd>lua require('telescope.builtin').lsp_implementations()<cr>
nnoremap <localleader>a <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
nnoremap <localleader>vc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <localleader>vC <cmd>lua require('telescope.builtin').git_bcommits()<cr>
nnoremap <localleader>vB <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <localleader>vS <cmd>lua require('telescope.builtin').git_stash()<cr>

nnoremap <A-e> <cmd>lua require'telescope.builtin'.symbols{ sources = {'emoji', 'math', 'latex'} }<cr>
inoremap <A-e> <C-O>:lua require'telescope.builtin'.symbols{ sources = {'emoji', 'math', 'latex'} }<cr>

nnoremap <leader>pn <cmd>lua require('telescope.builtin').find_files({prompt_title = "Notes", cwd = "~/Org/Notes/"})<cr>
nnoremap <leader>pm <cmd>lua require('telescope.builtin').find_files({prompt_title = "org-mode", cwd = "~/Org/org-mode"})<cr>

" {{{ Poor man's Zettelkasten
lua << END
local home = vim.fn.expand("~/Org/Notes/")
local builtin = require("telescope.builtin")
function backlinks()
  local filename = vim.fn.expand("%:t")
  builtin.live_grep({
    results_title = "Backlinks to " .. filename,
    prompt_title = "Search",
    cwd = home,
    search_dirs = { home },
    default_text = "\\[.*\\]\\((./)?" .. filename .. "(#.+)*\\)",
    find_command = { "fd" },
  })
end
END
if !empty('/home/jubnzv/.config/nvim/data/telescope-sources/zettel_tags.json')
  nnoremap <leader>, <cmd>lua require'telescope.builtin'.symbols{ sources = {'zettel_tags'} }<cr>
endif
" }}}
" }}}

" {{{ mdeval.nvim
lua << EOF
require('mdeval').setup({
  require_confirmation = false,
  exec_timeout = 5,
  eval_options = {
    cpp = {
      default_header = [[
#include <iostream>
#include <vector>
using namespace std;
      ]],
      command = {"clang++", "-std=c++20", "-O0"},
    },
    racket = {
      command = {"racket"},
      language_code = "racket",
      exec_type = "interpreted",
      extension = "rkt",
    },
  }
})
vim.api.nvim_set_keymap('n', '<localleader>c',
                        "<cmd>lua require 'mdeval'.eval_code_block()<CR>",
                        {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<localleader>C',
                        "<cmd>lua require 'mdeval'.eval_clean_results()<CR>",
                        {silent = true, noremap = true})
EOF
" }}}

" {{{ nvim-colorizer.lua
lua << EOF
require'colorizer'.setup {
  'yml',
  'css',
  'javascript',
  'html',
  'markdown',
  'conf',
  'plantuml',
}
require 'colorizer'.setup {
  '*';
  markdown = { names = false };
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
}
EOF
" }}}

" {{{ vim-cursorword
let g:cursorword_highlight = 0
highlight CursorWord0 ctermbg=237 guibg=#3c3836
" }}}

" {{{ Built-in LSP server and related settings: keybinginds, helper plugins, etc.
lua << EOF
local lsp = require('lspconfig')
local virtualtypes = require('virtualtypes')

-- General LSP options
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text=false,
    update_in_insert = false,
  }
)

if vim.fn.executable('clangd') then
  lsp.clangd.setup {
    cmd = { "clangd",
            "--background-index",
            "--header-insertion=iwyu",
            "--header-insertion-decorators",
            "--suggest-missing-includes",
            "--completion-style=detailed",
            "--clang-tidy",
           },
  }
end

if vim.fn.executable('pylsp') then
  lsp.pylsp.setup { }
end

if vim.fn.executable('gopls') then
  lsp.gopls.setup { }
end

if vim.fn.executable('rust-analyzer') then
  lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
        assist = {
          importGranularity = "module",
          importPrefix = "by_self",
        },
        cargo = {
          loadOutDirsFromCheck = true
        },
        procMacro = {
          enable = true
        },
      }
    }
})
end

if vim.fn.executable('ocamllsp') then
  lsp.ocamllsp.setup { on_attach=virtualtypes.on_attach }
end
EOF

nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gh <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <localleader>r <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap ]e <cmd>lua vim.diagnostic.goto_next()<CR>
nnoremap [e <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> <localleader>d <cmd>lua vim.diagnostic.open_float()<CR>
" }}}

" {{{ C and C++
" {{{ Clang-format function
function! s:JbzClangFormat(first, last)
  let l:winview = winsaveview()
  execute a:first . "," . a:last . "!clang-format"
  call winrestview(l:winview)
endfunction
command! -range=% JbzClangFormat call <sid>JbzClangFormat (<line1>, <line2>)
" }}}

" {{{ Clang include fixer
function! s:JbzClangIncludeFixer(first, last)
  let l:winview = winsaveview()
  " execute pyf clang-include-fixer
  call winrestview(l:winview)
endfunction
command! -range=% JbzClangIncludeFixer call <sid>JbzClangIncludeFixer (<line1>, <line2>)
" }}}

" {{{ Function to remove my debug prints
function! s:JbzRemoveDebugPrints()
  let save_cursor = getcurpos()
  :g/\/\/\ prdbg$/d
  call setpos('.', save_cursor)
endfunction
command! JbzRemoveDebugPrints call s:JbzRemoveDebugPrints()
" }}}

" {{{ Open stdman manpage for the word over cursor
function! s:JbzCppMan()
    let old_isk = &iskeyword
    setl iskeyword+=:
    let str = expand("<cword>")
    let &l:iskeyword = old_isk
    execute 'Man ' . str
endfunction
command! JbzCppMan :call s:JbzCppMan()
" }}}

" {{{ Set GNU coding style: https://gcc.gnu.org/wiki/FormattingCodeForGCC
function! s:SetGNUStyle()
  setlocal cindent
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal textwidth=79
  setlocal fo-=ro fo+=cql
endfunction
command! SetGNUStyle call s:SetGNUStyle()
" }}}

augroup qt_group
  au!
  au BufNewFile,BufReadPost *.ui set filetype=xml
  au FileType xml nnoremap <buffer><leader>qd :!designer %:p<cr>
augroup END

augroup c_cxx_group
  au!
  au FileType c,cpp setlocal commentstring=//\ %s
  au FileType c,cpp setlocal tw=80
  au FileType cpp nnoremap <buffer>K :JbzCppMan<CR>
  " Remove debug prints created with snippets
  au FileType c,cpp nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
  " Autoformatting with clang-format
  au FileType c,cpp nnoremap <buffer><leader>lf :<C-u>JbzClangFormat<CR>
  au FileType c,cpp vnoremap <buffer><leader>lf :JbzClangFormat<CR>
  " Align statements relative to case label
  au FileType c,cpp setlocal cinoptions+=l1
  " Include fixer
  au FileType c,cpp nnoremap <buffer><leader>li :<C-u>JbzClangIncludeFixer<CR>
  au FileType c,cpp vnoremap <buffer><leader>li :JbzClangIncludeFixer<CR>
  au FileType c,cpp RainbowToggleOn
  au BufEnter *.h let b:fswitchdst = "c,cpp,m,cc" | let b:fswitchlocs = 'reg:|include.*|src/**|'
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

augroup cmm_group
  au!
  " Set the correct filetype for C-- IR dumps.
  au BufNewFile,BufReadPost *.cmm set filetype=c
augroup END
" }}}

" {{{ Go
augroup go_group
  au!
  au FileType go RainbowToggleOn
  au FileType go nmap <buffer> <silent><A-o> <Nop>
  au FileType go nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
augroup END

" fatih/vim-go settings
let g:go_fmt_autosave = 0
" }}}

" {{{ Solidity
augroup sol_group
  au!
  au FileType solidity RainbowToggleOn
  au FileType solidity nmap <buffer> <silent><A-o> <Nop>
  au FileType solidity nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
augroup END
" }}}

" {{{ Rust
augroup rust_group
  au!
  au FileType rust RainbowToggleOn
  au FileType rust nmap <buffer> <silent><A-o> <Nop>
  au FileType rust nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
augroup END
" }}}

" {{{ Lua
augroup lua_group
  au!
  au FileType lua RainbowToggleOn
  au FileType lua setlocal sw=2 ts=2 expandtab
  au FileType lua nmap <buffer> <silent><A-o> <Nop>
augroup END
" }}}

" {{{ Javascript & others
augroup js_group
  au!
  au FileType javascript setlocal sw=2 ts=2 expandtab
  au FileType javascript RainbowToggleOn
  au FileType javascript nmap <buffer> <silent><A-o> <Nop>
augroup END

augroup ts_group
  au!
  au FileType typescript setlocal sw=2 ts=2 expandtab
  au FileType typescript RainbowToggleOn
  au FileType typescript nmap <buffer> <silent><A-o> <Nop>
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
  au FileType python nmap <buffer> <silent><A-o> <Nop>
augroup END
" }}}

" {{{ OCaml and other MLs
" Merlin
" See: https://github.com/ocaml/merlin/wiki/vim-from-scratch
" if executable("opam")
"   let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
"   execute "set rtp+=" . g:opamshare . "/merlin/vim"
" endif

augroup ocaml_group
  au!
  au FileType ocaml setlocal tabstop=2 shiftwidth=2
  au FileType ocaml,dune RainbowToggleOn
  au FileType dune setlocal foldmethod=marker
  au FileType ocaml nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "utop"<CR>
  au FileType ocaml inoremap <A-1> `
  au FileType ocaml nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>

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

" A few hacks for the menhir parser generator.
augroup menhir_group
  au!
  au BufNewFile,BufRead *.mly setlocal comments+=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/
  au BufNewFile,BufRead *.mly setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
  au BufNewFile,BufRead *.mly syn region ocamlComment start="/\*" end="\*/" contains=@Spell,ocamlComment,ocamlTodo
augroup END

" cppo files are preprocessed OCaml: https://github.com/ocaml-community/cppo
au BufNewFile,BufRead *.ml.cppo setlocal ft=ocaml
au BufNewFile,BufRead *.mlg.cppo setlocal ft=ocaml

" PolyML sources
au BufNewFile,BufRead *.ML setlocal ft=sml

" ML-Yacc & ML-Lex
au BufNewFile,BufRead *.grm setlocal ft=sml
au BufNewFile,BufRead *.lex setlocal ft=sml

" SML interfaces
au BufNewFile,BufRead *.sig setlocal ft=sml
au BufEnter *.sig let b:fswitchdst = 'sml' | let b:fswitchlocs = 'ifrel:/././' | let b:fsnonewfiles = 1
au BufEnter *.sml let b:fswitchdst = 'sig' | let b:fswitchlocs = 'ifrel:/././' | let b:fsnonewfiles = 1
" }}}

" {{{ Coq
function! g:CoqtailHighlight()
  hi def CoqtailChecked guibg=#283f28
  hi def CoqtailSent guibg=#28373f
endfunction

augroup coq_group
  au!
  au FileType coq-goals set nonu nornu
  au FileType coq-infos set nonu nornu
  au BufNewFile,BufReadPost *.vy set filetype=ocaml
augroup END

" Coq files preprocessed with cppo: https://github.com/ocaml-community/cppo
au BufNewFile,BufRead *.v.cppo setlocal ft=coq
" }}}

" {{{ Scilla
augroup scilla_group
  au!
  au FileType scilla setlocal tabstop=2 shiftwidth=2
  au FileType scilla setlocal nospell
augroup END
au BufNewFile,BufRead *.scilexp setlocal syntax=scilla
" }}}

" {{{ Racket and other Lisps/Schemes
augroup rkt_group
  au!
  " au FileType racket inoremap <A-1> `()<Esc>i
  au FileType racket inoremap <A-1> `
  au FileType racket inoremap <A-2> '
  au FileType racket inoremap <A-3> λ
  au FileType racket setlocal foldmethod=marker
  au FileType racket setlocal commentstring=;\ %s
  au FileType racket nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "racket"<CR>
  au FileType racket RainbowToggleOn
augroup END

augroup rkt_group
  au!
  au FileType scheme RainbowToggleOn
augroup END
" }}}

" {{{ vimscript
let g:vim_indent_cont = 2
augroup vim_group
  au!
  au FileType vim setlocal sw=2 ts=2 expandtab
  au FileType vim setlocal foldmethod=marker foldlevel=0 foldenable
  au FileType vim nnoremap <silent><buffer> K <Esc>:help <C-R><C-W><CR>
  au FileType help noremap <buffer> q :q<cr>
augroup END
" }}}

" {{{ TLA+
augroup tla_group
  au!
  au FileType tla setlocal sw=2 ts=2 expandtab
augroup END
" }}}

" {{{ IEC61131-3
augroup iec_group
  au!
  au! BufNewFile,BufReadPost *.{il,st} set filetype=iec
  au FileType iec setlocal sw=2 ts=2 expandtab
  au FileType iec let Comment="(*" | let EndComment="*)"
  " au FileType iec RainbowToggleOn
augroup END
" }}}

" {{{ z3 and smt-lib2
augroup smt_group
  au!
  au! BufNewFile,BufReadPost *.{z3,smt2} set filetype=smt2
  " au FileType smt2 RainbowToggleOn
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
" call deoplete#custom#var('omni', 'input_patterns', {
"      \ 'tex': g:vimtex#re#deoplete
"      \})

augroup tex_group
  au!
  au FileType tex set sw=2
  au FileType tex call Togglegjgk()
  " au FileType tex setlocal spell! spelllang=en_us,ru_yo
  au FileType tex nnoremap <buffer> <silent> <leader>pi :call pasteimage#LatexClipboardImage()<CR>
  au FileType tex nnoremap <buffer> <silent> <leader>зш :call pasteimage#LatexClipboardImage()<CR>
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
  " au FileType rst setlocal spell! spelllang=en_us,ru_ru
  au FileType rst call Togglegjgk()
augroup END
" }}}

" {{{ JSON
augroup json_group
  au!
  let g:vim_json_syntax_conceal = 0
  au FileType json syntax match Comment +\/\/.\+$+
  au FileType json setlocal ts=2 sts=2 sw=2
augroup END
" }}}

" {{{ orgmode.nvim
lua << EOF
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTeX highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/Org/org-mode/*.org'},
  org_default_notes_file = '~/Org/org-mode/Notes.org',
  -- Statuses adopted from the xit format: https://xit.jotaen.net/:
  --  <no mark> - todo
  --  @         - ongoing
  --  x         - done
  --  ~         - obsolete
  org_todo_keywords = { '@', '|', 'x', '~' },
  notifications = {
    enabled = true,
    cron_enabled = true,
    reminder_time = 30,
    deadline_reminder = true,
    scheduled_reminder = false,
    notifier = function(tasks)
      local result = {}
      for _, task in ipairs(tasks) do
        require('orgmode.utils').concat(result, {
          string.format('# %s (%s)', task.category, task.humanized_duration),
          string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title),
          string.format('%s: <%s>', task.type, task.time:to_string())
        })
      end
      if not vim.tbl_isempty(result) then
        require('orgmode.notifications.notification_popup'):new({ content = result })
      end
    end,
    cron_notifier = function(tasks)
      for _, task in ipairs(tasks) do
        local title = string.format('%s (%s)', task.category, task.humanized_duration)
        local subtitle = string.format('%s %s %s', string.rep('*', task.level), task.todo, task.title)
        local date = string.format('%s: %s', task.type, task.time:to_string())
        if vim.fn.executable('notify-send') == 1 then
          vim.loop.spawn('notify-send', { args = { string.format('%s\n%s\n%s', title, subtitle, date) }})
        end
      end
    end
  },
})
EOF

highlight! OrgTSHeadlineLevel1 ctermfg=214 guifg=#fabd2f
highlight! OrgTSHeadlineLevel3 ctermfg=109 guifg=#83a598
highlight! OrgTSTag ctermfg=208 cterm=bold guifg=#fe8019 gui=bold
" }}}

" {{{ Markdown & org-mode
let g:markdown_fenced_languages = [
 \'python', 'py=python', 'bash=sh', 'c', 'cpp', 'c++=cpp',
 \'asm', 'go', 'rust', 'ocaml', 'cmake', 'diff', 'yaml', 'haskell',
 \'json', 'plantuml', 'html', 'sql', 'lua', 'racket', 'vim', 'coq',
 \'scilla', 'llvm', 'solidity'
 \]
highlight MdTodo ctermfg=red cterm=bold guifg=red gui=bold
highlight MdDone ctermfg=green cterm=bold guifg=green gui=bold
augroup markdown_group
  au!
  au FileType markdown setlocal nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
  " au FileType markdown setlocal spell! spelllang=en_us,ru_yo
  au FileType markdown call Togglegjgk()
  " Fold on <Tab> like org-mode does
  " au FileType markdown nnoremap <buffer> <Tab> za<CR>k
  " au FileType markdown nnoremap <buffer> <S-Tab> zA<CR>k
  " Insert code blocks
  au FileType markdown nnoremap <buffer> <leader>' i``
  au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
  au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
  au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
  " Create a new file if not exists.
  au FileType markdown nmap gf :e <cfile><cr>
  " Abbrevations
  au FileType markdown inoremap <buffer> --<space> –<space>
  " au FileType markdown inoremap <buffer> -><space> →<space>
  " au FileType markdown inoremap <buffer> =><space> ⇒<space>
  " au FileType markdown inoremap <buffer> <-<space> ←<space>
  " au FileType markdown inoremap <buffer> \E<space> ∃<space>
  " au FileType markdown inoremap <buffer> \A<space> ∀<space>
  " Paste image from clipboard
  au FileType markdown nnoremap <buffer> <silent> <leader>pi :call pasteimage#MarkdownClipboardImage()<CR>
  au FileType markdown nnoremap <buffer> <silent> <leader>шз :call pasteimage#MarkdownClipboardImage()<CR>
  " Paste URL link from clipboard
  au FileType markdown nnoremap <buffer> <leader>pl a[]()<Esc>hpl%hi
  au FileType markdown nnoremap <buffer> <leader>зд a[]()<Esc>hpl%hi
  " Generate TOC using https://github.com/ekalinin/github-markdown-toc.go
  au FileType markdown nnoremap <buffer> <leader>T :read !gh-md-toc --hide-footer --hide-header %:p<CR>
  " Open Zettelkasten prompt
  au FileType markdown nnoremap <buffer> <localleader>zb :lua backlinks()<CR>
  " Preview LaTeX formulas
  au FileType markdown nnoremap <buffer> <localleader>p :lua require("nabla").popup()<CR>
  au FileType markdown nnoremap <buffer> <localleader>з :lua require("nabla").popup()<CR>
augroup end

" Markdown preview in web-browser
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" Open preview in the new firefox window
" [1]: https://github.com/iamcco/markdown-preview.nvim/issues/19#issuecomment-464338238
function! g:OpenBrowser(url)
  silent exec "!/opt/firefox/firefox -new-window " . a:url " &"
endfunction
let g:mkdp_browserfunc = 'g:OpenBrowser'
cnoreabbrev MP MarkdownPreview

" Highligth TODO and DONE entries.
augroup todo_group
  au!
  au WinEnter,VimEnter,FileType markdown,org syntax match todoCheckbox "\[\ \]" conceal cchar=
  au WinEnter,VimEnter,FileType markdown,org syntax match todoCheckbox "\[x\]" conceal cchar=
  au WinEnter,VimEnter,FileType markdown :silent! call matchadd('MdTodo', 'TODO', -1)
  au WinEnter,VimEnter,FileType markdown :silent! call matchadd('MdDone', 'DONE', -1)
augroup end
" }}}

" {{{ Plant UML
au! BufNewFile,BufReadPost *.{uml,puml} set filetype=plantuml
augroup plantuml_group
    au!
    " au FileType plantuml setlocal spell! spelllang=en_us,ru_yo
augroup END
" }}}

" {{{ Other ft-specific autocommands
au! BufNewFile,BufReadPost *.{yaml,yml,sublime-syntax} set filetype=yaml foldmethod=indent
au FileType yaml setlocal ts=2 sts=2 sw=2

au FileType conf set foldmethod=marker foldenable
au Filetype css setlocal ts=4
au Filetype html setlocal ts=4

" gno language: https://gno.land/
au BufNewFile,BufRead *.gno setlocal syntax=go

au BufNewFile,BufRead .clang-format setlocal ft=config
au BufNewFile,BufRead .pdbrc setlocal ft=python

" neosnippet snippets
au BufNewFile,BufRead *.snip setlocal ft=neosnippet fdm=marker foldlevel=0 fen tw=120 ts=4 noexpandtab

" ansible playbooks
au BufRead,BufNewFile */playbooks/*.yml set filetype=yaml.ansible
au BufRead,BufNewFile */ops/ansible/*.yml set filetype=yaml.ansible

" buildbot configuration files
au BufNewFile,BufRead   master.cfg      setlocal ft=python foldmethod=marker foldenable tw=120
au BufNewFile,BufRead   buildbot.tac    setlocal ft=python foldmethod=marker foldenable tw=120

" cppcheck dumps
au BufNewFile,BufRead *.c.dump      set filetype=xml tw=120
au BufNewFile,BufRead *.cpp.dump    set filetype=xml tw=120
" cppcheck configuration files
au BufRead,BufNewFile *cppcheck*/cfg/*.cfg set filetype=xml

autocmd FileType xml let b:did_indent = 0

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

" vim:fdm=marker:fen:sw=2:tw=120
