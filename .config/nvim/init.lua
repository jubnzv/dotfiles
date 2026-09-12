-- R is set once the first load has finished. ,R re-sources this file and skips plugins and plugin configs:
-- plug#end re-sources every plugin script and plugin setup() calls aren't idempotent, both duplicate
-- autocmds. Plugin changes need a restart.
local R = vim.g.init_loaded == 1

-- {{{ Options
local opt = vim.opt
local g = vim.g

-- Leaders (must be set before plugins)
g.mapleader = ' '
g.maplocalleader = ','

-- Shell
if vim.o.shell:match('fish$') then
  opt.shell = '/bin/bash'
end

-- Windows PATH tweak
if vim.fn.has('win32') == 1 then
  vim.env.PATH = 'C:\\Program Files\\Git\\usr\\bin;' .. vim.env.PATH
end

-- Disable some builtin plugins
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zipPlugin = 1
g.loaded_2html_plugin = 1

-- General options
opt.compatible = false
opt.viminfo = "'1000,f1"
opt.scrolloff = 7
opt.scroll = 7
opt.undofile = true
opt.undodir = vim.fn.expand('$HOME/.vim/undo')
opt.undolevels = 1000
opt.undoreload = 10000
opt.clipboard = 'unnamedplus,unnamed'
opt.showmatch = true
opt.mat = 1
opt.wildmenu = true
opt.wildmode = 'longest,list,full'
opt.wildignore:append({ '*.o', '*.pyc', '*.aux', '*.out', '*.toc' })
opt.wildignore:append({ '*.jpg', '*.jpeg', '*.gif', '*.png' })
opt.wildignore:append({ '.hg', '.git', '.svn', '*~' })
opt.wildcharm = vim.fn.char2nr('<C-z>')
opt.timeoutlen = 500
opt.timeout = false
opt.autochdir = false
opt.autoindent = true
opt.autoread = false
opt.hidden = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.lazyredraw = true
opt.joinspaces = false
opt.eol = true
opt.fixeol = true
opt.mouse = 'a'
opt.spell = false
opt.conceallevel = 0
opt.concealcursor = 'nc'

-- Langmap for Cyrillic
opt.langmap:append('ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ')
opt.langmap:append('фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz')
opt.langmap:append('ЖжЭэХхЪъ;\\:\\;\\"\\\'\\{[\\}]')

-- netrw
g.netrw_browsex_viewer = 'xdg-open'

-- rainbow parentheses
g.rainbow_active = 1
g.rainbow_conf = {
  separately = {
    why3 = 0,
  },
}

-- UI options
opt.termguicolors = true
opt.winblend = 5
opt.pumblend = 5
opt.shortmess:append('Ic')
opt.showmode = false
opt.relativenumber = true
opt.cursorline = true
opt.laststatus = 2
opt.title = true
opt.signcolumn = 'yes'
-- Set background based on theme-mode file
local function set_background_from_theme()
  local theme_file = vim.fn.expand('$HOME/.config/theme-mode')
  local f = io.open(theme_file, 'r')
  if f then
    local mode = f:read('*l')
    f:close()
    if mode == 'light' or mode == 'dark' then
      opt.background = mode
    end
  end
end
set_background_from_theme()

-- Update background when Neovim gains focus
vim.api.nvim_create_autocmd('FocusGained', {
  group = vim.api.nvim_create_augroup('ThemeMode', { clear = true }),
  callback = set_background_from_theme,
})
opt.guicursor:append('c-ci-cr:block')

-- Folding settings
opt.foldmethod = 'syntax'
opt.foldnestmax = 6
opt.foldenable = false
opt.foldlevel = 2
opt.foldcolumn = '0'
opt.fillchars = 'fold: '

-- ctags
opt.tags = './tags;'
-- }}}

