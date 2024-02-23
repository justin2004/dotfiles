"""""""""""""""""""""""""""
" for vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-dadbod'
Plugin 'moll/vim-node'
Plugin 'leafgarland/typescript-vim'
Plugin 'jpalardy/vim-slime'
" Plugin 'https://gitlab.com/n9n/vim-apl'   " where is my fork
Plugin 'https://github.com/justin2004/vim-apl'
Plugin 'https://github.com/skywind3000/asyncrun.vim'
Plugin 'junegunn/fzf'
"Plugin 'francoiscabrol/ranger.vim'
Plugin 'rbgrouleff/bclose.vim'
"Plugin 'preservim/nerdtree'
Plugin 'jeetsukumaran/vim-pythonsense'
Plugin 'justin2004/w3m.vim'  "my fork of 'yuratomo/w3m.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
" Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-markdown'
Plugin 'niklasl/vim-rdf'
Plugin 'yegappan/grep'
Plugin 'reedes/vim-pencil'
" Plugin 'chrisbra/csv.vim'

Plugin 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

Plugin 'guns/vim-sexp'
Plugin 'liquidz/vim-iced'

" for LSP
Plugin 'prabirshrestha/async.vim'
"Plugin 'prabirshrestha/vim-lsp'
"Plugin 'mattn/vim-lsp-settings'
"""""""""""""""""""

" another LSP client
Plugin 'natebosch/vim-lsc'

Plugin 'sotte/presenting.vim'
Plugin 'junegunn/goyo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'neo4j-contrib/cypher-vim-syntax'
Plugin 'vim-scripts/sparql.vim'

"Plugin 'udalov/kotlin-vim'
"Plugin 'klen/python-mode'
"Plugin 'fatih/vim-go'

Plugin 'vim-scripts/utl.vim'
Plugin 'justin2004/vim-repo-edit'

call vundle#end()
filetype plugin indent on
"""""""""""""""""""""""""""


au BufRead,BufNewFile *.ts setfiletype typescript

syntax enable
set background=dark
set hlsearch
set incsearch
set modeline
set modelines=5
set ruler
" set relativenumber
set wildmenu
set noignorecase " having ignorecase caused me to not see (for like 30 mins) i was using the wrong variable
set smartcase
set noshowmode
set belloff=all
set hidden

" git gutter update
set updatetime=100

" TODO how does this interact with editorconfig?
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 
" smarttab
"set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab


" tree
let g:netrw_liststyle=3

let g:slime_target="tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{down-of}"}
"let g:slime_no_mappings=1
let g:slime_python_ipython = 1

"map  1G!Ggnuplot -persist
"map  1G!Gnode
map  :Utl

set history=10000

" always on status line
set laststatus=2
"set statusline=%f\ %b\ %B\ %l\ %m\ %r
"set statusline=%f\ %b\ %B\ %l\ %c
"set statusline=%f\ %l\ %c\ %m
set statusline=%f\ %y\ %m\ %p%%\ %l\ %c
hi StatusLine ctermbg=White ctermfg=DarkBlue

"""""""  for vim as a rest client
"mm1Gvap"cy'mvap"Cy:split +put\ c buf0:set buftype=nofile:file! `mktemp`1G!Gbash

" better if you want to look at the results in an external tool
"mm1Gvap"cy'mvap"Cy:split +put\ c buf0:set buftype=nofile:file! `mktemp`1G!Gbash:w /tmp/lala1.csv:q'mzz:AsyncRun tmux split-window 'vd /tmp/lala1.csv'
""""""""""""""""""""""""


" python
"set tabstop=8 expandtab shiftwidth=4 softtabstop=4









"""""""""""""""""""""""""""""""""""
" https://github.com/ranger/ranger/blob/master/examples/vim_file_chooser.vim

" Compatible with ranger 1.4.2 through 1.7.*
"
" Add ranger as a file chooser in vim
"
" If you add this code to the .vimrc, ranger can be started using the command
" ":RangerChooser" or the keybinding "<leader>r".  Once you select one or more
" files, press enter and ranger will quit again and vim will open the selected
" files.

function! RangeChooser()
    let temp = tempname()
    " The option "--choosefiles" was added in ranger 1.5.1. Use the next line
    " with ranger 1.4.2 through 1.5.0 instead.
    "exec 'silent !ranger --choosefile=' . shellescape(temp)
    if has("gui_running")
        exec 'silent !xterm -e ranger --choosefiles=' . shellescape(temp)
    else
        exec 'silent !ranger --choosefiles=' . shellescape(temp)
    endif
    if !filereadable(temp)
        redraw!
        " Nothing to read.
        return
    endif
    let names = readfile(temp)
    if empty(names)
        redraw!
        " Nothing to open.
        return
    endif
    " Edit the first item.
    exec 'edit ' . fnameescape(names[0])
    " Add any remaning items to the arg list/buffer list.
    for name in names[1:]
        exec 'argadd ' . fnameescape(name)
    endfor
    redraw!
endfunction
command! -bar RangerChooser call RangeChooser()
nnoremap <leader>r :<C-U>RangerChooser<CR>
"""""""""""""""""""""""""""""""""""


