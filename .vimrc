if &compatible
  set nocompatible
endif
set runtimepath+=/root/.dein/repos/github.com/Shougo/dein.vim

if dein#load_state('/root/.deinlib')
    call dein#begin('/root/.deinlib')
    
    call dein#add('/root/.dein/repos/github.com/Shougo/dein.vim')
    call dein#add('Shougo/neocomplete.vim')
    
    call dein#add('vim-perl/vim-perl')
    call dein#add('hotchpotch/perldoc-vim')
    call dein#add('Shougo/neocomplcache')
    call dein#add('Shougo/neosnippet')
    call dein#add('S2/neosnippet-snippets.git')
    call dein#add('Shougo/unite.vim')
    call dein#add('Shougo/vimfiler')
    call dein#add('Shougo/vimshell')
    call dein#add('thinca/vim-quickrun')
    call dein#add('jwhitley/vim-matchit')
    call dein#add('Shougo/vimproc.git' , {'build' : 'make'})
    call dein#add('vim-scripts/VimClojure')
    call dein#add('Lokaltog/vim-powerline.git')
    call dein#add('leafgarland/typescript-vim')
    call dein#add('vim-scripts/sudo.vim.git')
    call dein#add('tpope/vim-fugitive')
    call dein#add('motemen/git-vim')
    call dein#add('vim-scripts/dbext.vim.git')
    call dein#add('xolox/vim-misc.git')
    call dein#add('xolox/vim-lua-ftplugin')
    call dein#add('vim-scripts/nginx.vim.git')
    call dein#add('bpowell/vim-android.git')
    call dein#add('vim-scripts/javacomplete.git')
    call dein#add('vim-scripts/java.vim.git')
    call dein#add('vim-scripts/taglist.vim.git')
    call dein#add("tsukkee/unite-tag.git")
    call dein#add("tyru/current-func-info.vim.git")
    call dein#add("mattn/gist-vim.git")
    call dein#add('basyura/twibill.vim.git')
    call dein#add('tyru/open-browser.vim.git')
    call dein#add('mattn/webapi-vim.git')
    call dein#add('h1mesuke/unite-outline.git')
    call dein#add('basyura/bitly.vim.git')
    call dein#add('mattn/favstar-vim.git')

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

filetype plugin on
filetype indent on

set nocp
set number
set nowrap
set backspace=2
set shiftwidth=4
set ts=4
set expandtab
set list
set hlsearch
set showmatch
set wildmenu
set ruler
set cmdheight=2
set title
set smartindent
colorscheme darkblue

filetype on
au BufRead,BufNewFile *.cpp setfiletype cpp
au BufRead,BufNewFile *.pl,*.cgi,*.pm,*.psgi setfiletype perl
au BufRead,BufNewFile *.ts setfiletype typescript
au BufRead,BufNewFile *.conf setfiletype nginx 
au BufRead,BufNewFile *.lua setfiletype lua 
au BufRead,BufNewFile *.js setfiletype javascript
au BufRead,BufNewFile *.tt,*.tt2 setfiletype html

autocmd FileType pl,perl,cgi,pm,psgi,t :compiler perl
autocmd FileType html,htm set ts=4 sw=4
autocmd FileType rb  :compiler ruby

autocmd Bufenter *.rb set ts=2 shiftwidth=2
autocmd Bufenter *.js,*.tt set ts=4 sw=4

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

