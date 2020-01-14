# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Hooks
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


##
# REGISTER HOOK FUNCTIONS
##
# foreach hook (
#     'preexec _preexec_ssh'
#     'preexec _preexec_fasd'
# ) {
#     eval add-zsh-hook $hook
# }
# unset hook

##
# TRANSFORM THE CURSOR TO BOX FORM ON SSH COMMAND
##
# function _preexec_ssh() {
#     if [[ "$2" =~ '^ssh[[:space:]]' ]] {
#         printf '\e[0 q'
#     }
# }

##
# REGISTER FASD TO TRACK MOST USED FILES AND DIRECTORIES
##
# function _preexec_fasd() {
#     if (hash fasd &>/dev/null) {
#         fasd --proc $(fasd --sanitize "$1") &>/dev/null
#     }
# }

##
# COMPILE LESSKEY FILE IF COMPILE IS NEEDED
##
# if ([[ ! -f $LESSKEY ]] || [[ $LESSKEYRC -nt $LESSKEY ]]) {
#     lesskey -o $LESSKEY $LESSKEYRC
# }

##
# CREATE SYMBOLIC LINKS FOR NEOVIM AND VIM CONFIGS
##
# if ! [[ -L ~/.vim/vimrc ]] {
#     ln -s ~/dotfiles/vim/init.vim ~/.vim/vimrc
# }
# if ! [[ -L ~/.config/nvim ]] {
#     ln -s ~/dotfiles/vim ~/.config/nvim
# }

##
# CREATE SYMBOLIC LINK FOR PROMPT THEME IF IT'S NOT ALREADY LINKED
##
# if ! [[ -L $ZDOTDIR/autoload/prompt_pure_setup ]] {
#     ln -s $ZDOTDIR/plugins/pure/pure.zsh $ZDOTDIR/autoload/prompt_pure_setup
# }
# if ! [[ -L $ZDOTDIR/autoload/async ]] {
#     ln -s $ZDOTDIR/plugins/pure/async.zsh $ZDOTDIR/autoload/async
# }

##
# RECOMPILE PROMPT FILES IF IT'S NEEDED
##
# zrecompile -p \
#     -M $ZDOTDIR/autoload/async -- \
#     -M $ZDOTDIR/autoload/prompt_pure_setup
