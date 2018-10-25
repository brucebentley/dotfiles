################################################################################
#                                                                              #
# WIDGETS                                                                      #
#                                                                              #
################################################################################

##
# REGISTER FUNCTIONS AS WIDGETS
##
foreach widget (
    # BUILT-IN
    'add-surround surround'
    'delete-surround surround'
    'change-surround surround'
    select-quoted
    select-bracketed

    # CUSTOM
    custom-expand-global-alias
    custom-insert-last-typed-word
    custom-tmux-scroll-up
    custom-fzf-launch-from-history
    custom-fzf-execute-widget
) {
    eval zle -N $widget
}
unset widget

##
# EXPAND GLOBAL ALIAS TO ITS FULL FORM
##
function custom-expand-global-alias() {
    if [[ "$LBUFFER" =~ ' [A-Z0-9]+$' ]] {
        zle _expand_alias
    }

    zle self-insert
}

##
# INSERT LAST TYPED WORD FOR QUICK COPY-PASTE
##
function custom-insert-last-typed-word() {
    zle insert-last-word -- 0 -1
}

##
# ACTIVATE TMUX COPY-MODE AND SCROLL UP DEPENDING ON KEY STROKE
##
function custom-tmux-scroll-up() {
    if (! hash tmux &>/dev/null || [[ "$TMUX" == '' ]]) {
        return 1
    }

    tmux copy-mode

    # "$KEYS" == ^Y
    if [[ "$KEYS" ==  ]] {
        tmux send-keys -X scroll-up

    # "$KEYS" == ^Y
    } elif [[ "$KEYS" ==  ]] {
        tmux send-keys -X halfpage-up
    }
}

##
# SELECT COMMAND FROM HISTORY INTO THE COMMAND LINE
##
function custom-fzf-launch-from-history() {
    if (! hash fzf &>/dev/null) {
        return 1
    }

    setopt LOCAL_OPTIONS NO_GLOB_SUBST NO_POSIX_BUILTINS PIPE_FAIL 2>/dev/null

    local selected=(
        $(
            fc -l 1 \
                | fzf \
                    --tac \
                    --nth='2..,..' \
                    --tiebreak='index' \
                    --query="${LBUFFER}" \
                    --exact \
                    --prompt='$ '
        )
    )

    local stat=$?

    if [[ "$selected" != '' ]] {
        local num=$selected[1]

        if [[ "$num" != '' ]] {
            zle vi-fetch-history -n $num
        }
    }

    zle redisplay

    if (typeset -f zle-line-init &>/dev/null) {
        zle zle-line-init
    }

    return $stat
}

##
# EXECUTE ZSH LINE EDITOR WIDGETS
##
function custom-fzf-execute-widget() {
    if (! hash fzf &>/dev/null) {
        return 1
    }

    local selected=$(
        zle -al \
            | command grep --extended-regexp --invert-match '(^orig|^\.|^_)' \
            | fzf \
                --tac \
                --nth='2..,..' \
                --tiebreak='index' \
                --prompt=':'
    )

    local stat=$?

    if [[ "$selected" != '' ]] {
        zle $selected
    }

    return $stat
}
