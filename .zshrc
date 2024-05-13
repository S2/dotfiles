# シェル操作をvim互換にする
bindkey -v

# ディレクトリ名をtabを押して補完するときに選択してるやつに色つける
autoload -U compinit
compinit

# ディレクトリ選択時、最後の/を残す。好み。
setopt noautoremoveslash

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types

# lsコマンドの補完候補にも色付き表示
zstyle ':completion:*:default' list-colors ${LS_COLORS}
# kill の候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

# ヒストリー機能
# command r でコマンド履歴を辿るのでいっぱいにしとく
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

# command Rでヒストリ検索
bindkey ^R history-incremental-search-backward

#cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls;
}

# 消しても挙動が変わらないのでよくわからん
zstyle ':completion:*' list-separator '-->'

# 各種Alias。ショートカット、typoしやすいやつ対策
alias ls="ls -atG"
alias lls="ls"
alias l="ls"
alias gb="git branch" 
alias gd="git diff" 
alias gs="git status"
alias gcp="git cherry-pick"
alias gml='branch=`git symbolic-ref --short HEAD`;git checkout release;git pull origin release;git checkout $branch;git merge release'
alias plack="plackup script/app.psgi -I../wanon2/lib"
alias vim="/usr/bin/vim -p -c 'VimFiler -split -winwidth=35 -no-quit -simple' -c 'wincmd l'"
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
alias supervisord="/Library/Frameworks/Python.framework/Versions/2.7/bin/supervisord -c ~/etc/supervisord.conf"
alias supervisorctl="/Library/Frameworks/Python.framework/Versions/2.7/bin/supervisorctl -c ~/etc/supervisord.conf"
alias g="grep"
alias f="find"
alias dc="docker container ps -a | cut -d ' ' -f 1 | xargs docker kill ; docker compose up"
alias dk="docker container ps -a | cut -d ' ' -f 1 | xargs docker kill"
alias me="cd ~/metaps/cria/cria-admin-console-api/"
alias mw="cd ~/metaps/cria/cria-web-app"
alias mc="cd /Users/sato/metaps/cria/cria-lib-core"
alias gu="cd ~/guncys/soqura-beta"

# わからん。Vim互換の機能っぽいが削除しても変わらん
zle -A .backward-kill-word vi-backward-kill-word
zle -A .backward-delete-char vi-backward-delete-char

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors

# この関数を呼び出したらGitの状態を見られる様にする
# 遅い。
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

# パスを通してる
PATH=$PATH:/Users/sato/bin/:/usr/local/bin/
export PATH

export AWS_CREDENTIAL_FILE=~/cretential

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/air/bin:$PATH"
export PATH="$HOME/node20/bin:$PATH"

export PATH="$HOME/air/atftools:$PATH"
export PATH="$HOME/awsbin:$PATH"

export LDFLAGS=-L/Users/sato/lib
export CPPFLAGS=-I/Users/sato/include

export CPATH=/Users/sato/include
export LIBRARY_PATH=/Users/sato/lib/

export VULKAN_SDK=/Users/sato/vulkan/
export ASSIMP_HOME=/Users/sato/assimp/

export GOPATH="/$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/mysql/bin:$PATH"
export PATH="$HOME/pear/bin:$PATH"
export PATH="$PATH:/Volumes/Extreme SSD/Android/platform-tools"
export PATH="$PATH:$HOME/nginx/sbin/"

export ANDROID_SDK_ROOT=/Users/sato/Library/Android/sdk
export ANDROID_HOME=/Users/sato/Library/Android/sdk
export PATH=/Users/sato/Library/Android/sdk/platform-tools:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sato/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sato/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sato/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sato/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
