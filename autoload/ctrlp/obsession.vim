" =============================================================================
" File: autoload/ctrlp/obsession.vim
" Description: Search for available sessions
" =============================================================================

" To load this extension into ctrlp, add this to your vimrc
"
"   let g:ctrlp_extensions = ['obsession']

" Load guard
if get(g:, 'loaded_ctrl_obsession', 0)
    finish
endif
let g:loaded_ctrl_obsession = 1

" Add settings to g:ctrlp_ext_vars
" - init      : The name of the input function
" - accept    : The name of the action function
" - enter     : called before starting ctrlp
" - exit      : called after closing ctrlp
" - opts      : called when initialising
" - lname     : The long name for the statusline
" - sname     : The short name for the statusline
" - type      : The type of matching (line, path, tabs, tabe)
" - sort      : determine sorting (enabled by default)
" - specinput : Allow special input (disabled by default)
call add(g:ctrlp_ext_vars, {
\   'init'      : 'ctrlp#obsession#init()',
\   'accept'    : 'ctrlp#obsession#accept',
\   'enter'     : 'ctrlp#obsession#enter()',
\   'exit'      : 'ctrlp#obsession#exit()',
\   'opts'      : 'ctrlp#obsession#opts()',
\   'lname'     : 'Select your obsession',
\   'sname'     : 'obsession',
\   'type'      : 'path',
\   'sort'      : 1,
\   'specinput' : 0,
\})

" Show the active sessions
" Yup, this is  the plugin 🙄
" Return: vimlist -  The list of active sessions.
"
function! ctrlp#obsession#init()
    let flist = glob(fnamemodify(g:prosession_dir, ':p').'*.vim', 0, 1)
    let flist = map(flist, "fnamemodify(v:val, ':t:r')")
    let flist = map(flist, "substitute(v:val, '%', '/', 'g')")
    return flist
endfunction

" The action function
" Arguments:
" a:mode    The mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are: 'e','v','t' and 'h' respectively.
" a:str     the selected string
"
function! ctrlp#obsession#accept(mode, str)
    call ctrlp#exit()
    execute 'Prosession' a:str
endfunction

" Do something before entering ctrlp?
function! ctrlp#obsession#enter()
endfunction

" Do something after exiting ctrlp?
function! ctrlp#obsession#exit()
endfunction

" Check options specific to this extension
function! ctrlp#obsession#opts()
endfunction

" Determine an ID for this extension and create a getter
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#obsession#id()
    return s:id
endfunction
