" Misc
let mapleader = "-"
set nocompatible

" GUI options
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set relativenumber
set cursorline
set laststatus=2 " always show status line

" Relative or absolute number lines
function! NumberToggle()
    if(&nu == 1)
        set nu!
        set rnu
    else
        set nornu
        set nu
    endif
endfunction
"""

""" Keybindings
nmap <F1> :echo <CR>
imap <F1> <C-o>:echo <CR>
nnoremap <F9> :call NumberToggle()<CR>
imap jj <Esc>
imap <C-f> <right>
imap <C-b> <left>
imap <C-p> <up>
imap <C-n> <down>
imap <A-f> <right>
imap <A-b> <left>
map <Leader>j <Esc>
map <Leader>w :w<cr>
map <Leader>x :x<cr>
map <Leader>q :q<cr>
map <Leader>` :qa!<cr>
map <Leader>= :bn<cr>
map <Leader>- :bp<cr>
map <Leader>+ :bd<cr>
map <C-X><C-C> :qa<cr>
map <C-X><C-D> :bd<cr>
inoremap <Leader>; <C-o>A;
inoremap <Leader>j; <C-o>A;<CR>

""" Appearance
set wildmenu
set wildmode=longest,list

" Coding style
set tabstop=4
set shiftwidth=4
set expandtab  " on pressing tab insert 4 spaces
" 80+ characters line highlight
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Highlight trailing spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
