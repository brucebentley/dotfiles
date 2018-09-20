################################################################################
#                                                                              #
# NODE ALIASES                                                                 #
#                                                                              #
################################################################################

##################################################
# NPM                                            #
##################################################
alias np="npm";                                     # default npm install

alias npi="npm i";                                  # install packages from package.json
alias npis="npm i --save";                          # install local package dependency
alias npid="npm i --save-dev";                      # install local package devDependency
alias npig="npm i -g";                              # install global package

alias npl="npm ls --depth=0";                       # list local packages
alias nplg="npm ls -g --depth=0";                   # list global packages

alias nps="npm search";                             # search packages

alias npt="npm t";                                  # test packages

alias npu="npm up";                                 # update local packages
alias npug="npm up -g";                             # update global packages

alias npun="npm un";                                # uninstall local packages
alias npung="npm un -g";                            # uninstall global packages


##################################################
# YARN                                           #
##################################################
alias yar="yarn";                                   # default yarn install

alias yarna="yarn add";                             # add local package dependency
alias yarnad="yarn add -D";                         # add local package devDependency
alias yarnap="yarn add -P";                         # add local package peer dependency
alias yarnag="yarn global add";                     # add global package
alias yarni="yarn install";                         # install packages from package.json

alias yarnl="yarn list --depth=0";                  # list local packages
alias yarnlg="yarn global list --depth=0";          # list global packages

alias yarnr="yarn remove";                          # remove local package
alias yarnrg="yarn global remove";                  # remove global package

alias yarns="yarn search";                          # search packages

alias yarnt="yarn test";                            # test packages

alias yarnu="yarn upgrade";                         # upgrade local packages
alias yarnui="yarn upgrade-interactive";            # interfactively upgrade local packages
alias yarnuig="yarn global upgrade-interactive";    # interfactively upgrade global packages
