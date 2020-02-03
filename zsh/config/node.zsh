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
# Automatically Switch Node Versions When A Directory Has A `.nvmrc` File.
autoload -U add-zsh-hook

# Zsh Hook Function.
load-nvmrc() {
    local node_version="$(nvm version)" # Current Node Version.
    local nvmrc_path="$(nvm_find_nvmrc)" # Path To The .nvmrc File.

    # Check If There Exists A .nvmrc File.
    if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    # Check If The Node Version In .nvmrc Is Installed On The Computer.
    if [ "$nvmrc_node_version" = "N/A" ]; then
        # Install The Node Version In .nvmrc On The Computer And Switch To That Node Version.
        nvm install
    # Check If The Current Node Version Matches The Version In .nvmrc.
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
        # Switch Node Versions
        nvm use
    fi
    # If There Isn'T An .nvmrc Make Sure To Set The Current Node Version To The Default Node Version.
    elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
    fi
}

# Add The Above Function When The Present Working Directory (PWD) Changes.
add-zsh-hook chpwd load-nvmrc
load-nvmrc
