# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Exports
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Initialize $PATH with system binaries
# - - - - - - - - - - - - - - - - - - - -
# path=(
#   "$HOME/.local/bin"
#   $path
#   /usr/bin
#   /bin
#   /usr/sbin
#   /sbin
# )

# - - - - - - - - - - - - - - - - - - - -
# Platform Specific Variables
# - - - - - - - - - - - - - - - - - - - -
case $OSTYPE {
  darwin*)
  # Coreutils
  export GNU_COREUTILS_HOME="$(brew --prefix coreutils)/libexec/gnubin"
  export GNU_COREUTILS_MAN_HOME="$(brew --prefix coreutils)/libexec/gnuman"
  # Findutils
  export GNU_FINDUTILS_HOME="$(brew --prefix findutils)/libexec/gnubin"
  export GNU_FINDUTILS_MAN_HOME="$(brew --prefix findutils)/libexec/gnuman"
  # Grep
  export GNU_GREP_HOME="$(brew --prefix grep)/libexec/gnubin"
  export GNU_GREP_MAN_HOME="$(brew --prefix grep)/libexec/gnuman"
  # GNU-Sed
  export GNU_SED_HOME="$(brew --prefix gnu-sed)/libexec/gnubin"
  export GNU_SED_MAN_HOME="$(brew --prefix gnu-sed)/libexec/gnuman"
  # OpenSSL
  export OPENSSL_HOME="$(brew --prefix openssl)/bin"
  export OPENSSL_MAN_HOME="$(brew --prefix openssl)/share/man"

  path=(
    $GNU_COREUTILS_HOME
    $GNU_FINDUTILS_HOME
    $GNU_GREP_HOME
    $GNU_SED_HOME
    $OPENSSL_HOME
    $path
  )

  manpath=(
    $GNU_COREUTILS_MAN_HOME
    $GNU_FINDUTILS_MAN_HOME
    $GNU_GREP_MAN_HOME
    $GNU_SED_MAN_HOME
    $OPENSSL_MAN_HOME
    $manpath
  )
  ;;
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# CORE CONFIGURATION SETTINGS
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# GNUpg
# - - - - - - - - - - - - - - - - - - - -
# Avoid issues with `gpg` as installed via homebrew
# See: https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

# - - - - - - - - - - - - - - - - - - - -
# MAN
# - - - - - - - - - - - - - - - - - - - -
export MANWIDTH='100' # Fixed line width for man pages
    if ([[ "$OSTYPE" =~ 'linux-android*' ]] 2>/dev/null) { MANWIDTH='50' }
export MANPAGER="nvim +'set filetype=man' -"
    if ([[ "$OSTYPE" =~ 'linux-android*' ]] 2>/dev/null) { unset MANPAGER }


# - - - - - - - - - - - - - - - - - - - -
# macOS
# - - - - - - - - - - - - - - - - - - - -
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Pkg-Config
  export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:$(brew --prefix krb5)/lib/pkgconfig:$(brew --prefix libedit)/lib/pkgconfig:$(brew --prefix libxml2)/lib/pkgconfig:$(brew --prefix openssl)/lib/pkgconfig:$(brew --prefix imagemagick@6)/lib/pkgconfig"

  # For compilers to find & use Homebrew-installed formulae
  export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix imagemagick@6)/lib"
  export CPPFLAGS="-I$(brew --prefix openssl)/include -I$(brew --prefix imagemagick@6)/include"

fi


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Utilities
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Bison
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix bison)/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Composer
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# ImageMagick
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix imagemagick@6)/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# MySQL
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix mysql@5.7)/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Prince
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix)/lib/prince/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$SKETCH_APP_CONTENTS/Resources/sketchtool/bin:$PATH"
