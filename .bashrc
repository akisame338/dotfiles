# http://d.hatena.ne.jp/edvakf/20080413/1208042916
export LSCOLORS=gxfxcxdxbxegedabagacad
alias ls="ls -FG"

# プロンプトの設定
PS1="\n\[\033[32m\][\u@\w]\]\n\[\033[0m\]\$ "

# ctrl+fで次の単語に移動
bind '"\C-f": forward-word'
# ctrl+bで前の単語に移動
bind '"\C-b": backward-word'
