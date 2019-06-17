" Saves image from clipboard in ./img and paste it into markdown document.
" Based on: https://github.com/ferrine/md-img-paste.vim/
function! SafeMkdir()
    let outdir = expand('%:p:h') . '/' . g:pasteimage_imgdir
    if !isdirectory(outdir)
        call mkdir(outdir)
    endif
    return fnameescape(outdir)
endfunction

function! SaveFile(imgdir, tmpname) abort
    let targets = filter(
                \ systemlist('xclip -selection clipboard -t TARGETS -o'),
                \ 'v:val =~# ''image''')
    if empty(targets) | return 1 | endif

    let mimetype = targets[0]
    let extension = split(mimetype, '/')[-1]
    let tmpfile = a:imgdir . '/' . a:tmpname . '.' . extension
    call system(printf('xclip -selection clipboard -t %s -o > %s',
                \ mimetype, tmpfile))
    return tmpfile
endfunction

function! SaveNewFile(imgdir, tmpfile)
    let extension = split(a:tmpfile, '\.')[-1]
    let reldir = g:pasteimage_imgdir
    let cnt = 0
    let filename = a:imgdir . '/' . g:pasteimage_imgname . cnt . '.' . extension
    let relpath = reldir . '/' . g:pasteimage_imgname . cnt . '.' . extension
    while filereadable(filename)
        call system('diff ' . a:tmpfile . ' ' . filename)
        if !v:shell_error
            call delete(a:tmpfile)
            return relpath
        endif
        let cnt += 1
        let filename = a:imgdir . '/' . g:pasteimage_imgname . cnt . '.' . extension
        let relpath = reldir . '/' . g:pasteimage_imgname . cnt . '.' . extension
    endwhile
    if filereadable(a:tmpfile)
        call rename(a:tmpfile, filename)
    endif
    return relpath
endfunction

function! GetName()
    " let new_name = input("Enter name of image: ")
    " return l:new_name
    let l:new_random = strftime("%Y-%m-%d-%H:%M")
    return l:new_random
endfunction

function! pasteimage#MarkdownClipboardImage()
    let workdir = SafeMkdir()
    " change temp-file-name and image-name
    let g:pasteimage_tmpname = GetName()

    let tmpfile = SaveFile(workdir, g:pasteimage_tmpname)
    if tmpfile == 1
        return
    else
        let extension = split(tmpfile, '\.')[-1]
        let relpath = g:pasteimage_imgdir . '/' . g:pasteimage_tmpname . '.' . extension
        execute "normal! i![Image](" . relpath . ")"
    endif
endfunction

if !exists('g:pasteimage_imgdir')
    let g:pasteimage_imgdir = 'img'
endif
if !exists('g:pasteimage_tmpname')
    let g:pasteimage_tmpname = 'tmp'
endif
if !exists('g:pasteimage_imgname')
    let g:pasteimage_imgname = 'image'
endif
