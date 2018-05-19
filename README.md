# dotfiles

My collection of dotfiles.

### A note on storing dotfiles

A practical git-only technique for managing dotfiles using git I learned about
[here](https://news.ycombinator.com/item?id=11071754) and
[here](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).

To get things set up:

```
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config status.showUntrackedFiles no
# add the alias to your bashrc
echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/--work-tree=$HOME'" >> $HOME/.bashrc
```

Now manage your dotfiles using basic git commands:

```
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles push
```

