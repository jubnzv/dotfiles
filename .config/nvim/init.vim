set nocompatible
let mapleader = "\<Space>"
let maplocalleader = ","
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" A path to Python interpreter required for some plugins.
" On Windows you should add python.exe to your system's PATH to make it work.
if !has('win32')
  let g:python3_host_prog  = '/usr/bin/python3.9'
endif

" We should tweak PATH on Windows to make *nix tools work.
if has('win32')
  let $PATH = "C:\\Program Files\\Git\\usr\\bin;" . $PATH
endif

" {{{ Plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'kshenoy/vim-signature'          " Extended marks support
Plug 'tpope/vim-eunuch'               " Helpers for Shell
Plug 'tpope/vim-repeat'               " Remap . in a way that plugins can tap into it
Plug 'andymass/vim-matchup'           " Better %
Plug 'junegunn/vim-easy-align'        " A Vim alignment plugin
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'              " Case-sensitive search/substitute/abbreviate
Plug 'jiangmiao/auto-pairs'           " Insert or delete brackets, parens, quotes in pair
Plug 'tpope/vim-rsi'                  " Readline (emacs) keybindings in the command and insert modes
Plug 'osyo-manga/vim-over'            " :substitute preview
Plug 'christoomey/vim-tmux-navigator' " tmux integration
Plug 'tyru/open-browser.vim'          " Plugin for openning links in the browser
Plug 'itchyny/lightline.vim'          " Statusline plugin
Plug 'jubnzv/gruvbox'                 " Color scheme
Plug 'norcalli/nvim-colorizer.lua'    " Colorize color names and codes
Plug 'haya14busa/incsearch.vim'       " Incrementally highlight search results
Plug 'jubnzv/vim-cursorword'          " Plugin to highlight the word under the cursor
Plug 'tpope/vim-fugitive'             " Git wrapper
Plug 'cohama/agit.vim'                " gitk clone for vim
Plug 'airblade/vim-gitgutter'         " Shows git status on a gutter column
Plug 'kyazdani42/nvim-tree.lua'       " A tree explorer plugin for vim
Plug 'kyazdani42/nvim-web-devicons'   " devicons for nvim-tree.lua
Plug 'mbbill/undotree'
Plug 'rhysd/git-messenger.vim'        " Reveal the commit messages under the cursor
Plug 'phaazon/hop.nvim'               " easymotion-like plugin
Plug 'liuchengxu/vista.vim'           " Viewer & Finder for LSP symbols and tags
Plug 'ludovicchabant/vim-gutentags'   " Auto (re)generate tag files
Plug 'terryma/vim-expand-region'      " Visually select increasingly larger regions of text
Plug 'machakann/vim-swap'             " Reorder arguments in functions with `g>` and `g<`
Plug 'tyru/caw.vim'                   " Comment plugin
Plug 'sirver/ultisnips'               " Snippets plugin
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'            " A Vim plugin for visually displaying indent levels in code
Plug 'Shougo/deoplete.nvim', {
  \ 'do': ':UpdateRemotePlugins'
  \ }
Plug 'ocaml/vim-ocaml'                " Vim runtime files for OCaml
Plug 'rust-lang/rust.vim'             " Rust support
" Native neovim LSP client and friends
if has('nvim-0.5')
  Plug 'neovim/nvim-lspconfig'
  " Shows type annotations in virtual text
  Plug 'jubnzv/virtual-types.nvim'
  " Neovim's LSP Completion source for deoplete
  Plug 'Shougo/deoplete-lsp'
  " Utilities for generating statusline components from the built-in LSP client
  " Seems good, but not yet usable because status updates are too slow.
  " Plug 'nvim-lua/lsp-status.nvim'
