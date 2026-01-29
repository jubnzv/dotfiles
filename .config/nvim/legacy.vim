" Gruvbox configuration (kept here - needs to run after plugins)
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

" {{{ Keybindings
cabbrev w1 w!

" Reload vimrc
nnoremap <localleader>R :so $MYVIMRC<CR>:echo "Config reloaded"<CR>

" Killing local buffer without losing split
:command! Bc sb # | bd #

" Fix common typos
:command! W w
:command! Q q
:command! E e

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

" Editing neighbors
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ee :e
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

" {{{ DirDiff
let g:DirDiffWindowSize = 6
let g:DirDiffEnableMappings = 0
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,*.pyc,tags"
" }}}

" {{{ Datetime
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
let g:neoformat_enabled_scilla = ['scilla_fmt']
" }}}

" {{{ EditorConfig
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
" }}}

" {{{ Git
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
nmap <localleader>vD :Git! diff<cr>
nmap <localleader>vb :Git blame<cr>
nmap <localleader>vf :GFiles<cr>
nmap <localleader>vl :Agit<cr>
" }}}

" {{{ table-mode
let g:table_mode_map_prefix = ',t'
let g:table_mode_delete_row_map = ',tdd'
let g:table_mode_delete_column_map = ',tdc'
" }}}

" {{{ Plain text editing
let s:PTModeActive = exists('w:PTModeActive') ? w:PTModeActive : 0

function! s:PTEnable()
    let s:PTModeActive = 1
    Pencil
    Goyo
    :silent! call matchadd('MdTodo', 'TODO', -1)<CR>
endfunction

function! s:PTDisable()
    let s:PTModeActive = 0
    NoPencil
    Goyo!
endfunction

function! s:PTToggle()
    if s:PTModeActive
        call s:PTDisable()
    else
        call s:PTEnable()
    endif
endfunction

command! PTToggle call s:PTToggle()
" }}}

" {{{ vim-cursorword
let g:cursorword_highlight = 0
highlight CursorWord0 ctermbg=237 guibg=#3c3836
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
augroup ocaml_group
  au!
  au FileType ocaml setlocal tabstop=2 shiftwidth=2
  au FileType ocaml,dune RainbowToggleOn
  au FileType dune setlocal foldmethod=marker
  au FileType ocaml nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "utop"<CR>
  au FileType ocaml inoremap <A-1> `
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

" {{{ Scheme/Racket
augroup rkt_group
  au!
  au FileType racket inoremap <A-1> `
  au FileType racket inoremap <A-2> '
  au FileType racket inoremap <A-3> λ
  au FileType racket setlocal foldmethod=marker
  au FileType racket setlocal commentstring=;\ %s
  au FileType racket nnoremap <buffer><leader>sC :JbzOpenSlimeREPL "racket"<CR>
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
let g:vimtex_complete_close_braces = 1
let g:tex_conceal='abdmg'

augroup tex_group
  au!
  au FileType tex set sw=2
  au FileType tex call Togglegjgk()
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
  au FileType rst setlocal spell! spelllang=en_us,ru_ru,es_es
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


" {{{ Markdown & org-mode
let g:markdown_fenced_languages = [
 \'python', 'py=python', 'bash=sh', 'c', 'cpp', 'c++=cpp',
 \'asm', 'go', 'rust', 'ocaml', 'cmake', 'diff', 'yaml', 'haskell',
 \'json', 'html', 'sql', 'lua', 'racket', 'vim', 'coq', 'solidity'
 \]
highlight MdTodo ctermfg=red cterm=bold guifg=red gui=bold
highlight MdDone ctermfg=green cterm=bold guifg=green gui=bold
augroup markdown_group
  au!
  au FileType markdown setlocal nofen tw=0 sw=2 foldlevel=0 foldexpr=NestedMarkdownFolds() cocu=nv
  au FileType markdown nmap <buffer> <silent><A-o> <Nop>
  au FileType markdown call Togglegjgk()
  " Insert code blocks
  au FileType markdown nnoremap <buffer> <leader>' i``
  au FileType markdown vnoremap <buffer> <leader>' "sc`<C-r>s`<Esc>
  au FileType markdown nnoremap <buffer> <leader>" i```<cr><cr>```<Esc>ki
  au FileType markdown vnoremap <buffer> <leader>" "sc```<C-r>s```<Esc>
  " Create a new file if not exists.
  au FileType markdown nmap gf :e <cfile><cr>
  " Abbrevations
  au FileType markdown inoremap <buffer> --<space> –<space>
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
  au FileType markdown setlocal spell spelllang=en_us,ru_yo,es_es
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
  au WinEnter,VimEnter,FileType markdown,org syntax match todoCheckbox "\[\ \]" conceal cchar=
  au WinEnter,VimEnter,FileType markdown,org syntax match todoCheckbox "\[x\]" conceal cchar=
  au WinEnter,VimEnter,FileType markdown :silent! call matchadd('MdTodo', 'TODO', -1)
  au WinEnter,VimEnter,FileType markdown :silent! call matchadd('MdDone', 'DONE', -1)
augroup end
" }}}

" {{{ Other ft-specific autocommands
au! BufNewFile,BufReadPost *.{yaml,yml,sublime-syntax} set filetype=yaml foldmethod=indent
au FileType yaml setlocal ts=2 sts=2 sw=2

au FileType conf set foldmethod=marker foldenable
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
    let s:gjgk_mode = 1
  else
    nunmap j
    nunmap k
    nunmap gk
    nunmap gj
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
" }}}

" vim:fdm=marker:fen:sw=2:tw=120
