# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Node
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# NVM
# - - - - - - - - - - - - - - - - - - - -
export NVM_DIR="$HOME/.nvm";
# shellcheck disable=1090
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"                      # This Loads nvm
# shellcheck disable=1090
[ -s "${NVM_DIR}/bash_completion" ] && \. "${NVM_DIR}/bash_completion"    # This Loads nvm bash_completion


# - - - - - - - - - - - - - - - - - - - -
# NVM Auto-Load
# - - - - - - - - - - - - - - - - - - - -
# # Automatically switch node versions when a directory has a `.nvmrc` file
# autoload -U add-zsh-hook
# # Zsh hook function
# load-nvmrc() {
#     local node_version="$(nvm version)"   # Current node version
#     local nvmrc_path="$(nvm_find_nvmrc)"  # Path to the .nvmrc file

#     # Check if there exists a .nvmrc file
#     if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

#     # Check if the node version in .nvmrc is installed on the computer
#     if [ "$nvmrc_node_version" = "N/A" ]; then
#         # Install the node version in .nvmrc on the computer and switch to that node version
#         nvm install
#     # Check if the current node version matches the version in .nvmrc
#     elif [ "$nvmrc_node_version" != "$node_version" ]; then
#         # Switch node versions
#         nvm use
#     fi
#     # If there isn't an .nvmrc make sure to set the current node version to the default node version
#     elif [ "$node_version" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#     fi
# }
# # Add the above function when the present working directory ( pwd ) changes
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc
