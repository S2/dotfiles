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
alias gpc="git push origin `git branch | grep '*' | cut -d ' ' -f 2`"
alias gmc="git pull origin `git branch | grep '*' | cut -d ' ' -f 2`"
alias gc="git commit"
alias gl="git log"
alias gco="git checkout"
alias supervisord="/Library/Frameworks/Python.framework/Versions/2.7/bin/supervisord -c ~/etc/supervisord.conf"
alias supervisorctl="/Library/Frameworks/Python.framework/Versions/2.7/bin/supervisorctl -c ~/etc/supervisord.conf"
alias g="grep"
alias f="find"
alias dc="docker compose up"
alias dk="docker container ps -a | cut -d ' ' -f 1 | xargs docker kill"
alias me="cd ~/metaps/cria/cria-admin-console-api/"
alias mw="cd ~/metaps/cria/cria-web-app"
alias mc="cd /Users/shinichiro.sato/metaps/cria/cria-lib-core"
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
PATH=$PATH:/Users/shinichiro.sato/bin/:/usr/local/bin/
export PATH

export AWS_CREDENTIAL_FILE=~/cretential

export PATH="$HOME/.plenv/bin:$PATH"
eval "$(plenv init -)"

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH="$HOME/air/bin:$PATH"
# export PATH="$HOME/node18.18.2/bin:$PATH"
export PATH="$HOME/node2213/bin:$PATH"
# export PATH="$HOME/node20/bin:$PATH"
# export PATH="$HOME/mongodb/bin:$PATH"
export PATH="$HOME/mongodb5/bin:$PATH"
export PATH="$HOME/mongosh/bin:$PATH"

export PATH="$HOME/air/atftools:$PATH"
export PATH="$HOME/awsbin:$PATH"

# export LDFLAGS="-L/Users/shinichiro.sato/lib -L/Users/shinichiro.sato/openssl/lib"
export CPPFLAGS=-I/Users/shinichiro.sato/include

export CPATH=/Users/shinichiro.sato/include
# export LIBRARY_PATH=/Users/shinichiro.sato/lib/

export VULKAN_SDK=/Users/shinichiro.sato/vulkan/
export ASSIMP_HOME=/Users/shinichiro.sato/assimp/

export GOPATH="/$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export PATH="$HOME/mysql/bin:$PATH"
export PATH="$HOME/pear/bin:$PATH"
export PATH="$PATH:/Volumes/Extreme SSD/Android/platform-tools"
export PATH="$PATH:$HOME/nginx/sbin/"

export ANDROID_SDK_ROOT=/Users/shinichiro.sato/Library/Android/sdk
export ANDROID_HOME=/Users/shinichiro.sato/Library/Android/sdk
export PATH="/Users/shinichiro.sato/Library/Android/sdk/platform-tools:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/shinichiro.sato/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/shinichiro.sato/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/shinichiro.sato/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/shinichiro.sato/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export PATH="$HOME/openssl/bin:$PATH"
export PATH="$HOME/cmake/bin:$PATH"
export PATH="$HOME/nkf/bin:$PATH"
export PATH="$HOME/mongodb-database-tools/bin:$PATH"
export PATH="$HOME/ruby/bin:$PATH"
export PATH="$HOME/jdk/Contents/Home/bin:$PATH"
export PATH="$HOME/jdk/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/carthage/bin:$PATH"
export PATH="$HOME/.deno/bin:$PATH"

# export LIBRARY_PATH="$HOME/openssl/lib:$LIBRARY_PATH"

export OPENSSL_CFLAGS=-Wno-error=implicit-function-declaration
export LD_LIBRARY_PATH=$HOME/openssl/lib/
export RUBY_CFLAGS="-w"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/.maestro/bin/

export DEVELOPMENT_MBAAS_URL=http://192.168.0.136:13112/api
. "/Users/shinichiro.sato/.deno/env"
source "/usr/local/.zshpassword"

export MONGODB_PASSWORD
export PATH=$PATH:$HOME/.maestro/bin

export NODE_NO_WARNINGS=1
