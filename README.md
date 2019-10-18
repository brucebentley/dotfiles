# Bruce Bentley’s dotfiles

## Status

![Dependency Status](https://img.shields.io/librariesio/github/brucebentley/dotfiles?logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAAAAAGzbPfSAAAAAXNSR0IArs4c6QAAAhJJREFUOMuNkrtrFGEUxX/z7SQrCZqHiBpfC5pCWdnIBhIQ8Y2NLxD9AwL2FoKFlbaC1oKVlY1oVFAbEbsg2tiIQgTt1A2JYXGTzOZnMbOPmERzimHmzLnfufd8NxIgEEXUkTOKYIKgkQB4HhBC9nkQBBkVY4Af3VjHSEGSgBEAZAcAiN1pWWoBhow/SgwYGX0E645kf69MNWsrDY7+4xlnIS7r887+l1qOdykK6aOsQNJG3VPtJElNAd0WQTxnLhW819FGeWIA7Zmi1T8x9M5QoQ0BZiBHgJARbRM3sAIVeNKxeRxKuSI83dJxG3AjHMj6HYYeDVRggTkAFmCmYZNhRyMdKFojr3oX0jukaO2E1p31e4tS+6qWbmmLmoaqJfZlVEElpYg0wPUvbaYCftJyS4XGDM7n/57xcX7Z2HeWJ9FEnq6M2t2YLcchOMIaU10B6n4ATqsOAnBB9RwAe9MczPa1qM6nhcOqQ+l7XQ3Z6CkWW1k0WDM7mifVALhcU/09BkCS2S0R7XxrExPbVxLNXUvUyaGqevKVmlxdLlIXbwaoqiW4OJtyTdG6+6of9gBNEWx41CY6VUlrRlgqSnsKQM+4L/qZT1YNPADTZ+Fhb/7XqqIYYPLSu39eXQwcfvOf+w1rWYIAdKT71AesB2BTF1AAoCuX2d0IXytuHYuAZxPffjJwDODB68/13oHhNS/dHwxZd3aootZjAAAAAElFTkSuQmCC&logoColor=%23ffffff&style=for-the-badge)
![Last Commit ( Branch )](https://img.shields.io/github/last-commit/brucebentley/dotfiles/macOS/Mojave?logo=GitHub&logoColor=%23ffffff&style=for-the-badge)
![License](https://img.shields.io/github/license/brucebentley/dotfiles?color=%23007ec5&logo=Open%20Source%20Initiative&logoColor=%23ffffff&style=for-the-badge)

<br/>

![Language Count](https://img.shields.io/github/languages/count/brucebentley/dotfiles?logo=GitHub&logoColor=%23ffffff&style=for-the-badge)
![Repo Size ( MB )](https://img.shields.io/github/repo-size/brucebentley/dotfiles?logo=git&logoColor=%23ffffff&style=for-the-badge)

<p align="center">
    <img src="https://i.imgur.com/wmQPryP.png" alt="Bruce Bentley's dotfiles">
</p>

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git And The Bootstrap Script

You can clone the repository wherever you want (I like to keep it in `~/dotfiles`). The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/brucebentley/dotfiles.git ~/dotfiles && cd ~/dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Git-free Install

To install these dotfiles without Git:

```bash
cd; curl -#L https://github.com/brucebentley/dotfiles/tarball/master | tar -xzv --strip-components 1 --exclude={README.md,bootstrap.sh,.macos,LICENSE.txt}
```

To update later on, just run that command again.

### Specify The `$PATH`

If `~/dotfiles/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/brucebentley/dotfiles/blob/master/.aliases#L23)) takes place.

Here’s an example `~/dotfiles/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add Custom Commands Without Creating A New Fork

If `~/dotfiles/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/dotfiles/.extra` looks something like this:

```bash

##################################################
# WORKSPACES                                     #
##################################################
WORKSPACE="/Users/bbentley"

DESKTOP="$WORKSPACE/Desktop"
DOCUMENTS="$WORKSPACE/Documents"
DOWNLOADS="$WORKSPACE/Downloads"
DROPBOX="$WORKSPACE/Dropbox"
PICTURES="$WORKSPACE/Pictures"
VIDEOS="$WORKSPACE/Videos"
PROJECTS="$WORKSPACE/Projects"
SITES="$WORKSPACE/Sites"
DATA="$WORKSPACE/data"
DEV="$WORKSPACE/dev"
DOTFILES="$WORKSPACE/dotfiles"

GITHUB_PROJECTS="$PROJECTS/GitHub"
PERSONAL_PROJECTS="$PROJECTS/Personal"
PROTOTYPES_PROJECTS="$PROJECTS/Prototypes"
SAMPLES_PROJECTS="$PROJECTS/Samples"

DEV_PERSONAL="$DEV/personal"
DEV_CERTS="$DEV/certs"
CERT_LOCALHOST="$DEV_CERTS/localhost"
ENVIRONMENTS_PERSONAL="$DEV_PERSONAL/environments"
SCRIPTS_PERSONAL="$DEV_PERSONAL/scripts"
VENVS_PERSONAL="$DEV_PERSONAL/venvs"


##################################################
# GIT                                            #
##################################################
GIT_AUTHOR_NAME="Bruce Bentley"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="bbentley@mbopartners.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"

```

You could also use `~/dotfiles/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/brucebentley/dotfiles/fork) instead, though.

### Sensible macOS Defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
./dotfiles/.macos
```

### Install Homebrew Formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```bash
./dotfiles/brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.

## Feedback

Suggestions, Improvements, Questions, Comments or Concerns [are always welcomed](https://github.com/brucebentley/dotfiles/issues)!

## Author

| [![twitter/bruce_bentley](https://secure.gravatar.com/avatar/484adc8a658a351ba4f3b0c92d2353d4?s=70)](http://twitter.com/bruce_bentley "Follow @bruce_bentley on Twitter") |
|---|
| [Bruce Bentley](https://brucebentley.io/) |

