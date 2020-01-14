# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Docker Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

alias dkelc='docker exec -it `dklcid` bash'           # Enter Last Container ( Docker v1.3+ )
alias dki='docker images'                             # List Docker Images
alias dklc='docker ps -l'                             # List Last Docker Container
alias dklcid='docker ps -l -q'                        # List Last Docker Container ID
# Get IP Of Last Docker Container
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)'
alias dkps='docker ps'                                # List Running Docker Containers
alias dkpsa='docker ps -a'                            # List All Docker Containers
alias dkrmac='docker rm $(docker ps -a -q)'           # Delete All Docker Containers
alias dkrmlc='docker-remove-most-recent-container'    # Delete Most Recent Docker Container


# - - - - - - - - - - - - - - - - - - - -
# OS-Specific Image Cleanup
# - - - - - - - - - - - - - - - - - - - -
case $OSTYPE in
    darwin*|*bsd*|*BSD*)
        # Delete All Untagged Docker Images
        alias dkrmui='docker images -q -f dangling=true | xargs docker rmi'
        ;;
    *)
        # Delete All Untagged Docker Images
        alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi'
        ;;
esac


# - - - - - - - - - - - - - - - - - - - -
# Cleanup All Docker Assets ( Containers + Images + Volumes )
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-all='docker container stop $(docker container ls -a -q) && \
          docker system prune -a -f --volumes'


# - - - - - - - - - - - - - - - - - - - -
# Cleanup Docker Containers
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-containers='docker container stop $(docker container ls -a -q) && \
          docker container rm $(docker container ls -a -q)'


# - - - - - - - - - - - - - - - - - - - -
# Cleanup Unused Docker Assets
# - - - - - - - - - - - - - - - - - - - -
alias docker-clean-unused='docker system prune --all --force --volumes'
