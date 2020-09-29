# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Path
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Initialize $PATH with system binaries
# - - - - - - - - - - - - - - - - - - - -

# Coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
# Findutils
export PATH="$(brew --prefix findutils)/libexec/gnubin:$PATH"
# GNU-Sed
export PATH="$(brew --prefix gnu-sed)/libexec/gnubin:$PATH"
# Grep
export PATH="$(brew --prefix grep)/libexec/gnubin:$PATH"


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# DEV Essentials
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# - - - - - - - - - - - - - - - - - - - -
# Bison
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix bison)/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# ImageMagick
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix)/opt/imagemagick@6/bin:$PATH"

# Set The Imagemagick Directories To Use From Homebrew.
export LDFLAGS="-L$(brew --prefix)/opt/imagemagick@6/lib"
export CPPFLAGS="-I$(brew --prefix)/opt/imagemagick@6/include"
# For Pkg-Config To Find Imagemagick You May Need To Set.
#export PKG_CONFIG_PATH="$(brew --prefix imagemagick@6)/lib/pkgconfig"

# - - - - - - - - - - - - - - - - - - - -
# MySQL
# - - - - - - - - - - - - - - - - - - - -
export PATH="$(brew --prefix)/opt/mysql@5.7/bin:$PATH"


# - - - - - - - - - - - - - - - - - - - -
# Prince
# - - - - - - - - - - - - - - - - - - - -
#export PATH="$(brew --prefix)/lib/prince/bin:$PATH"

# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -
#export PATH="Sketch.app/Contents/Resources/sketchtool/bin:$PATH"

