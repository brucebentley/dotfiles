################################################################################
#                                                                              #
# PROMPT                                                                       #
#                                                                              #
################################################################################

# Customise The Powerlevel9k Prompts.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    custom_css custom_docker custom_github
    custom_javascript custom_medium custom_nodejs
    custom_python custom_ruby custom_sass
    custom_typescript custom_user dir
    vcs newline status
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Create a custom CSS prompt section
POWERLEVEL9K_CUSTOM_CSS="echo -n $'\uE749' CSS"
POWERLEVEL9K_CUSTOM_CSS_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_CSS_BACKGROUND="blue"

# Create a custom Docker prompt section
POWERLEVEL9K_CUSTOM_DOCKER="echo -n $'\uE7B0' Docker"
POWERLEVEL9K_CUSTOM_DOCKER_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_DOCKER_BACKGROUND="blue"

# Create a custom GitHub prompt section
POWERLEVEL9K_CUSTOM_GITHUB="echo -n $'\uE708' GitHub"
POWERLEVEL9K_CUSTOM_GITHUB_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_GITHUB_BACKGROUND="black"

# Create a custom JavaScript prompt section
POWERLEVEL9K_CUSTOM_JAVASCRIPT="echo -n $'\uE781' JavaScript"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_JAVASCRIPT_BACKGROUND="yellow"

# Add The Custom Medium M Icon Prompt Segment.
POWERLEVEL9K_CUSTOM_MEDIUM="echo -n $'\uF859'"
POWERLEVEL9K_CUSTOM_MEDIUM_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_MEDIUM_BACKGROUND="white"

# Create a custom NodeJS prompt section
POWERLEVEL9K_CUSTOM_NODEJS="echo -n $'\uE718' NodeJS"
POWERLEVEL9K_CUSTOM_NODEJS_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_NODEJS_BACKGROUND="green"

# Create a custom Python prompt section
POWERLEVEL9K_CUSTOM_PYTHON="echo -n $'\uF81F' Python"
POWERLEVEL9K_CUSTOM_PYTHON_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_PYTHON_BACKGROUND="blue"

# Create a custom Ruby prompt section
POWERLEVEL9K_CUSTOM_RUBY="echo -n $'\uE21E' Ruby"
POWERLEVEL9K_CUSTOM_RUBY_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_RUBY_BACKGROUND="red"

# Create a custom Sass prompt section
POWERLEVEL9K_CUSTOM_SASS="echo -n $'\uE74B' Sass"
POWERLEVEL9K_CUSTOM_SASS_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_SASS_BACKGROUND="pink"

# Create a custom TypeScript prompt section
POWERLEVEL9K_CUSTOM_TYPESCRIPT="echo -n $'\uFBE4' TypeScript"
POWERLEVEL9K_CUSTOM_TYPESCRIPT_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_TYPESCRIPT_BACKGROUND="blue"

# Add Custom Prompt Segment.
POWERLEVEL9K_CUSTOM_USER="echo -n $'\uF415' Bruce Bentley"
POWERLEVEL9K_CUSTOM_USER_FOREGROUND="white"
POWERLEVEL9K_CUSTOM_USER_BACKGROUND="cyan"

# Set A Color For iTerm2 Tab Title Background Using RGB Values.
function title_background_color {
  echo -ne "\033]6;1;bg;red;brightness;$ITERM2_TITLE_BACKGROUND_RED\a"
  echo -ne "\033]6;1;bg;green;brightness;$ITERM2_TITLE_BACKGROUND_GREEN\a"
  echo -ne "\033]6;1;bg;blue;brightness;$ITERM2_TITLE_BACKGROUND_BLUE\a"
}
ITERM2_TITLE_BACKGROUND_RED="18"
ITERM2_TITLE_BACKGROUND_GREEN="26"
ITERM2_TITLE_BACKGROUND_BLUE="33"
title_background_color

# Set iTerm2 Tab Title Text.
function title_text {
    echo -ne "\033]0;"$*"\007"
}
title_text Bruce Bentley

# Load Nerd Fonts With Powerlevel9k Theme For Zsh.
POWERLEVEL9K_MODE='nerdfont-complete'
source ${DOTFILES}/zsh/powerlevel9k/powerlevel9k.zsh-theme
