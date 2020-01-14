# Zsh

## [Zsh ⟶][Zsh Homepage] Shell Playgrounds

A collection of [Zsh ⟶][Zsh Homepage] playgrounds that showcase the various frameworks, plugins & themes.

### [Powerlevel10k ⟶][Powerlevel10k]

Try Powerlevel10k in Docker. You can safely make any changes to the file system while trying out the theme. Once you exit [Zsh ⟶][Zsh Homepage], the image is deleted.

```sh
docker run -e TERM -it --rm archlinux/base bash -uexc '
  pacman -Sy --noconfirm zsh git
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo "source ~/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc
  cd ~/powerlevel10k
  exec zsh'
```

### [Spaceship Prompt ⟶][Spaceship Prompt]

Spaceship is a minimalistic, powerful and extremely customizable [Zsh ⟶][Zsh Homepage] prompt. It combines everything you may need for convenient work, without unnecessary complications, like a real spaceship.

If you have problems with approaches above, follow these instructions:

+ Clone this repo `git clone https://github.com/denysdovhan/spaceship-prompt.git`
+ Symlink `spaceship.zsh` to somewhere in `$fpath` as `prompt_spaceship_setup`.
+ Initialize prompt system and choose `spaceship`.

#### Example:

Run `echo $fpath` to see possible location and link `spaceship.zsh` there, like:
```sh
$ ln -sf "$PWD/spaceship.zsh" "/usr/local/share/zsh/site-functions/prompt_spaceship_setup"
```

For a user-specific installation, simply add a directory to `$fpath` for that user in `.zshrc`:
```sh
fpath=( "$HOME/.zfunctions" $fpath )
```

Then install the theme like this:
```sh
$ ln -sf "$PWD/spaceship.zsh" "$HOME/.zfunctions/prompt_spaceship_setup"
```

For initializing prompt system add this to your `.zshrc`:
```sh
# .zshrc
autoload -U promptinit; promptinit
prompt spaceship
```

#### Docker
```sh
    docker run -e TERM -it --rm archlinux/base bash -uexc '
    pacman -Sy --noconfirm zsh git awk
    git clone --depth=1 https://github.com/denysdovhan/spaceship-prompt.git ~/spaceship
    echo "source ~/spaceship/spaceship.zsh-theme" >> ~/.zshrc
    cd ~/spaceship
    exec zsh'
```

## [apemost/dotfiles ⟶][apemost/dotfiles]

Enhanced [Mathias' ⟶](https://mathiasbynens.be/) dotfiles, sensible hacker defaults for Linux and macOS.

### Trying with Docker

```sh
docker run -it --rm apemost/dotfiles
```

## [`yramagicman/stow-dotfiles` ⟶][yramagicman/stow-dotfiles]

**Welcome!!** Feel free to look around. My configs are free for the copying, but
be aware that I've configured my environment to fit my workflow, so it may
take some tweaking to work for you.

### Usage:

1. Clone the repository with `git clone git@gitlab.com:yramagicman/stow-dotfiles.git`
2. Edit `$dotfiles_dir/zshrc`. While doing this you're going to want to  
   change two things:
   + First, the `$CONFIG_DIR` variable. This path is automatically created when
     you run ZSH for the first time, and it's where your plugins will be
     stored.
   + Second, you'll want to edit the plugins section. The `source_or_clone`
     function takes a file path and a git repo url. The file path should be the
     local path to the `init.zsh` file for the plugin, beginning with the
     $CONFIG_DIR variable. The git repo can be any url that resolves to a git
     repository
3. Once you have those two things edited, run `$dotfiles_dir/init.sh`. This will
   run put everything in your home directory, or `.config` directory as is
   necessary. **A word of warning though: Any conflicting dotfiles in your home
   directory will cause this to fail.** You will have to back up those files and
   remove them in order for this to work.
4. After gnu stow finishes successfully init.sh will automatically change your
   default shell to ZSH, if it's not already ZSH.
5. Log out and back in, or open a new shell. If you have any packages configured
   to install, you will be prompted to install them. **Another word of warning:
   Do not install arbitrary plugins without reading them first, especially if
   you're going to be running commands with root access.** Read the code in the
   packages before saying yes to installing them.
6. Finally open VIM and/or Emacs. Vim will automatically download the latest
   version of vim-plug and install it, along with any packages you've configured
   beforehand. Emacs will also automatically install any packages you've
   configured in init.el.

----

[Zsh Homepage]: http://zsh.org/
[Powerlevel10k]: https://github.com/romkatv/powerlevel10k/
[Spaceship Prompt]: https://github.com/denysdovhan/spaceship-prompt/
[apemost/dotfiles]: https://github.com/apemost/dotfiles/
[yramagicman/stow-dotfiles]: https://gitlab.com/yramagicman/stow-dotfiles/
