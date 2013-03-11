bindkey -v
autoload -U compinit
compinit
setopt noautoremoveslash

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# lsコマンドの補完候補にも色付き表示
eval `gdircolors`
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# ヒストリー機能
HISTFILE=~/.zsh_history      # ヒストリファイルを指定
HISTSIZE=10000               # ヒストリに保存するコマンド数
SAVEHIST=10000               # ヒストリファイルに保存するコマンド数
setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録
zstyle ':completion:*:default' menu select

#cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls;
}

zstyle ':completion:*' list-separator '-->'
alias ls="ls -atG"
alias lls="ls"
alias gd="git diff" 
alias gs="git status"
alias plack="plackup script/app.psgi -I../wanon2/lib"
alias plack20000="plackup script/app.psgi -I../wanon2/lib -p 20000"
alias vim="vim -p -c 'VimFiler -split -winwidth=35 -no-quit -simple' -c 'wincmd l'"
alias vv="vim"
alias v="vim"
alias :wq="exit"
alias :q="exit"
alias gm="git merge"
alias ga="git add"
alias gp="git push"
alias gc="git commit"
alias gl="git log"
alias gco="git checkout"
alias gcp="git checkout"

zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

function rprompt-git-current-branch {
    local name st color
    
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
            return
    fi
    name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
    if [[ -z $name ]]; then
            return
    fi
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
            color=${fg[green]}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
            color=${fg[yellow]}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
            color=${fg_bold[red]}
    else
            color=${fg[red]}
    fi
    
    # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
    # これをしないと右プロンプトの位置がずれる
    echo "%{$color%}$name%{$reset_color%} "
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
PROMPT='%F{green}%W %f %(5~,%-2~/.../%2~,%~) `rprompt-git-current-branch`# '

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "/Users/shinichirousatou/.rvm/scripts/rvm" ]] && source "/Users/shinichirousatou/.rvm/scripts/rvm"

PATH=$PATH:/usr/local/mysql-5.5.27/bin/
PATH=$PATH:/usr/local/mysql-5.5.27/scripts/
PATH=$PATH:/usr/local/pgsql/bin/
PATH=$PATH:/usr/local/node/bin/
PATH=$PATH:/usr/local/bin/
export PATH
PGDATA=/usr/local/pgsql/bin/data
export PGDATA

BOOST_PATH=/usr/local/boost
export BOOST_PATH

source ~/perl5/perlbrew/etc/bashrc
source ~/.phpbrew/bashrc

GTEST_DIR=/Users/shinichirousatou/gtesta-1.6.0