" not using this LSP client anymore
"set runtimepath+=/home/justin/repos/others/DONT_BACKUP/LanguageClient-neovim
"let g:LanguageClient_loggingFile = expand('/mnt/b/thelog')
"let g:LanguageClient_loggingLevel = 'DEBUG'
"let g:LanguageClient_serverStderr = expand('/mnt/b/stderr')




"let g:lsc_server_commands = {'java': 'bash -c "socat - TCP:127.0.0.1:1044"'}

let g:lsc_server_commands = {'groovy': {'name':'groovy-langserver',  'command': 'docker run --rm -i groovy'}}
"call extend(g:lsc_server_commands, {'java': {'name': 'java-langserver',    'command': 'bash -c "docker run --rm -i -v `pwd`:`pwd` -i justin2004/lsp-java"'}})
"
" TODO need to fix java:
" call extend(g:lsc_server_commands, {'java': {'name': 'java-langserver',    'command': 'bash -c "docker run --rm -i -v `pwd`:`pwd` -i justin2004/java-language-server_box"'}})
"call extend(g:lsc_server_commands, {'go'  : {'name': 'go-langserver',  'command': 'docker run --rm -i justin2004/gopls_box', 'log_level':-1, 'suppress_stderr': v:false}})
"call extend(g:lsc_server_commands, {'go'  : {'name': 'go-langserver',  'command': 'docker run --rm -i justin2004/gopls_box'}})
call extend(g:lsc_server_commands, {'go'  : {'name': 'go-langserver', 'command': 'bash -c "docker run --rm -i -v `pwd`:`pwd` justin2004/gopls_box"', 'log_level':-1,'suppress_stderr':v:true}})
call extend(g:lsc_server_commands, {'sparql'  : {'name': 'sparql-langserver', 'command': 'docker run --rm -i justin2004/sparql-language-server_box','log_level':-1,'suppress_stderr':v:true}})
"call extend(g:lsc_server_commands, {'turtle'  : {'name': 'turtle-langserver', 'command': 'bash -c "docker run --rm -i -v `pwd`:`pwd` justin2004/sparql-language-server_box"','log_level':-1,'suppress_stderr':v:true}})
call extend(g:lsc_server_commands, {'javascript': {'name': 'javascript-langserver',    'command': 'bash -c "docker run --rm -i -v `pwd`:`pwd` -i justin2004/javascript-typescript-langserver_box"'}})
let g:lsc_auto_map = v:true
let g:lsc_trace_level = 'messages'
set completeopt=menu,menuone,noinsert,noselect



" set the filetype to 'sparql' for .sparql and .rq
au BufRead,BufNewFile *.{sparql,rq}   setfiletype sparql
au BufRead,BufNewFile *.{turtle,ttl}  setfiletype turtle


"au FileType w3m W3mSetUserAgent w3m 0
"au FileType w3m call w3m#SetUserAgent('w3m', 0)
"au FileType w3m let g:w3m#user_agent='w3m'
au FileType w3m let g:w3m#search_engine='http://www.duckduckgo.com/html/?q=%s'

au BufRead,BufNewFile *.{asd}   setfiletype lisp

" modeline example
" # vim: set expandtab:

" TODO do i want this just for vim-iced?
let mapleader = ","

let g:iced_enable_default_key_mappings = v:true
let g:iced_enable_auto_document = 'insert'

