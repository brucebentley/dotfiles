################################################################################
#                                                                              #
# ALIASES                                                                      #
#                                                                              #
################################################################################

foreach piece (
    core.zsh
    dev.zsh
    docker.zsh
    git.zsh
    node.zsh
) {
    source $ZDOTDIR/config/aliases/$piece
}
