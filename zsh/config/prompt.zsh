################################################################################
#                                                                              #
# PROMPT                                                                       #
#                                                                              #
################################################################################

# Customise The Powerlevel9k Prompts.
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_medium custom_user dir vcs newline status
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Add The Custom Medium M Icon Prompt Segment.
POWERLEVEL9K_CUSTOM_MEDIUM="echo -n $'\uF859'"
POWERLEVEL9K_CUSTOM_MEDIUM_FOREGROUND="black"
POWERLEVEL9K_CUSTOM_MEDIUM_BACKGROUND="white"

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