" TODO the problem with this approach is that pressing esc then j or k
" invokes a function
"
" <M-k> style mappings don't work with gnome-terminal so i manually
" modified some of them here:
" let g:sexp_mappings = {
"     \ 'sexp_outer_list':                'af',
"     \ 'sexp_inner_list':                'if',
"     \ 'sexp_outer_top_list':            'aF',
"     \ 'sexp_inner_top_list':            'iF',
"     \ 'sexp_outer_string':              'as',
"     \ 'sexp_inner_string':              'is',
"     \ 'sexp_outer_element':             'ae',
"     \ 'sexp_inner_element':             'ie',
"     \ 'sexp_move_to_prev_bracket':      '(',
"     \ 'sexp_move_to_next_bracket':      ')',
"     \ 'sexp_move_to_prev_element_head': 'b',
"     \ 'sexp_move_to_next_element_head': 'w',
"     \ 'sexp_move_to_prev_element_tail': 'g<M-e>',
"     \ 'sexp_move_to_next_element_tail': '<M-e>',
"     \ 'sexp_flow_to_prev_close':        '<M-[>',
"     \ 'sexp_flow_to_next_open':         '<M-]>',
"     \ 'sexp_flow_to_prev_open':         '<M-{>',
"     \ 'sexp_flow_to_next_close':        '<M-}>',
"     \ 'sexp_flow_to_prev_leaf_head':    '<M-S-b>',
"     \ 'sexp_flow_to_next_leaf_head':    '<M-S-w>',
"     \ 'sexp_flow_to_prev_leaf_tail':    '<M-S-g>',
"     \ 'sexp_flow_to_next_leaf_tail':    '<M-S-e>',
"     \ 'sexp_move_to_prev_top_element':  '[[',
"     \ 'sexp_move_to_next_top_element':  ']]',
"     \ 'sexp_select_prev_element':       '[e',
"     \ 'sexp_select_next_element':       ']e',
"     \ 'sexp_indent':                    '==',
"     \ 'sexp_indent_top':                '=-',
"     \ 'sexp_round_head_wrap_list':      '<LocalLeader>i',
"     \ 'sexp_round_tail_wrap_list':      '<LocalLeader>I',
"     \ 'sexp_square_head_wrap_list':     '<LocalLeader>[',
"     \ 'sexp_square_tail_wrap_list':     '<LocalLeader>]',
"     \ 'sexp_curly_head_wrap_list':      '<LocalLeader>{',
"     \ 'sexp_curly_tail_wrap_list':      '<LocalLeader>}',
"     \ 'sexp_round_head_wrap_element':   '<LocalLeader>w',
"     \ 'sexp_round_tail_wrap_element':   '<LocalLeader>W',
"     \ 'sexp_square_head_wrap_element':  '<LocalLeader>e[',
"     \ 'sexp_square_tail_wrap_element':  '<LocalLeader>e]',
"     \ 'sexp_curly_head_wrap_element':   '<LocalLeader>e{',
"     \ 'sexp_curly_tail_wrap_element':   '<LocalLeader>e}',
"     \ 'sexp_insert_at_list_head':       '<LocalLeader>h',
"     \ 'sexp_insert_at_list_tail':       '<LocalLeader>l',
"     \ 'sexp_splice_list':               '<LocalLeader>@',
"     \ 'sexp_convolute':                 '<LocalLeader>?',
"     \ 'sexp_raise_list':                '<LocalLeader>o',
"     \ 'sexp_raise_element':             '<LocalLeader>O',
"     \ 'sexp_swap_list_backward':        'k',
"     \ 'sexp_swap_list_forward':         'j',
"     \ 'sexp_swap_element_backward':     'h',
"     \ 'sexp_swap_element_forward':      'l',
"     \ 'sexp_emit_head_element':         'J',
"     \ 'sexp_emit_tail_element':         'K',
"     \ 'sexp_capture_prev_element':      'H',
"     \ 'sexp_capture_next_element':      'L',
"     \ }



function! CleverTab()
if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
else
    return "\<C-N>"
    "return "\<C-X>\<C-O>"
endif
endfunction

"inoremap <silent> <buffer> <Tab>  <C-R>=CleverTab()<CR>
inoremap <silent> <Tab>  <C-R>=CleverTab()<CR>





function! LookAtImage(...)
        " let fpath=expand('<cfile>')
        let fpath=expand('%')
        execute('!feh --force-aliasing ' . fpath)
endfunction
" au BufRead *.png,*.jpg,*.jpeg :call LookAtImage()
au BufEnter *.png,*.jpg,*.jpeg :call LookAtImage()



au BufRead *.xml let &l:equalprg='xmllint --format --recover -'


" i think the window with the filename is the recovered file
" [scratch] is the non-recovered
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
      \ | wincmd p | diffthis


