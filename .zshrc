alias ls='ls -G'

# user keybind
function user_keybind() {
    bindkey "^B"  backward-word
    bindkey "^F"  forward-word
    bindkey "^D"  kill-word
}
user_keybind

# Ctrl-D でログアウトさせない（ミスタイプによる意図しないログアウト防止）
# ただし、10回連続で Ctrl-D するとログアウトする
# http://tm.root-n.com/unix:zsh:zshrc
setopt IGNOREEOF

# 大文字、小文字を区別せず補完する
# https://qiita.com/watertight/items/2454f3e9e43ef647eb6b
autoload -U compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# プロンプトの設定
# http://yoshiko.hatenablog.jp/entry/2014/04/02/zsh%E3%81%AE%E3%83%97%E3%83%AD%E3%83%B3%E3%83%97%E3%83%88%E3%81%ABgit%E3%81%AE%E3%82%B9%E3%83%86%E3%83%BC%E3%82%BF%E3%82%B9%E3%82%92%E3%82%B7%E3%83%B3%E3%83%97%E3%83%AB%E5%8F%AF%E6%84%9B%E3%81%8F
# vcs_infoロード
autoload -Uz vcs_info
# colorsロード
autoload -Uz colors
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6  # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    colors
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]}  # staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]}    # unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]}  # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='%F{green}%n%f %F{yellow}[%~]%f `vcs_echo`
%(?.$.%F{red}$%f) '

# brew setting
export PATH=$(brew --prefix)/bin:$PATH

# pyenv-virtualenv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# add miniconda path
export PATH=~/miniconda3/bin:$PATH

# add nodebrew path
export PATH=$HOME/.nodebrew/current/bin:$PATH

# rbenv setting
export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

# direnv setting
eval "$(direnv hook zsh)"