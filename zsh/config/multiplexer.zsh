# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Multiplexer
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

################################################################################
#                                                                              #
# MULTIPLEXER                                                                  #
#                                                                              #
################################################################################

# function should_launch_multiplexer() {
#     if (! hash tmux 2>/dev/null) {
#         return 1
#     }

#     if [[ $NVIM_LISTEN_ADDRESS != '' ]] {
#         return 0
#     } elif (
#         [[ $TMUX == '' ]] \
#         && [[ $SUDO_USER == '' ]] \
#         && [[ $EMACS == '' ]] \
#         && [[ $SSH_CONNECTION == '' ]] \
#         && [[ ! $OSTYPE =~ 'linux-android*' ]] 2>/dev/null
#     ) {
#         return 0
#     }

#     return 1
# }

##
# AUTO-ATTACH TMUX OR START AT LAUNCH WITH DIFFERENT SESSIONS BASED ON PLATFORMS
##
# if (should_launch_multiplexer) {
#     typeset -g session='main'
#     typeset -g launch_options='\; '

#     if [[ $NVIM_LISTEN_ADDRESS != '' ]] {
#         session='nvim'
#         launch_options+='set-option -w status-position bottom \; '
#         launch_options+='set-option -w status-right "" \; '
#         launch_options+='set-option -w prefix C-s \; '
#     }

#     tmux attach-session -t "$session" 2>/dev/null \
#         && exit 0

#     eval tmux -f "$HOME/dotfiles/tmux/tmux.conf" new-session -s "$session" $launch_options \
#         && exit 0

#     unset session
#     unset launch_options
# }

# unset -f should_launch_multiplexer