" for using 'francoiscabrol/ranger.vim' instead of NERDTree
" let g:NERDTreeHijackNetrw = 0  " add this line if you use NERDTree
" let g:ranger_replace_netrw = 1 " open ranger when vim open a directory



" let g:utl_cfg_hdl_scm_http = "!echo %u#%f"
let g:utl_cfg_hdl_scm_http = ":W3m %u"
" let g:utl_cfg_hdl_scm_http = ":W3m %u%f"
" TODO does :W3m handle fragments?

"TODO   maybe make a tmux pane instead of xterm?
let g:utl_cfg_hdl_scm_mailto = "!xterm -e mutt '%u'" 
" let g:utl_cfg_hdl_scm_mailto = "!echo '%u' '%f'" 


" let g:utl_cfg_hdl_mt_generic = 'silent !konqueror "%p" &'
let g:utl_cfg_hdl_mt_generic = ':edit %p'


" Per default, netrw leaves unmodified buffers open. This autocommand
" deletes netrw's buffer once it's hidden (using ':q', for example)
autocmd FileType netrw setl bufhidden=delete



" it was previously /*   */  which isn't valid
au FileType turtle set commentstring=#%s
au FileType sparql set commentstring=#%s

au BufRead,BufNewFile .gitattributes setfiletype gitattributes
au FileType gitattributes set commentstring=#%s

au FileType turtle set iskeyword=@,48-57,_,192-255,:,-,<,>,/,.
" augroup FileTypeSettings
"     autocmd!
"     autocmd FileType turtle setlocal iskeyword=@,48-57,_,192-255,:,-,<,>,/,.
" augroup END




" " for suckless ii       <url:https://tools.suckless.org/ii/>
" "         thanks to    https://unix.stackexchange.com/questions/82058/how-do-i-make-vim-behave-like-tail-f
" au! BufRead,BufNewFile */out
" au BufRead,BufNewFile */out setfiletype iiout
" " au BufRead,BufNewFile out silent !mpv --start 10 --end 11 ~/Music/LEON.wav &
" au BufRead,BufNewFile out silent :AsyncRun mpv --start 25 --end 26 ~/Music/LEON.wav &
" au FileType iiout setl nomodeline   " TODO when i source vimrc from the out file it ignores this
" au FileType iiout set nomodeline
" " TODO use  |FocusGained|	so we don't hear a sound when i am in the window
" " VimEnter,VimResume, VimLeave,VimSuspend
" au FileType iiout setl updatetime=1500 " i have to increase this so that the call to feedkeys() doesn't disrupt my multi-key presses
" au FileType iiout setl autoread | au CursorHold out checktime | if line('.') == line('w$') | call feedkeys("G") | else | call feedkeys("lh") | endif
" au FileType iiout syn match	me /justin20044/
" au FileType iiout hi default link me Function


" do i like this?
"    yes
set cpo+=$


" vim-markdown
let g:markdown_fenced_languages = ['erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'xml', 'html', 'python', 'bash=sh','lisp','clj=clojure']

" TODO conditional 
" call iced#hook#add('evaluated', {
"      \ 'type': 'function',
"      \ 'exec': {d -> iced#buffer#stdout#append(d['result']['value'])},
"      \ })


" spell check on by default 
" set spell


" function! MyBalloonExpr()
"     let l:word_under_cursor = expand('<cword>')
"     let l:tooltip_text = 'Tooltip for: ' . l:word_under_cursor
"     return l:tooltip_text
" endfunction

function! BuildCommand(uri)
    " let l:uri = matchstr(expand('<cword>'),'\%(\k\+\)')
    "

    let l:command = '~/Downloads/apache-jena-4.10.0/bin/sparql --results=csv --data some.ttl --query <(cat prefixes.ttl ; echo "select * where { ' . a:uri . ' ex:name ?o} limit 1") | tail -1'
    echom 'running command ' . l:command
    let l:result = system(l:command)
    return l:result
endfunction

" set laststatus=2
" set statusline+=%{MyKeyword()}
" function! MyKeyword()
"     let l:uri = matchstr(expand('<cword>'), '\%(\k\+\)')
"     let l:command = '~/Downloads/apache-jena-4.10.0/bin/sparql --results=csv --data some.ttl --query <(cat prefixes.ttl ; echo "select * where { ' . l:uri . ' ex:name ?o} limit 1") | tail -1'
"     " return matchstr(expand('<cword>'), '\%(\k\+\)')
"     let l:result = system(l:command)
"     return l:result
" endfunction

