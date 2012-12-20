syntax on

set nocompatible
filetype off

if has('vim_starting')
    set runtimepath+='~/.vim/neobundle.vim.git'
    call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'git://github.com/vim-perl/vim-perl.git'
NeoBundle 'git://github.com/hotchpotch/perldoc-vim'
NeoBundle 'git://github.com/Shougo/neocomplcache'
NeoBundle 'git://github.com/Shougo/neosnippet'
NeoBundle 'git://github.com/Shougo/unite.vim'
NeoBundle 'git://github.com/Shougo/vimfiler'
NeoBundle 'git://github.com/Shougo/vimshell'
NeoBundle 'git://github.com/jjgod/vim-cocoa'
NeoBundle 'git://github.com/thinca/vim-quickrun'
NeoBundle 'git://github.com/edsono/vim-matchit'
NeoBundle 'git://github.com/Shougo/vimproc.git'
NeoBundle 'VimClojure'
NeoBundle 'git://github.com/vim-scripts/TwitVim'
NeoBundle 'git://github.com/Lokaltog/vim-powerline.git'
NeoBundle 'git://github.com/dmitry-ilyashevich/vim-typescript.git'
NeoBundle 'git://github.com/vim-scripts/sudo.vim.git'
NeoBundle 'https://github.com/tpope/vim-fugitive'
NeoBundle 'https://github.com/motemen/git-vim'
NeoBundle 'git://github.com/vim-scripts/dbext.vim.git'

NeoBundle 'git://github.com/bpowell/vim-android.git'
NeoBundle 'git://github.com/vim-scripts/javacomplete.git'
NeoBundle 'git://github.com/vim-scripts/java.vim.git'

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
"colorscheme darkblue
colorscheme wombat
source $HOME/.bundle/vim-matchit/plugin/matchit.vim

filetype on
au BufRead,BufNewFile *.cpp setfiletype cpp
au BufRead,BufNewFile *.pl,*.cgi,*.pm,*.psgi setfiletype perl
autocmd FileType pl,perl,cgi,pm,psgi,t :compiler perl
autocmd FileType html,htm set ts=4 sw=4
autocmd FileType rb  :compiler ruby
autocmd Bufenter *.rb set ts=2 shiftwidth=2
autocmd Bufenter *.js,*.tt set ts=4 sw=4
autocmd Bufenter *.tt,*.tt2 setf tt2html

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"let perl_fold=1
"set foldlevel=1

set clipboard+=unnamed,autoselect
let twitvim_login_b64="czJvc2EuY29tOmxpdGFzMg=="
let twitvim_count = 160

set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v]\ %=\ %{fugitive#statusline()}

highlight statusLine guifg=darkblue guibg=blue gui=none ctermfg=blue ctermbg=grey cterm=none

let g:Powerline_stl_path_style = 'relative'
let g:Powerline_colorscheme='skwp'

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
imap <C-a> <Plug>(neocomplcache_snippets_expand)
smap <C-a> <Plug>(neocomplcache_snippets_expand)
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
    if getline(v:lnum) =~ '^\s*sub\s' || getline(v:lnum) =~ '^\s*any\s'  || getline(v:lnum) =~ '^\s*post\s'  || getline(v:lnum) =~ '^\s*hook\s'
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
map <S-tab> <S-,><S-,>
map <C-i> <S-.><S-.>
imap <C-t> <ESC>:tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>
nmap <C-t> :tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>
nmap <S-,><S-,> :tabprevious<cr>
imap <S-,><S-,> <ESC>:tabprevious<cr>
nmap <S-.><S-.> :tabn<CR>

nmap <C-g> :tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>:VimShell<CR>
imap <C-g> <ESC>:tabe<CR>:VimFiler -split -winwidth=35 -no-quit -simple<CR>:wincmd l<CR>:VimShell<CR>

map <S-w> <UP><UP>
map <S-a> <left><LEFT>
map <S-s> <DOWN><DOWN>
map <S-d> <RIGHT><RIGHT>

set encoding=utf-8
let g:Powerline_symbols = 'fancy'
highlight vimshellPrompt guifg=darkblue guibg=blue gui=none ctermfg=blue ctermbg=grey cterm=none

nmap q :q<CR>

let g:neocomplcache_include_paths = {
\ 'perl' : '/Users/shinichirousatou/shirow-quiz',
\ }
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
let dbext_default_dbname="shirowquiz"
let dbext_default_host="localhost"
let dbext_default_buffer_lines=1000

let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