endif
Plug 'sbdchd/neoformat'               " Integration with code formatters
Plug 'jpalardy/vim-slime'             " REPL integraion
Plug 'bfrg/vim-cpp-modern'            " Extended Vim syntax highlighting for C and C++ (C++11/14/17/20)
Plug 'wlangstroth/vim-racket'         " Vim bundle for Racket
Plug 'neovimhaskell/haskell-vim'      " Haskell plugin
Plug 'derekwyatt/vim-fswitch'         " This Vim plugin will help switching between companion files
Plug 'vim-python/python-syntax'       " Extended python syntax
Plug 'luochen1990/rainbow'            " Rainbow Parentheses improved
Plug 'dhruvasagar/vim-table-mode'     " VIM Table Mode for instant table creation
Plug 'jubnzv/vim-markdown'            " Fork of tpope's vim-markdown with patches
Plug 'masukomi/vim-markdown-folding'  " Markdown folding by sections
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'lervag/vimtex'                  " LaTeX plugin
Plug 'wlangstroth/vim-racket'         " Racket support
Plug 'aklt/plantuml-syntax'           " Syntax highlight for PlantUML
Plug 'rhysd/vim-grammarous'           " LanguageTool (https://languagetool.org/) integration
Plug 'jubnzv/IEC.vim'                 " IEC61131-3 plugin
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'othree/xml.vim', { 'for': [ 'xml', 'html' ] }
Plug 'elzr/vim-json', {'for': ['json'] }
Plug 'jubnzv/mdeval.nvim'             " A plugin that executes code in markdown documents
Plug 'akinsho/toggleterm.nvim'        " Wrapper for built-in :terminal
Plug 'nvim-lua/plenary.nvim'          " Various utilities used by other plugins
Plug 'nvim-telescope/telescope.nvim'  " Fuzzy-finder
Plug 'nvim-telescope/telescope-project.nvim' " Plugin that implements some projectile functions
Plug 'kristijanhusak/orgmode.nvim'    " org-mode clone

" LLVM plugin
" See: https://github.com/llvm/llvm-project/tree/master/llvm/utils/vim
if isdirectory('/home/jubnzv/Dev/llvm-project/llvm/utils/vim/')
  Plug '/home/jubnzv//Dev/llvm-project/llvm/utils/vim/'
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
if has('nvim-0.4')
  set termguicolors
  set winblend=5    " Transparency for floating windows
  set pumblend=5    " Transparency for popup menus
