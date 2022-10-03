function! neoformat#formatters#scilla#enabled() abort
  return ['scilla_fmt']
endfunction

function! neoformat#formatters#scilla#scilla_fmt() abort
  return {
      \ 'exe': 'scilla-fmt',
      \ 'args': ['"%:p"'],
      \ 'stdin': 1,
      \ }
endfunction