-- {{{ Plugins
if not R then
  local Plug = vim.fn['plug#']

  vim.call('plug#begin', '~/.local/share/nvim/plugged')

  -- Core utilities
  Plug('kshenoy/vim-signature')                 -- Extended marks support
  Plug('tpope/vim-eunuch')                      -- Helpers for Shell
  Plug('tpope/vim-repeat')                      -- Remap . in a way that plugins can tap into it
  Plug('andymass/vim-matchup')                  -- Better %
  Plug('junegunn/vim-easy-align')               -- A Vim alignment plugin
  Plug('tpope/vim-surround')                    -- Surround text w/ brackets
  Plug('tpope/vim-abolish')                     -- Case-sensitive search/substitute/abbreviate
  Plug('jiangmiao/auto-pairs')                  -- Insert or delete brackets, parens, quotes in pair
  Plug('tpope/vim-rsi')                         -- Readline (emacs) keybindings in command and insert modes
  Plug('osyo-manga/vim-over')                   -- :substitute preview
  Plug('christoomey/vim-tmux-navigator')        -- tmux integration

  -- UI
  Plug('tyru/open-browser.vim')                 -- Plugin for opening links in the browser
  Plug('nvim-lualine/lualine.nvim')             -- Statusline plugin
  Plug('jubnzv/gruvbox')                        -- Color scheme
  Plug('norcalli/nvim-colorizer.lua')           -- Colorize color names and codes
  Plug('itchyny/vim-cursorword')                -- Plugin to highlight the word under the cursor

  -- Git
  Plug('tpope/vim-fugitive')                    -- Git wrapper
  Plug('cohama/agit.vim')                       -- gitk clone for vim
  Plug('airblade/vim-gitgutter')                -- Shows git status on a gutter column
  Plug('ruifm/gitlinker.nvim')                  -- Generate shareable links for git frontends
  Plug('statox/vim-compare-lines')              -- Compares symbol in two lines in the buffer
  Plug('rhysd/git-messenger.vim')               -- Reveal the commit messages under the cursor

  -- File navigation
  Plug('kyazdani42/nvim-tree.lua')              -- A tree explorer plugin for vim
  Plug('kyazdani42/nvim-web-devicons')          -- devicons for nvim-tree.lua
  Plug('mbbill/undotree')                       -- Emacs' undotree

  -- LSP & Completion
  Plug('simrat39/symbols-outline.nvim')         -- Viewer & Finder for LSP symbols and tags
  Plug('ludovicchabant/vim-gutentags')          -- Auto (re)generate tag files
  Plug('neovim/nvim-lspconfig')                 -- Configuration for native Neovim LSP client
  Plug('j-hui/fidget.nvim', { tag = 'legacy' }) -- UI that shows LSP progress
  Plug('jubnzv/virtual-types.nvim')             -- Plugin that shows type annotations in virtual text

  -- nvim-cmp completion
  Plug('hrsh7th/nvim-cmp')                      -- Completion engine
  Plug('hrsh7th/cmp-nvim-lsp')                  -- LSP source for nvim-cmp
  Plug('hrsh7th/cmp-buffer')                    -- Buffer words source
  Plug('hrsh7th/cmp-path')                      -- Path source
  Plug('hrsh7th/cmp-cmdline')                   -- Command line source

  -- Snippets
  Plug('sirver/ultisnips')                      -- Snippets engine
  Plug('honza/vim-snippets')                    -- A collection of snippets
  Plug('quangnguyen30192/cmp-nvim-ultisnips')   -- UltiSnips source for nvim-cmp

  -- Editing
  Plug('terryma/vim-expand-region')             -- Visually select increasingly larger regions of text
  Plug('machakann/vim-swap')                    -- Reorder arguments in functions with `g>` and `g<`
  Plug('lukas-reineke/indent-blankline.nvim')   -- Display indent levels in code
  Plug('sbdchd/neoformat')                      -- Integration with code formatters
  Plug('jpalardy/vim-slime')                    -- REPL integration
  Plug('derekwyatt/vim-fswitch')                -- Switching between companion files
  Plug('luochen1990/rainbow')                   -- Rainbow Parentheses improved

  -- Fuzzy finder
  Plug('nvim-lua/plenary.nvim')                 -- Various utilities used by other plugins
  Plug('nvim-telescope/telescope.nvim')         -- Fuzzy-finder
  Plug('folke/trouble.nvim')                    -- Show persistent telescope results
  Plug('stevearc/dressing.nvim')                -- A plugin that replaces most of built-in menus with telescope

  -- Treesitter
  Plug('nvim-treesitter/nvim-treesitter')         -- tree-sitter integration
  Plug('nvim-treesitter/nvim-treesitter-context') -- Shows context of a current function using treesitter

  -- org-mode
  Plug('nvim-orgmode/orgmode.nvim')               -- org-mode clone

  -- Writing
  Plug('dhruvasagar/vim-table-mode', { ['for'] = { 'markdown' } })
  Plug('iamcco/markdown-preview.nvim', {
    ['for'] = { 'markdown' },
    ['do'] = vim.fn['mkdp#util#install'],
    tag = 'v0.0.10'
  })
  Plug('junegunn/goyo.vim')                     -- Distraction-free writing

  -- Language-specific
  Plug('jamessan/vim-gnupg')                    -- Transparent editing of GPG-encrypted files
  Plug('lervag/vimtex', { ['for'] = { 'tex' } })
  Plug('bfrg/vim-cpp-modern', { ['for'] = { 'cpp' } })
  Plug('ocaml/vim-ocaml', { ['for'] = { 'ocaml' } })
  Plug('vim-python/python-syntax', { ['for'] = { 'python' } })
  Plug('wlangstroth/vim-racket', { ['for'] = { 'rkt' } })
  Plug('rust-lang/rust.vim', { ['for'] = { 'rust' } })
  Plug('fatih/vim-go', { ['for'] = { 'go' } })
  Plug('tomlion/vim-solidity', { ['for'] = { 'sol' } })
  Plug('leafgarland/typescript-vim', { ['for'] = { 'typescript' } })
  Plug('othree/xml.vim', { ['for'] = { 'xml', 'html' } })
  Plug('florentc/vim-tla', { ['for'] = { 'tla' } })
  Plug('hanw/vim-bluespec', { ['for'] = { 'quint' } })
  Plug('tikhomirov/vim-glsl', { ['for'] = { 'glsl' } })
  Plug('elzr/vim-json', { ['for'] = { 'json' } })
  Plug('hylang/vim-hy', { ['for'] = { 'hy' } })
  Plug('nathangrigg/vim-beancount', { ['for'] = { 'beancount' } })
  Plug('move-language/move.vim', { ['for'] = { 'move' } })
  Plug('Julian/lean.nvim')                      -- no lazy 'for': plugin registers .lean ft itself


  -- Local plugins
  if vim.fn.isdirectory('/home/jubnzv/Sources/llvm-project/llvm/utils/vim/') == 1 then
    Plug('/home/jubnzv/Sources/llvm-project/llvm/utils/vim/')
  end

  vim.call('plug#end')
end
-- }}}