endif

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
if (has('nvim') && (!nvim_list_uis()[0]['ext_termcolors'] == 1))
  set guifont=JetBrainsMono\ Nerd\ Font:h11
  nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
  inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
  vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>

  " toggleterm
  nnoremap <silent>`" <Cmd>exe v:count1 . "ToggleTerm"<CR>
  nnoremap <silent>`% <Cmd>exe v:count1 . "ToggleTerm direction=vertical size=50"<CR>
  nnoremap <silent>`t :call system('alacritty --working-directory '.shellescape(getcwd()).' &')<CR>
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
nnoremap <leader>y "0y
nnoremap <leader>p "0p

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

" Spellchecking
map <F10> :setlocal spell! spelllang=en_us,ru_yo<CR>
imap <F10> <C-o>:setlocal spell! spelllang=en_us,ru_yo<CR>
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

" Reselect the text you just pasted
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
  \ 'component': {
  \   'gitbranch': ' %{fugitive#head()}'
  \ },
  \ 'component_expand': {
  \   'lsp_warnings': 'LightlineLspWarnings',
  \   'lsp_errors': 'LightlineLspErrors',
  \ },
  \ 'component_function': {
  \   'current_function': 'LightlineCurrentFunctionVista',
  \   'filename': 'LightlineStrippedFilename'
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

" TODO: https://github.com/nvim-lua/lsp-status.nvim is too slow. Need to revisit it later.
function! LightlineCurrentFunctionLspStatus() abort
  let l:method = get(b:, 'lsp_current_function', '')
  if l:method != ''
    let l:method = '[' . l:method . ']'
  endif
  return l:method
endfunction
" autocmd User LspDiagnosticsChanged call lightline#update()

function! LightlineCurrentFunctionVista() abort
  let l:method = get(b:, 'vista_nearest_method_or_function', '')
  if l:method != ''
    let l:method = '[' . l:method . ']'
  endif
  return l:method
endfunction
au VimEnter * call vista#RunForNearestMethodOrFunction()

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

" {{{ Web-browser integration
let g:openbrowser_search_engines = extend(
\   get(g:, 'openbrowser_search_engines', {}),
\   {
\       'github': 'http://github.com/search?q={query}',
\       'github-c': 'http://github.com/search?l=C&q=language%3AC+{query}&type=Code',
\       'github-cpp': 'http://github.com/search?l=C%2B%2B&q=language%3AC%2B%2B+{query}&type=Code',
\       'github-python': 'http://github.com/search?l=Python&q=language%3APython+{query}&type=Code',
\       'github-go': 'http://github.com/search?l=Go&q=language%3AGo+{query}&type=Code',
\       'github-ocaml': 'http://github.com/search?l=OCaml&q=language%3AOCaml+{query}&type=Code',
\       'github-rust': 'http://github.com/search?l=Rust&q=language%3APython+{query}&type=Code',
\       'github-vimscript': 'http://github.com/search?l=Vim+script&language%3Avimscript+{query}&type=Code',
\       'grep-app': 'https://grep.app/search?q={query}&case=true',
\       'google': 'http://google.com/search?q={query}',
\       'baidu': 'https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd={query}',
\       'yandex-translate-en-ru': 'https://translate.yandex.ru/?lang=en-ru&text={query}',
\       'ludwig-en': 'https://ludwig.guru/ru/s/{query}',
\       'debian-code-search': 'https://codesearch.debian.net/search?q={query}',
\       'cppreference': 'https://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={query}',
\       'hotexamples': 'https://cpp.hotexamples.com/search/{query}',
\       'qt': 'https://doc.qt.io/qt-5/search-results.html?q={query}',
\       'python': 'http://docs.python.org/dev/search.html?q={query}&check_keywords=yes&area=default',
\       'rust': 'https://doc.rust-lang.org/std/index.html?search={query}',
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
call s:JbzSetOpenbrowserBindings("<leader>osb", "baidu")
call s:JbzSetOpenbrowserBindings("<leader>otr", "yandex-translate-en-ru")
call s:JbzSetOpenbrowserBindings("<leader>otl", "ludwig-en")
call s:JbzSetOpenbrowserBindings("<leader>ogs", "github")
call s:JbzSetOpenbrowserBindings("<leader>ogc", "github-c")
call s:JbzSetOpenbrowserBindings("<leader>ogx", "github-cpp")
call s:JbzSetOpenbrowserBindings("<leader>ogp", "github-python")
call s:JbzSetOpenbrowserBindings("<leader>ogg", "github-go")
call s:JbzSetOpenbrowserBindings("<leader>ogo", "github-ocaml")
call s:JbzSetOpenbrowserBindings("<leader>ogr", "github-rust")
call s:JbzSetOpenbrowserBindings("<leader>ogv", "github-vimscript")
call s:JbzSetOpenbrowserBindings("<leader>osa", "grep-app")
call s:JbzSetOpenbrowserBindings("<leader>osh", "hotexamples")
call s:JbzSetOpenbrowserBindings("<leader>osx", "cppreference")
call s:JbzSetOpenbrowserBindings("<leader>osq", "qt")
call s:JbzSetOpenbrowserBindings("<leader>osp", "python")
call s:JbzSetOpenbrowserBindings("<leader>osr", "rust")
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

" {{{ indentLine configuration
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
" }}}

" {{{ Grammarous
nnoremap <leader>rr <Plug>(grammarous-move-to-info-window)
nnoremap <leader>ro <Plug>(grammarous-open-info-window)
nnoremap <leader>rc <Plug>(grammarous-close-info-window)
nnoremap <leader>rf <Plug>(grammarous-fixit)
nnoremap <leader>rn <Plug>(grammarous-move-to-next-error)
nnoremap <leader>rp <Plug>(grammarous-move-to-previous-error)
cnoreabbrev GC GrammarousCheck
cnoreabbrev GR GrammarousReset
" }}}

" {{{ nvim-tree
nnoremap <silent><A-0> :NvimTreeToggle<cr>

let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '__pycache__', '.clangd' ]
let g:nvim_tree_indent_markers = 1

hi NvimTreeIndentMarker guifg=#3c3836
hi NvimTreeFolderIcon guifg=#7c6f64
hi NvimTreeGitDirty guifg=#689d6a

let g:nvim_tree_icons = {
     \ 'default':      '',
     \ 'symlink':      '',
     \ 'git': {
     \   'unstaged':   "~",
     \   'staged':     "✓",
     \   'unmerged':   "",
     \   'renamed':    "➜",
     \   'untracked':  "★"
     \   },
     \ 'folder': {
     \   'default':    "",
     \   'open':       "",
     \   'empty':      "",
     \   'empty_open': "",
     \   'symlink':    "",
     \  }
     \ }

lua << EOF
require 'nvim-tree'.setup{
  disable_netrw       = true,
  update_focused_file = { enable = true }
}
EOF
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

let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_java = ['astyle']
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_ocaml = ['ocpindent']
" let g:neoformat_enabled_ocaml = ['ocamlformat']
let g:neoformat_enabled_lua = ['luaformatter']
let g:neoformat_enabled_rust = ['rustfmt']
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

nmap [v <Plug>(GitGutterPrevHunk)
nmap ]v <Plug>(GitGutterNextHunk)
nmap <leader>v- <Plug>(GitGutterStageHunk)
nmap <leader>v_ <Plug>(GitGutterUndoHunk)
nmap <leader>vr <Plug>(GitGutterRefresh)
nmap <localleader>v <Plug>(GitGutterPreviewHunk)
nmap <localleader>b <Plug>(git-messenger)
nmap <localleader>vs :Git<cr>
nmap <localleader>vp :Gpull<cr>
nmap <localleader>vP :Gpush 
nmap <localleader>ve :Gedit 
nmap <localleader>vd :Gdiff HEAD
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
augroup END
" }}}

" {{{ Rust
augroup rust_group
  au!
  au FileType rust RainbowToggleOn
  au FileType rust nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>
  au FileType rust nmap <buffer> <silent><A-o> <Nop>
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

" {{{ Javascript
augroup js_group
  au!
  au FileType javascript setlocal sw=2 ts=2 expandtab
  au FileType javascript RainbowToggleOn
  au FileType javascript nmap <buffer> <silent><A-o> <Nop>
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
  au FileType racket inoremap <A-3> λ
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
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

augroup tex_group
  au!
  au FileType tex set sw=2
  au FileType tex call Togglegjgk()
  au FileType tex setlocal spell! spelllang=en_us,ru_yo
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
  au FileType rst setlocal spell! spelllang=en_us,ru_ru
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
 \'json', 'plantuml', 'html', 'sql', 'lua', 'racket', 'vim'
 \]
augroup markdown_group
  au!
  au FileType markdown setlocal nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
  au FileType markdown setlocal spell! spelllang=en_us,ru_yo
  au FileType markdown call Togglegjgk()
  " Fold on <Tab> like org-mode does
  " au FileType markdown nnoremap <buffer> <Tab> za<CR>k
  " au FileType markdown nnoremap <buffer> <S-Tab> zA<CR>k
  " Insert code blocks
  au FileType markdown nnoremap <buffer> <leader>' i``
  au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
  au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
  au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
  " Abbrevations
  " au FileType markdown inoremap <buffer> --<space> –<space>
  " au FileType markdown inoremap <buffer> -><space> →<space>
  " au FileType markdown inoremap <buffer> =><space> ⇒<space>
  " au FileType markdown inoremap <buffer> <-<space> ←<space>
  " au FileType markdown inoremap <buffer> \E<space> ∃<space>
  " au FileType markdown inoremap <buffer> \A<space> ∀<space>
  " Paste image from clipboard
  au FileType markdown nnoremap <buffer> <silent> <leader>p :call pasteimage#MarkdownClipboardImage()<CR>
  " Paste URL link from clipboard
  au FileType markdown nnoremap <buffer> <leader>P a[]()<Esc>hpl%hi
  " Generate TOC using https://github.com/ekalinin/github-markdown-toc.go
  au FileType markdown nnoremap <buffer> <leader>T :read !gh-md-toc --hide-footer --hide-header %:p<CR>
augroup end

" Markdown preview in web-browser
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 0
" Open preview in the new firefox window
" [1]: https://github.com/iamcco/markdown-preview.nvim/issues/19#issuecomment-464338238
function! g:OpenBrowser(url)
  silent exec "!/opt/firefox/firefox-bin -new-window " . a:url " &"
endfunction
let g:mkdp_browserfunc = 'g:OpenBrowser'
cnoreabbrev MP MarkdownPreview
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
    au FileType plantuml setlocal spell! spelllang=en_us,ru_yo
augroup END
" }}}

" {{{ Other ft-specific autocommands
au! BufNewFile,BufReadPost *.{yaml,yml,sublime-syntax} set filetype=yaml foldmethod=indent
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

if has('nvim')
lua require'init'.setup()
endif

" vim:fdm=marker:fen:sw=2:tw=120
