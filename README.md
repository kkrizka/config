# To setup on a new computer
```
git clone --bare git@github.com:kkrizka/config.git $HOME/.cfg
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config checkout
```
