################################################################################
#                                                                              #
# GIT ALIASES                                                                  #
#                                                                              #
################################################################################
alias gr='git rev-parse 2>/dev/null && cd "./$(git rev-parse --show-cdup)"' # `cd` to git repo root
alias gitclone='source git-clone' # `git clone` && `cd` to a repo directory
alias gitdelete='git branch | egrep -v "(master|staging|develop|\*)" | xargs git branch -D' # delete local branches
alias gist-file='gist --private --copy' # gist-file filename.ext  - create private gist from a file
alias gist-paste='gist --private --copy --paste --filename' # gist-paste filename.ext - create private gist from the clipboard contents