-- {{{ Vimscript
vim.cmd([==[
" {{{ Gruvbox
let g:gruvbox_sign_column='bg0'
let g:gruvbox_color_column='bg1'
let g:gruvbox_number_column='bg0'
let g:gruvbox_italic=0
colorscheme gruvbox
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

  nnoremap <silent>`t :call system('kitty -e '.shellescape(getcwd()).' &')<CR>
endif
" }}}

" {{{ Keybindings
cabbrev w1 w!

" Killing local buffer without losing split
:command! Bc sb # | bd #

" Fix common typos
:command! W w
:command! Q q
:command! E e

" Command to manually create directory for current file
function! WriteCreatingDirs()
  execute ':silent !mkdir -p %:h'
endfunction
command! Mkw call WriteCreatingDirs()

" Remove the Windows ^M - when the encodings gets messed up
noremap <leader>rm mmHmt:%s/<C-V><CR>//ge<cr>'tzt'm

" Editing neighbors
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ee :e<Space>
map <leader>es :sp <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ev :vsp <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>et :tabe <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ec :cd <C-R>=fnameescape(expand('%:h')).'/'<cr><cr>
map <leader>eC :cd ..<cr>

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

" ё -> е
nnoremap <silent> <leader>r` :%s/ё/е/g<cr>

" Find all cyrillic characters
nnoremap <silent> <leader>/c /[\d1040-\d1103]<cr>

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

" vim-easyalign
cnoreabbrev Tab EasyAlign
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
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
  if !empty(cmd_aux) | let cmd = cmd_aux . "; " . cmd | endif

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
" Use deferred highlighting to avoid E803 in CursorMovedI (vimtex conflict)
let g:matchup_matchparen_deferred=1
" }}}

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
  let foldLevelStr = "" . string(v:foldlevel)
  let lineCount = line("$")
  let foldSizeStr = printf("[%4dL|%4.1f%%]", foldSize, (foldSize*1.0)/lineCount*100)
  let expansionString = " " . repeat(" ", w - strwidth(foldSizeStr.line.foldLevelStr))
  return  line . expansionString . foldLevelStr . " " . foldSizeStr
endf
set foldtext=CustomFoldText()
" }}}

" {{{ Comments (nvim builtin gc/gcc)
nmap <C-_> gcc
nmap <C-/> gcc
xmap <C-_> gc
xmap <C-/> gc
" }}}

" {{{ ctags
let g:gutentags_ctags_exclude = [
  \'node_modules', '_build', 'build', 'CMakeFiles', '.mypy_cache', 'venv',
  \'*.md', '*.tex', '*.css', '*.html', '*.json', '*.xml', '*.xmls', '*.ui']
" Guttentags will exclude files from wildignore settings
let g:gutentags_ctags_exclude_wildignore = 1
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

" {{{ UltiSnips
" Note: Expansion/jumping now handled by nvim-cmp (A-l, A-h)
" Setting these to avoid conflicts with nvim-cmp
let g:UltiSnipsExpandTrigger='<Plug>(ultisnips_expand)'
let g:UltiSnipsJumpForwardTrigger='<Plug>(ultisnips_jump_forward)'
let g:UltiSnipsJumpBackwardTrigger='<Plug>(ultisnips_jump_backward)'
let g:UltiSnipsRemoveSelectModeMappings = 0

nnoremap <localleader>sr :call UltiSnips#RefreshSnippets()<cr>:echo "Snippets reloaded"<CR>
nnoremap <localleader>se :UltiSnipsEdit<CR>
" }}}

" {{{ neoformat
" Enable for debugging
" let g:neoformat_verbose = 1

let g:neoformat_enabled_html = ['prettier']
let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_java = ['astyle']
let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_enabled_ocaml = ['ocamlformat']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_haskell = ['ormolu']
" }}}

" {{{ Git
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_map_keys = 0

nmap [v <Plug>(GitGutterPrevHunk)
nmap ]v <Plug>(GitGutterNextHunk)
nmap <leader>v- <Plug>(GitGutterStageHunk)
nmap <leader>v_ <Plug>(GitGutterUndoHunk)
nmap <leader>vr <Plug>(GitGutterRefresh)
nmap <localleader>vp <Plug>(GitGutterPreviewHunk)
nmap <localleader>b <Plug>(git-messenger)
nmap <localleader>vs :Git<cr>
nmap <localleader>vD :Git! diff<cr>
nmap <localleader>vb :Git blame<cr>
nmap <localleader>vl :Agit<cr>
" }}}

" {{{ table-mode
let g:table_mode_map_prefix = ',t'
let g:table_mode_delete_row_map = ',tdd'
let g:table_mode_delete_column_map = ',tdc'
" }}}

" {{{ Plain text editing
command! PTToggle Goyo
" }}}

" {{{ vim-cursorword
let g:cursorword_highlight = 0
" }}}

" {{{ GPG
let g:GPGPreferArmor=1
let g:GPGDefaultRecipients=["jubnzv@gmail.com"]
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
  au FileType c,cpp RainbowToggleOn
  au BufEnter *.h let b:fswitchdst = "c,cpp,m,cc" | let b:fswitchlocs = 'reg:|include.*|src/**|'
  au BufEnter *.cc let b:fswitchdst = "h,hpp"
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
  au FileType solidity setlocal nospell
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

augroup python_group
  au!
  au FileType python setlocal tw=0
  au FileType python setlocal foldmethod=indent foldnestmax=2
  au FileType python setlocal cinoptions=:0,l1,t0,g0,(0
  au FileType python nnoremap <buffer><leader>ri :!isort %<CR><CR>
  au FileType python nnoremap <buffer><leader>rd :g/pdb\.set_trace()/d<CR>
  au FileType python RainbowToggleOn
  au FileType python nmap <buffer> <silent><A-o> <Nop>
augroup END
" }}}

" {{{ OCaml and other MLs
augroup ocaml_group
  au!
  au FileType ocaml setlocal tabstop=2 shiftwidth=2
  au FileType ocaml,dune RainbowToggleOn
  au FileType dune setlocal foldmethod=marker
  au FileType ocaml inoremap <buffer> <A-1> `
  au FileType ocaml nnoremap <buffer><leader>rd :JbzRemoveDebugPrints<CR>

  " Rebind switching keys defined at default ocaml.vim
  au FileType ocaml nmap <buffer> <silent><A-o> <Plug>OCamlSwitchEdit
  au FileType ocaml nmap <buffer> <silent><LocalLeader><A-o> <Plug>OCamlSwitchNewWin

  au FileType ocaml setlocal spell spelllang=en_us
augroup END

" A few hacks for the menhir parser generator.
augroup menhir_group
  au!
  au BufNewFile,BufRead *.mly setlocal comments+=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/
  au BufNewFile,BufRead *.mly setlocal indentkeys=0{,0},0),0],:,0#,!^F,o,O,e
  au BufNewFile,BufRead *.mly syn region ocamlComment start="/\*" end="\*/" contains=@Spell,ocamlComment,ocamlTodo
augroup END

augroup ml_ft_group
  au!
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
augroup END
" }}}

" {{{ Scheme/Racket
augroup rkt_group
  au!
  au FileType racket inoremap <buffer> <A-1> `
  au FileType racket inoremap <buffer> <A-2> '
  au FileType racket inoremap <buffer> <A-3> λ
  au FileType racket setlocal foldmethod=marker
  au FileType racket setlocal commentstring=;\ %s
  au FileType racket RainbowToggleOn
augroup END

augroup scheme_group
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

" {{{ GLSL
augroup glsl_group
  au!
  au FileType glsl RainbowToggleOn
  au FileType glsl nmap <buffer> <silent><A-o> <Nop>
  au FileType glsl setlocal sw=2 ts=2 expandtab
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
augroup END
" }}}

" {{{ z3 and smt-lib2
augroup smt_group
  au!
  au! BufNewFile,BufReadPost *.{z3,smt2} set filetype=smt2
augroup END
" }}}

" {{{ LaTeX
" References:
" [0] https://castel.dev/post/lecture-notes-1/
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_mode=0
let g:vimtex_matchparen_enabled=0
let g:vimtex_complete_close_braces = 1
let g:tex_conceal='abdmg'

augroup tex_group
  au!
  au FileType tex setlocal sw=2
  au FileType tex call s:Gjgk(1)
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
  au FileType rst setlocal syn=off
  au FileType rst setlocal sw=4 ts=4 expandtab
  au FileType rst setlocal textwidth=80
  au Filetype rst setlocal foldmethod=expr
  au FileType rst setlocal spell spelllang=en_us,ru_ru,es_es
  au FileType rst call s:Gjgk(1)
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


" {{{ Markdown & org-mode
let g:markdown_fenced_languages = [
 \'python', 'py=python', 'bash=sh', 'c', 'cpp', 'c++=cpp',
 \'asm', 'go', 'rust', 'ocaml', 'cmake', 'diff', 'yaml', 'haskell',
 \'json', 'html', 'sql', 'lua', 'racket', 'vim', 'lean', 'solidity'
 \]
augroup markdown_group
  au!
  au FileType markdown setlocal tw=0 sw=2 nofoldenable
  au FileType markdown nmap <buffer> <silent><A-o> <Nop>
  au FileType markdown call s:Gjgk(1)
  " Insert code blocks
  au FileType markdown nnoremap <buffer> <leader>' i``
  au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
  au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
  au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
  " Create a new file if not exists.
  au FileType markdown nnoremap <buffer> gf :e <cfile><cr>
  " Abbrevations
  au FileType markdown inoremap <buffer> --<space> –<space>
  " Paste image from clipboard
  au FileType markdown nnoremap <buffer> <silent> <leader>pi :call pasteimage#MarkdownClipboardImage()<CR>
  au FileType markdown nnoremap <buffer> <silent> <leader>шз :call pasteimage#MarkdownClipboardImage()<CR>
  " Paste URL link from clipboard
  au FileType markdown nnoremap <buffer> <leader>pl a[]()<Esc>hpl%hi
  au FileType markdown nnoremap <buffer> <leader>зд a[]()<Esc>hpl%hi
  " Open Zettelkasten prompt
  au FileType markdown nnoremap <buffer> <localleader>zb :lua backlinks()<CR>
  au FileType markdown setlocal nospell spelllang=en_us,ru_yo
  au BufWritePost *.md setlocal spell
  " au FileType markdown setlocal spell spelllang=en_us,ru_yo,es_es
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

" }}}

" {{{ Other ft-specific autocommands
augroup other_ft_group
  au!
  au BufNewFile,BufReadPost *.{yaml,yml,sublime-syntax} setlocal filetype=yaml foldmethod=indent
  au FileType yaml setlocal ts=2 sts=2 sw=2

  au FileType conf setlocal foldmethod=marker foldenable
  au Filetype css setlocal ts=4
  au Filetype html setlocal ts=4

  " quint specification language
  au BufNewFile,BufRead *.qnt setlocal syntax=bsv

  " gno language: https://gno.land/
  au BufNewFile,BufRead *.gno setlocal syntax=go

  au BufNewFile,BufRead .clang-format setlocal ft=config
  au BufNewFile,BufRead .pdbrc setlocal ft=python

  " neosnippet snippets
  au BufNewFile,BufRead *.snip setlocal ft=neosnippet fdm=marker foldlevel=0 fen tw=120 ts=4 noexpandtab

  " ansible playbooks
  au BufRead,BufNewFile */playbooks/*.yml setlocal filetype=yaml.ansible
  au BufRead,BufNewFile */ops/ansible/*.yml setlocal filetype=yaml.ansible

  " buildbot configuration files
  au BufNewFile,BufRead   master.cfg      setlocal ft=python foldmethod=marker foldenable tw=120
  au BufNewFile,BufRead   buildbot.tac    setlocal ft=python foldmethod=marker foldenable tw=120

  " cppcheck dumps
  au BufNewFile,BufRead *.c.dump      setlocal filetype=xml tw=120
  au BufNewFile,BufRead *.cpp.dump    setlocal filetype=xml tw=120
  " cppcheck configuration files
  au BufRead,BufNewFile *cppcheck*/cfg/*.cfg setlocal filetype=xml

  autocmd FileType xml let b:did_indent = 0

  " Taskwarrior tasks (`task <id> edit`)
  au BufRead *.task /Description:

  au FileType gitcommit inoremap <buffer> --<space> –<space>
  au FileType gitcommit inoremap <buffer> -><space> →<space>
  au FileType gitcommit inoremap <buffer> =><space> ⇒<space>
augroup END
" }}}

" {{{ Toggle settings functions
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
  if exists('g:syntax_on')
    syntax off
  else
    syntax on
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

function! s:Gjgk(on)
  if a:on
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
    nnoremap <buffer> gj j
    nnoremap <buffer> gk k
  else
    silent! nunmap <buffer> j
    silent! nunmap <buffer> k
    silent! nunmap <buffer> gj
    silent! nunmap <buffer> gk
  endif
  let b:gjgk_mode = a:on
endfunction

function! Togglegjgk()
  call s:Gjgk(!get(b:, 'gjgk_mode', 0))
endfunction

function! ToggleHex()
  if get(b:, 'hex_mode', 0)
    %!xxd -r
    let b:hex_mode = 0
  else
    %!xxd
    let b:hex_mode = 1
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
" }}}
]==])
-- }}}

-- {{{ Plugin configs
if not R then
  -- {{{ telescope
  do
    local telescope = require('telescope')
    local open_with_trouble = require('trouble.sources.telescope').open

    telescope.setup({
      defaults = {
        preview = {
          treesitter = false,
        },
        mappings = {
          i = { ['<c-t>'] = open_with_trouble },
          n = { ['<c-t>'] = open_with_trouble },
        },
      },
    })

    -- Poor man's Zettelkasten
    local home = vim.fn.expand('~/Org/Notes/')
    local builtin = require('telescope.builtin')

    function _G.backlinks()
      local filename = vim.fn.expand('%:t')
      builtin.live_grep({
        results_title = 'Backlinks to ' .. filename,
        prompt_title = 'Search',
        cwd = home,
        search_dirs = { home },
        default_text = '\\[.*\\]\\((./)?' .. filename .. '(#.+)*\\)',
        find_command = { 'fd' },
      })
    end
  end
  -- }}}

  -- {{{ nvim-tree
  do
    require('nvim-tree').setup({
      git = { ignore = true },
      disable_netrw = true,
      update_focused_file = { enable = true },
      update_cwd = true,
      filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__', '.clangd' } },
    })
  end
  -- }}}

  -- {{{ colorizer
  do
    require('colorizer').setup({
      '*',
      markdown = { names = false },
      css = { rgb_fn = true },
    })
  end
  -- }}}

  -- {{{ gitlinker
  do
    require('gitlinker').setup()

    -- Keymaps for opening git links in browser
    vim.api.nvim_set_keymap(
      'n',
      '<leader>vo',
      '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      {}
    )
    vim.api.nvim_set_keymap(
      'v',
      '<leader>vo',
      '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      {}
    )
  end
  -- }}}

  -- {{{ cmp
  do
    local ok, cmp = pcall(require, 'cmp')
    if ok then

      -- UltiSnips integration
      local ok_ultisnips, cmp_ultisnips_mappings = pcall(require, 'cmp_nvim_ultisnips.mappings')
      if not ok_ultisnips then
        cmp_ultisnips_mappings = nil
      end

      local function feed(keys)
        vim.api.nvim_feedkeys(vim.keycode(keys), 'nit', false)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn['UltiSnips#Anon'](args.body)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          -- Navigate completion menu, Tab/S-Tab when it's closed (deoplete keybindings)
          ['<A-j>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_next_item() else feed('<Tab>') end
          end, { 'i' }),
          ['<A-k>'] = cmp.mapping(function()
            if cmp.visible() then cmp.select_prev_item() else feed('<S-Tab>') end
          end, { 'i' }),

          -- Scroll docs
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Trigger completion manually
          ['<A-o>'] = cmp.mapping.complete(),

          -- Accept selected candidate and close menu, newline when it's closed (deoplete keybindings)
          ['<A-q>'] = cmp.mapping(function()
            if not cmp.visible() then
              feed('<CR>')
            elseif not cmp.confirm({ select = false }) then
              cmp.close()
            end
          end, { 'i' }),

          -- Confirm selection and expand/jump snippets
          ['<A-l>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            elseif cmp_ultisnips_mappings then
              cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- UltiSnips jump backward
          ['<A-h>'] = cmp.mapping(function(fallback)
            if cmp_ultisnips_mappings then
              cmp_ultisnips_mappings.jump_backwards(fallback)
            else
              fallback()
            end
          end, { 'i', 's' }),

          -- Enter to confirm (alternative)
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
        }),

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'ultisnips' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),

        -- Formatting with icons
        formatting = {
          format = function(entry, vim_item)
            -- Kind icons
            local kind_icons = {
              Text = '',
              Method = '󰆧',
              Function = '󰊕',
              Constructor = '',
              Field = '󰇽',
              Variable = '󰂡',
              Class = '󰠱',
              Interface = '',
              Module = '',
              Property = '󰜢',
              Unit = '',
              Value = '󰎠',
              Enum = '',
              Keyword = '󰌋',
              Snippet = '',
              Color = '󰏘',
              File = '󰈙',
              Reference = '',
              Folder = '󰉋',
              EnumMember = '',
              Constant = '󰏿',
              Struct = '',
              Event = '',
              Operator = '󰆕',
              TypeParameter = '󰅲',
            }
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)

            -- Source labels
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              ultisnips = '[Snip]',
              buffer = '[Buf]',
              path = '[Path]',
            })[entry.source.name]

            return vim_item
          end,
        },
      })

      -- Command line completion for `/` and `?`
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
        },
      })

      -- Command line completion for `:`
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'cmdline' },
        }),
      })

      -- Set completeopt for better completion experience
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
    end
  end
  -- }}}

  -- {{{ lsp
  do
    local virtualtypes = require('virtualtypes')

    -- General LSP options
    vim.diagnostic.config({
      underline = true,
      virtual_text = false,
      update_in_insert = false,
    })

    vim.lsp.config('clangd', {
      cmd = {
        'clangd',
        '--background-index',
        '--header-insertion=iwyu',
        '--header-insertion-decorators',
        '--completion-style=detailed',
        '--clang-tidy',
      },
    })

    vim.lsp.config('ocamllsp', {
      on_attach = virtualtypes.on_attach,
    })

    -- { config, executable, cwd basenames where the server must stay off }
    local servers = {
      { 'clangd', 'clangd', { 'llvm-project' } },
      { 'pylsp', 'pylsp' },
      { 'gopls', 'gopls' },
      { 'ocamllsp', 'ocamllsp' },
      { 'ts_ls', 'typescript-language-server' },
    }

    local cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    for _, s in ipairs(servers) do
      if vim.fn.executable(s[2]) == 1 and not vim.tbl_contains(s[3] or {}, cwd) then
        vim.lsp.enable(s[1])
      end
    end

    -- Symbols Outline
    require('symbols-outline').setup()

    -- Fidget (LSP progress UI)
    require('fidget').setup({})
  end
  -- }}}

  -- {{{ lualine
  do
    local ok, lualine = pcall(require, 'lualine')
    if ok then

      -- Custom filename component that shortens path
      local function shortened_filename()
        local path = vim.fn.expand('%')
        if path == '' then return '[No Name]' end

        local parts = vim.split(path, '/')
        if #parts < 3 then
          return path
        end

        -- Shorten all but last component to 2 chars
        local result = {}
        for i, part in ipairs(parts) do
          if i == #parts then
            table.insert(result, part)
          else
            table.insert(result, part:sub(1, 2))
          end
        end
        return table.concat(result, '/')
      end

      lualine.setup({
        options = {
          theme = 'gruvbox',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
          globalstatus = false,
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = {
            { 'branch', icon = '' },  -- no icon
            {
              'diagnostics',
              symbols = { error = '● ', warn = '● ', info = '● ', hint = '● ' },
              colored = true,
            },
          },
          lualine_c = {
            { shortened_filename },
            { 'readonly', fmt = function(str) return str ~= '' and 'RO' or '' end },
            { 'modified', fmt = function(str) return str ~= '' and '[+]' or '' end },
          },
          lualine_x = {
            'encoding',
            { 'fileformat', icons_enabled = false, cond = function() return vim.bo.fileformat ~= 'unix' end },
            { 'filetype', icons_enabled = false },
          },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      })
    end
  end
  -- }}}

  -- {{{ treesitter
  do
    local ok, configs = pcall(require, 'nvim-treesitter.configs')
    if ok then

      configs.setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })

      -- TS highlighting turns regex syntax off, so foldmethod=syntax folds nothing: fold on the parse tree.
      -- Checks for a parser, not the highlighter: the highlighter attaches after this autocmd has run.
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TSFold', { clear = true }),
        callback = function(ev)
          local okp, loaded = pcall(vim.treesitter.language.add, vim.treesitter.language.get_lang(ev.match) or '')
          if okp and loaded and vim.wo.foldmethod == 'syntax' then
            vim.opt_local.foldmethod = 'expr'
            vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end
        end,
      })
    end
  end
  -- }}}

  -- {{{ treesitter-context
  do
    local ok, context = pcall(require, 'treesitter-context')
    if ok then

      context.setup({
        enable = false,  -- Disabled by default
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
      })
    end
  end
  -- }}}

  -- {{{ indent-blankline
  do
    require("ibl").setup({
      exclude = {
        filetypes = { "markdown" },
      },
    })
  end
  -- }}}

  -- {{{ lean
  do
    -- Commands (:LeanInfoviewToggle, :LeanSorryFill, ...) only exist after setup().

    require('lean').setup({
      mappings = true,
    })
  end
  -- }}}
end
-- }}}

-- {{{ Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Custom highlights. Every colorscheme (re)load wipes them, e.g. on a theme-mode flip.
local function set_user_hl()
  vim.cmd([[
    highlight Todo ctermfg=130 guibg=#af3a03
    highlight ExtraWhitespace ctermbg=red guibg=red
    highlight CursorWord0 ctermbg=237 guibg=#3c3836
    highlight LineHighlight ctermbg=darkgray guibg=#458588
    highlight NvimTreeIndentMarker guifg=#3c3836
    highlight NvimTreeFolderIcon guifg=#7c6f64
    highlight NvimTreeGitDirty guifg=#689d6a
  ]])
  vim.api.nvim_set_hl(0, 'MdTodo', { fg = '#ff0000', bold = true, default = true })
  vim.api.nvim_set_hl(0, 'MdDone', { fg = '#00ff00', bold = true, default = true })
end
set_user_hl()

augroup('UserHighlights', { clear = true })
autocmd('ColorScheme', {
  group = 'UserHighlights',
  callback = set_user_hl,
})

-- Disable syntax and treesitter for large files
augroup('LargeFile', { clear = true })
autocmd('BufWinEnter', {
  group = 'LargeFile',
  callback = function(ev)
    if vim.fn.line2byte(vim.fn.line('$') + 1) > 1000000 then
      vim.treesitter.stop(ev.buf)
      vim.cmd('syntax clear')
      vim.opt_local.foldmethod = 'manual'
    end
  end,
})

-- Jump to last position when reopening a file
augroup('LastPosition', { clear = true })
autocmd('BufReadPost', {
  group = 'LastPosition',
  callback = function()
    local line = vim.fn.line
    if line("'\"") > 1 and line("'\"") <= line('$') then
      vim.cmd("normal! g'\"")
    end
  end,
})

-- Don't parse modelines on temporary paths
local downloads = vim.fn.expand('~/Downloads/')
augroup('SafeModeline', { clear = true })
autocmd({ 'BufReadPost', 'BufNewFile' }, {
  group = 'SafeModeline',
  callback = function(ev)
    local path = vim.fn.fnamemodify(ev.match, ':p')
    if vim.startswith(path, '/tmp/') or vim.startswith(path, downloads) then
      vim.opt_local.modeline = false
    end
  end,
})

-- Trailing whitespace highlight. `:match` owns a single slot per window, matchadd() would pile up.
local function ws_match(pat)
  if vim.bo.buftype == '' then
    vim.cmd('match ExtraWhitespace /' .. pat .. '/')
  else
    vim.cmd('match none')
  end
end

augroup('TrailingWhitespace', { clear = true })
autocmd({ 'BufWinEnter', 'InsertLeave' }, {
  group = 'TrailingWhitespace',
  callback = function() ws_match([[\s\+$]]) end,
})
autocmd('InsertEnter', {
  group = 'TrailingWhitespace',
  callback = function() ws_match([[\s\+\%#\@<!$]]) end,
})
autocmd('BufWinLeave', {
  group = 'TrailingWhitespace',
  callback = function() vim.fn.clearmatches() end,
})

-- Color column based on textwidth
local function set_color_column()
  if vim.bo.textwidth == 0 then
    vim.opt_local.colorcolumn = '80'
  else
    vim.opt_local.colorcolumn = '+0'
  end
end

augroup('ColorColumn', { clear = true })
autocmd('OptionSet', {
  group = 'ColorColumn',
  pattern = 'textwidth',
  callback = set_color_column,
})
autocmd('BufEnter', {
  group = 'ColorColumn',
  callback = set_color_column,
})

-- Create missing parent directories before write
augroup('CreateDir', { clear = true })
autocmd('BufWritePre', {
  group = 'CreateDir',
  callback = function(ev)
    if ev.match:match('^%w+://') then
      return
    end
    local dir = vim.fn.fnamemodify(ev.match, ':p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- Update 'Last modified: ' within the first 20 lines of a modified buffer
augroup('LastModified', { clear = true })
autocmd('BufWritePre', {
  group = 'LastModified',
  callback = function(ev)
    if not vim.bo[ev.buf].modified then
      return
    end
    local view = vim.fn.winsaveview()
    local n = math.min(20, vim.fn.line('$'))
    local stamp = os.date('%a %b %d, %Y  %I:%M%p')
    vim.cmd(('silent! keepjumps keeppatterns 1,%ds#^\\(.\\{,10}Last modified: \\).*#\\1%s#e'):format(n, stamp))
    vim.fn.winrestview(view)
  end,
})

-- Disable completion in Telescope prompt
augroup('TelescopeCmp', { clear = true })
autocmd('FileType', {
  group = 'TelescopeCmp',
  pattern = 'TelescopePrompt',
  callback = function()
    require('cmp').setup.buffer({ enabled = false })
  end,
})

-- Highlight TODO/DONE in markdown/org. Uses extmarks (priority 250) because
-- matchadd is overlaid by treesitter extmarks in modern Neovim regardless of
-- matchadd priority.
local todo_ns = vim.api.nvim_create_namespace('user_md_todo')

local function paint_keyword(buf, lnum, line, keyword, hl)
  local pat = '()%f[%w]' .. keyword .. '%f[%W]'
  for s in line:gmatch(pat) do
    vim.api.nvim_buf_set_extmark(buf, todo_ns, lnum, s - 1, {
      end_col = s - 1 + #keyword,
      hl_group = hl,
      priority = 250,
    })
  end
end

local function refresh_todo(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not vim.api.nvim_buf_is_valid(buf) then return end
  local ft = vim.bo[buf].filetype
  if ft ~= 'markdown' and ft ~= 'org' then return end
  vim.api.nvim_buf_clear_namespace(buf, todo_ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    paint_keyword(buf, i - 1, line, 'TODO', 'MdTodo')
    paint_keyword(buf, i - 1, line, 'DONE', 'MdDone')
  end
end

augroup('MdTodoHighlight', { clear = true })
autocmd({ 'BufWinEnter', 'BufReadPost', 'FileType', 'InsertLeave', 'BufWritePost' }, {
  group = 'MdTodoHighlight',
  pattern = { '*.md', '*.markdown', '*.org', 'markdown', 'org' },
  callback = function(ev) refresh_todo(ev.buf) end,
})
-- }}}

-- {{{ Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic mappings
keymap('i', 'jj', '<Esc>', opts)
keymap('n', '<leader>h', ':noh<CR>', opts)
keymap('n', '<leader>xc', ':q<CR>', opts)
keymap('n', '<leader>w', ':w<CR>', opts)

-- Reload config: re-sources this file, plugins and plugin configs are skipped (see R at the top)
keymap('n', '<localleader>R', function()
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify('Config reloaded')
end, opts)

-- Y yanks from the cursor to the end of line as expected
keymap('n', 'Y', 'y$', opts)

-- Disable the ever-annoying Ex mode shortcut key
keymap('n', 'Q', '@@', opts)

-- Map Ctrl-Backspace to delete previous word
keymap('i', '<C-BS>', '<C-W>', opts)
keymap('c', '<C-BS>', '<C-W>', opts)

-- Search visually selected text
keymap('v', '//', 'y/<C-R>"<CR>', opts)

-- Search in visual selected area
keymap('v', '<M-/>', '<Esc>/\\%V', { noremap = true })

-- Keep selected text selected when fixing indentation
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Tabs management
keymap('n', '<A-t>', ':tabnew<CR>', opts)
keymap('i', '<A-t>', '<C-O>:tabnew<CR>', opts)
keymap('n', '<A-Tab>', ':tabnext<CR>', opts)
keymap('i', '<A-Tab>', '<C-O>:tabnext<CR>', opts)

for i = 1, 9 do
  keymap('n', '<A-' .. i .. '>', i .. 'gt', opts)
  keymap('i', '<A-' .. i .. '>', '<C-O>' .. i .. 'gt', opts)
end

-- Refresh content of the current buffer
keymap('n', '<leader>B', ':checktime<CR>', opts)

-- Convert the ^M linebreaks to the normal linebreaks
keymap('n', '<leader>rl', ':set ff=unix<CR> :e ++ff=dos<CR>', opts)

-- Remove all trailing whitespaces
keymap('n', '<leader>rs', ':let _s=@/ <Bar> :%s/\\s\\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>', opts)

-- Re-select the text you just pasted
keymap('n', 'gp', '`[v`]', opts)

-- Switch to the recent buffer
keymap('n', '<A-r>', '<C-^>', opts)

-- Use Ctrl-W operation in insert mode
keymap('i', '<C-w>', '<C-g>u<C-w>', opts)

-- Copy file path to the system clipboard
keymap('n', '<leader>cr', function()
  local path = vim.fn.expand('%')
  if vim.fn.has('win32') == 1 then
    path = path:gsub('/', '\\')
  end
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, opts)

keymap('n', '<leader>ca', function()
  local path = vim.fn.expand('%:p')
  if vim.fn.has('win32') == 1 then
    path = path:gsub('/', '\\')
  end
  vim.fn.setreg('+', path)
  print('Copied: ' .. path)
end, opts)

-- Datetime insertion
keymap('n', '<leader>c.', '"=strftime("%Y-%m-%d")<CR>P', opts)
keymap('n', '<C-c>.', '"=strftime("%Y-%m-%d")<CR>P', opts)
keymap('i', '<C-c>.', '<C-R>=strftime("%Y-%m-%d")<CR>', opts)

-- UndoTree
keymap('n', '<A-U>', ':UndotreeToggle<CR>', opts)

-- Highlight specific lines
keymap('n', '<leader>m', ":call matchadd('LineHighlight', '\\%'.line('.').'l')<CR>", opts)
keymap('n', '<leader>M', ':call clearmatches()<CR>', opts)

-- FSwitch bindings
keymap('n', '<A-o>', ':FSHere<CR>', opts)
keymap('n', '<localleader>oh', ':FSSplitLeft<CR>', opts)
keymap('n', '<localleader>oj', ':FSSplitBelow<CR>', opts)
keymap('n', '<localleader>ok', ':FSSplitAbove<CR>', opts)
keymap('n', '<localleader>ol', ':FSSplitRight<CR>', opts)

-- Neoformat
keymap('n', '<leader>lf', ':Neoformat<CR>', opts)

-- nvim-tree
keymap('n', '<A-0>', ':NvimTreeToggle<CR>', opts)

-- Nvim's default grn/grr/gri/gra/grt turn `gr` into a prefix that waits forever under 'notimeout'
for _, lhs in ipairs({ 'grn', 'grr', 'gri', 'gra', 'grt' }) do
  for _, mode in ipairs({ 'n', 'x' }) do
    pcall(vim.keymap.del, mode, lhs)
  end
end

-- Telescope keymaps
keymap('n', '<A-p>', "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap('n', '<leader>fs', "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap('n', '<leader>fo', "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)
keymap('n', '<A-u>', "<cmd>lua require('telescope.builtin').spell_suggest()<CR>", opts)
keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
keymap('n', 'gs', "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
keymap('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
keymap('n', '<localleader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
keymap('n', '<localleader>vc', "<cmd>lua require('telescope.builtin').git_commits()<CR>", opts)
keymap('n', '<localleader>vC', "<cmd>lua require('telescope.builtin').git_bcommits()<CR>", opts)
keymap('n', '<localleader>vB', "<cmd>lua require('telescope.builtin').git_branches()<CR>", opts)
keymap('n', '<localleader>vS', "<cmd>lua require('telescope.builtin').git_stash()<CR>", opts)

-- Notes navigation
keymap('n', '<leader>pn', "<cmd>lua require('telescope.builtin').find_files({prompt_title = 'Notes', cwd = '~/Org/Notes/'})<CR>", opts)
keymap('n', '<leader>pm', "<cmd>lua require('telescope.builtin').find_files({prompt_title = 'org-mode', cwd = '~/Org/org-mode'})<CR>", opts)

-- LSP keymaps
keymap('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
keymap('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
keymap('n', '<localleader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', ']e', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
keymap('n', '[e', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
keymap('n', '<localleader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

-- Symbols outline
keymap('n', '<A-6>', ':SymbolsOutline<CR>', opts)

-- Toggle functions
keymap('n', '<leader>tc', ':call ToggleConceal()<CR>', opts)
keymap('n', '<leader>tg', ':call Togglegjgk()<CR>', opts)
keymap('n', '<leader>tx', ':call ToggleHex()<CR>', opts)
keymap('n', '<leader>ts', ':call ToggleSyntax()<CR>', opts)
keymap('n', '<leader>tn', ':call ToggleNumber()<CR>', opts)
keymap('n', '<leader>tS', ':call ToggleScrollBind()<CR>', opts)
keymap('n', '<leader>tp', ':setlocal paste!<CR>', opts)
keymap('n', '<leader>tC', ':ColorizerToggle<CR>', opts)
keymap('n', '<leader>tr', ':RainbowToggle<CR>', opts)
keymap('n', '<leader>tt', ':TableModeToggle<CR>', opts)
keymap('n', '<leader>ti', ':IBLToggle<CR>', opts)
-- }}}

vim.g.init_loaded = 1

-- vim:fdm=marker:fen:sw=2:tw=120