set clipboard+=unnamed,autoselect

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]\ %=\ %{fugitive#statusline()}\ [%{cfi#get_func_name()}()]

highlight statusLine guifg=darkblue guibg=blue gui=none ctermfg=blue ctermbg=grey cterm=none

let g:Powerline_symbols = 'fancy'
set guifont='SourceCodePro-Regular-Powerline'

highlight vimshellPrompt guifg=darkblue guibg=blue gui=none ctermfg=blue ctermbg=grey cterm=none

hi Folded ctermfg=black ctermbg=grey cterm=bold

set backupskip=/tmp/*,/private/tmp/*
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

let g:vimfiler_as_default_explorer=1
let g:vimfiler_safe_mode_by_default=0

let g:NeoComplCache_Ctags_Arguments_List = {
            \ 'perl' : '-R -h ".pm"'
            \ }

let g:NeoComplCache_Snippets_Dir = '~/.vim/snippets'

" Define dictionary.
let g:NeoComplCache_DictionaryFileTypeLists = { 
            \ 'default'    : '',
            \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
            \ }

" Define Keybinds.

" for snippets
imap <C-a> <Plug>(neosnippet_jump_or_expand)
smap <C-a> <Plug>(neosnippet_jump_or_expand)
let g:neocomplcache_disable_auto_complete = 1
let g:neocomplcache_max_list = 30

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || (getline('.')[col - 1] !~ '\k' && getline('.')[col - 1]  != '>' && getline('.')[col - 1]  != '$')
        return "\<TAB>"
    else
        if pumvisible()
            return "\<C-N>\<C-N>\<C-N>"
        else
            return "\<C-N>\<C-P>"
        end
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function! InsertSpaceWrapper()
    if pumvisible()
        return neocomplcache#smart_close_popup()
    else
        return "\<Space>"
    end
endfunction
inoremap <Space> <c-r>=InsertSpaceWrapper()<cr>

noremap <C-e> :Unite buffer<CR>
noremap <C-d> :VimFiler -split -winwidth=35 -no-quit -simple<CR>
noremap <C-z> :VimFilerBufferDir -split -winwidth=35 -no-quit -simple<CR>
noremap <E> :VimFiler -double -vsplit<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default=0

function GetPerlFold()
    if getline(v:lnum) =~ '^\s*sub\s' || getline(v:lnum) =~ '^\s*any\s'  || getline(v:lnum) =~ '^\s*post\s'  || getline(v:lnum) =~ '^\s*hook\s' || getline(v:lnum) =~ '^\s*any\s' || getline(v:lnum) =~ '^\s*subtest\s' || getline(v:lnum) =~ '^\s*get\s'
        return ">1"
    elseif getline(v:lnum) =~ '^\};\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
            else
                return "<1"
            endif
        endwhile
    elseif getline(v:lnum) =~ '\}\s*$' 
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
                " do nothing
            elseif my_perldata =~ '^\s*sub\s'
                return "<1"
            else
                return "="
            endif
        endwhile
    else
        return "="
    endif
endfunction

autocmd FileType pl,perl,cgi,pm,psgi,t :setlocal foldexpr=GetPerlFold()
autocmd FileType pl,perl,cgi,pm,psgi,t :setlocal foldmethod=expr

function GetJSFold()
    if getline(v:lnum) =~ '^\s\{1,8}function' || getline(v:lnum) =~ '^.*:\s*function' || getline(v:lnum) =~ '^.*=\s*function'  
        return ">1"
    elseif getline(v:lnum) =~ '^\};\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
            else
                return "<1"
            endif
        endwhile
    elseif getline(v:lnum) =~ '\}\s*$' 
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
                " do nothing
            elseif my_perldata =~ '^\s*sub\s'
                return "<1"
            else
                return "="
            endif
        endwhile
    else
        return "="
    endif
endfunction

autocmd FileType javascript :setlocal foldexpr=GetJSFold()
autocmd FileType javascript :setlocal foldmethod=expr

function GetTSFold()
    if getline(v:lnum) =~ '^\s\+public' || getline(v:lnum) =~ '^\s\+private' || getline(v:lnum) =~ '^\s\+protected'
        return ">1"
    elseif getline(v:lnum) =~ '^\s\{0,4}\}\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
            else
                return "<1"
            endif
        endwhile
    elseif getline(v:lnum) =~ '^\s\{0,8}\}\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
            else
                return "<2"
            endif
        endwhile
    elseif getline(v:lnum) =~ '^\s\{0,8}\};\s*$'
        let my_perlnum = v:lnum
        let my_perlmax = line("$")
        while (1)
            let my_perlnum = my_perlnum + 1
            if my_perlnum > my_perlmax
                return "<1"
            endif
            let my_perldata = getline(my_perlnum)
            if my_perldata =~ '^\s*\(\#.*\)\?$'
                " do nothing
            elseif my_perldata =~ '^\s*sub\s'
                return "<1"
            else
                return "="
            endif
        endwhile
    else
        return "="
    endif
endfunction

autocmd FileType typescript :setlocal foldexpr=GetTSFold()
autocmd FileType typescript :setlocal foldmethod=expr

function GetCFold()
    if getline(v:lnum) =~ '^-' || getline(v:lnum) =~ '^+' 
        return ">1"
    elseif getline(v:lnum) =~ '^\}\s*$'
        return "<1"
    else
        return "="
    endif
endfunction

autocmd Bufenter *.m :setlocal foldexpr=GetCFold()
autocmd Bufenter *.m :setlocal foldmethod=expr

set showtabline=1
nmap <S-tab> <S-,><S-,>
map <C-i> <S-.><S-.>
imap <C-t> <ESC>:tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>
nmap <C-t> :tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>
nmap <S-,><S-,> :tabprevious<cr>
imap <S-,><S-,> <ESC>:tabprevious<cr>
nmap <S-.><S-.> :tabn<CR>

map <S-w> <UP><UP>
map <S-a> <left><LEFT>
map <S-s> <DOWN><DOWN>
map <S-d> <RIGHT><RIGHT>

map i <UP>
map j <left>
map k <DOWN>
nnoremap <silent> <l> @=(foldlevel('.')?'za':"\<RIGHT>")<CR>
nmap h :
set encoding=utf-8

nmap q :q<CR>

"インクルード文のパターンを指定
let g:neocomplcache_include_patterns = {
\ 'perl' : '^\s*use',
\ }
"インクルード先のファイル名の解析パターン
let g:neocomplcache_include_exprs = {
\}
" ファイルを探す際に、この値を末尾に追加したファイルも探す。
let g:neocomplcache_include_suffixes = {
\ 'perl' : '.pm',
\ }

let g:neocomplcache_enable_at_startup = 1

let dbext_default_profile=""
let dbext_default_type="MYSQL"
let dbext_default_user="root"
let dbext_default_passwd=""
let dbext_default_dbname="kuroneco"
let dbext_default_host="localhost"
let dbext_default_buffer_lines=1000

let g:quickrun_config = {'*': {'hook/time/enable': '1'},}

" path にヘッダーファイルのディレクトリを追加することで
" neocomplcache が include 時に tag ファイルを作成してくれる
set path+=$LIBSTDCPP
set path+=$BOOST_LATEST_ROOT

" neocomplcache が作成した tag ファイルのパスを tags に追加する
function! s:TagsUpdate()
    " include している tag ファイルが毎回同じとは限らないので毎回初期化
    setlocal tags=
    for filename in neocomplcache#sources#include_complete#get_include_files(bufnr('%'))
        execute "setlocal tags+=".neocomplcache#cache#encode_name('tags_output', filename)
    endfor
endfunction


command!
    \ -nargs=? PopupTags
    \ call <SID>TagsUpdate()
    \ |Unite tag:<args>

function! s:get_func_name(word)
    let end = match(a:word, '<\|[\|(')
    return end == -1 ? a:word : a:word[ : end-1 ]
endfunction


" カーソル下のワード(word)で絞り込み
noremap <silent> <C-m> :<C-u>execute "PopupTags ".expand('<cword>')<CR>
noremap <silent> <C-]> :<C-u>execute "PopupTags ".expand('<cword>')<CR>

" Uniteを開く時、垂直分割で開く
let g:unite_winheight=10
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-t> unite#do_action('tabopen')

au FileType unite nnoremap <silent> <buffer> <expr> <C-e> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-e> unite#do_action('vsplit')

setlocal iskeyword-=_

function GetNginxFold()
    if getline(v:lnum) =~ '^\s*location'
        return ">1"
    elseif getline(v:lnum) =~ '^\s*if\s*('
        return ">2"
    elseif getline(v:lnum) =~ '^\s{8}}'
        return "<1"
    elseif getline(v:lnum) =~ '^\s{12}*}'
        return "<2"
    else
        return "="
    endif
endfunction
autocmd FileType nginx :setlocal foldexpr=GetNginxFold()
autocmd FileType nginx :setlocal foldmethod=expr

