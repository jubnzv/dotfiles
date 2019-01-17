" Definitions for `liuchengxu/vim-which-key` plugin that provides mnemonic keybindinds in
" popup.

let g:which_key_map =  {}
call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" {{{ LanguageClient
let g:which_key_map.l = {
  \ 'name' : '+LSP',
  \ 'a' : ['LanguageClient_textDocument_codeAction()'     , 'action']           ,
  \ 't' : ['LCToggle()'                                   , 'toggle']           ,
  \ 'f' : ['LanguageClient#textDocument_formatting()'     , 'formatting']       ,
  \ 'h' : ['LanguageClient#textDocument_hover()'          , 'hover']            ,
  \ 'r' : ['LanguageClient#textDocument_references()'     , 'references']       ,
  \ 'R' : ['LanguageClient#textDocument_rename()'         , 'rename']           ,
  \ 's' : ['LanguageClient#textDocument_documentSymbol()' , 'document-symbol']  ,
  \ 'S' : ['LanguageClient#workspace_symbol()'            , 'workspace-symbol'] ,
  \ 'g' : {
  \ 'name': '+goto',
  \ 'd' : ['LanguageClient#textDocument_definition()'     , 'definition']       ,
  \ 't' : ['LanguageClient#textDocument_typeDefinition()' , 'type-definition']  ,
  \ 'i' : ['LanguageClient#textDocument_implementation()'  , 'implementation']  ,
  \ },
  \ }
" }}}

" {{{ Git
let g:which_key_map.G = {
  \ 'name' : '+Git',
  \ 'c' : ['Gcommit', 'commit'],
  \ 's' : ['Gstatus', 'status'],
  \ 'b' : ['Gblame', 'blame'],
  \ 'd' : ['Gdiff', 'diff'],
  \ 'f' : ['Gfetch', 'fetch'] ,
  \ 'p' : ['Gpull', 'pull'] ,
  \ 'P' : ['Gpush', 'pull'] ,
  \ 'r' : ['Grebase', 'rebase'] ,
  \ 'm' : ['Gmerge', 'merge'] ,
  \ 'D' : ['Gdelete', 'delete'],
  \ 'e' : ['Gedit', 'edit'] ,
  \ 'M' : ['Gmove', 'move'] ,
  \ 'B' : ['Twiggy', 'branches'],
  \ 'G' : {
  \ 'name': '+Gutter',
  \ 'v' : ['GitGutterPreviewHunk'     , 'preview'],
  \ 'u' : ['GitGutterUndoHunk'     , 'undo'],
  \ 's' : ['GitGutterStageHunk'     , 'stage'],
  \ },
  \ }
" }}}

" {{{ Riv
let g:which_key_map.r = {
  \ 'name' : '+Riv',
  \ 'i' : ['RivProjectIndex', 'index'],
  \ 'r' : ['RivReload', 'reload'],
  \ 't' : {
  \ 'name': '+title',
  \ '0' : ['RivTitle0', '0'],
  \ '1' : ['RivTitle1', '1'],
  \ '2' : ['RivTitle2', '2'],
  \ '3' : ['RivTitle3', '3'],
  \ '4' : ['RivTitle4', '4'],
  \ '5' : ['RivTitle5', '5'],
  \ '6' : ['RivTitle6', '6'],
  \ },
  \ 'o' : {
  \ 'name': '+todo',
  \ 'a' : ['RivTodoAsk', 'ask'],
  \ 'd' : ['RivTodoDate', 'date'],
  \ 'D' : ['RivTodoDel', 'delete'],
  \ 'p' : ['RivTodoPrior', 'priority'],
  \ 't' : ['RivTodoToggle', 'toggle'],
  \ 'u' : ['RivTodoUpdateCache', 'update'],
  \ '1' : ['RivTodoType1', 'type: [  ] '],
  \ '2' : ['RivTodoType2', 'type: TODO '],
  \ '3' : ['RivTodoType2', 'type: FIXME'],
  \ '4' : ['RivTodoType4', 'type: START'],
  \ },
  \ 'a' : {
  \ 'name': '+table',
  \ 'c' : ['RivTableCreate', 'create'],
  \ 'f' : ['RivTableFormat', 'format'],
  \ 'n' : ['RivTableNextCell', 'next cell'],
  \ 'p' : ['RivTablePrevCell', 'prev cell'],
  \ },
  \ 'l' : {
  \ 'name': '+list',
  \ 't' : ['RivListToggle', 'toggle'],
  \ 'd' : ['RivListDelete', 'delete'],
  \ 'n' : ['RivListNew', 'new'],
  \ 'b' : ['RivListSub', 'sub'],
  \ 'p' : ['RivListSup', 'sup'],
  \ '0' : ['RivListType0', 'type: * '],
  \ '1' : ['RivListType1', 'type: 1.'],
  \ '2' : ['RivListType2', 'type: a.'],
  \ '3' : ['RivListType3', 'type: A)'],
  \ '4' : ['RivListType4', 'type: i)'],
  \ },
  \ 'c' : {
  \ 'name': '+create',
  \ 'c' : ['RivCreateContent', 'content'],
  \ 'd' : ['RivCreateDate', 'date'],
  \ 'e' : ['RivCreateEmphasis', 'emphasis'],
  \ 'm' : ['RivCreateExplicitMark', 'mark'],
  \ 'f' : ['RivCreateFoot', 'foot'],
  \ 'g' : ['RivCreateGitLink', 'git link'],
  \ 'h' : ['RivCreateHyperLink', 'hyperlink'],
  \ 'i' : ['RivCreateInterpreted', 'interpreted'],
  \ 'l' : ['RivCreateLink', 'link'],
  \ 'B' : ['RivCreateLiteralBlock', 'code block'],
  \ 'I' : ['RivCreateLiteralInline', 'code inline'],
  \ 's' : ['RivCreateStrong', 'strong'],
  \ 't' : ['RivCreateTime', 'time'],
  \ 'T' : ['RivCreateTransition', 'transition'],
  \ },
  \ 'h' : {
  \ 'name': '+help',
  \ 'd' : ['RivDirectives', 'directives'],
  \ 'q' : ['RivQuickStart', 'quick start'],
  \ 'f' : ['RivHelpFile', 'file?'],
  \ 's' : ['RivHelpSection', 'section?'],
  \ 't' : ['RivHelpTodo', 'todo?'],
  \ 'p' : ['RivPrimer', 'primer'],
  \ 'S' : ['RivSpecification', 'specification'],
  \ 'i' : ['RivInstruction', 'instruction'],
  \ 'I' : ['RivIntro', 'intro'],
  \ },
  \ }
" }}}

" {{{ Pytest
"
" Note: Should be replaced later as autocmd to use similar binds
" with test plugins for other languages.
"
let g:which_key_map.t = {
  \ 'name' : '+Pytest',
  \ 'f' : ['Pytest file', 'file'],
  \ 'c' : ['Pytest class', 'class'],
  \ 'm' : ['Pytest method', 'method'],
  \ 'p' : ['Pytest project', 'project'],
  \ 'd' : ['Pytest function', 'function'],
  \ 's' : ['Pytest session', 'session'],
  \ 'e' : ['Pytest fails', 'fails'],
  \ }
" }}}

" vim:foldmethod=marker:foldenable:sw=2:tw=100
