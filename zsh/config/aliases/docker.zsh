################################################################################
#                                                                              #
# DOCKER ALIASES                                                               #
#                                                                              #
################################################################################
alias dklc='docker ps -l' # list last docker container
alias dklcid='docker ps -l -q' # list last docker container id
alias dklcip='docker inspect -f "{{.NetworkSettings.IPAddress}}" $(docker ps -l -q)' # get ip of last docker container
alias dkps='docker ps' # list running docker containers
alias dkpsa='docker ps -a' # list all docker containers
alias dki='docker images' # list docker images
alias dkrmac='docker rm $(docker ps -a -q)' # delete all docker containers
alias dkrmlc='docker-remove-most-recent-container' # delete most recent (i.e., last) docker container
alias dkelc='docker exec -it `dklcid` bash' # enter last container (works with docker 1.3 and above)

# OS-Specific Image Cleanup
case $OSTYPE in
  darwin*|*bsd*|*BSD*)
    alias dkrmui='docker images -q -f dangling=true | xargs docker rmi' # delete all untagged docker images
    ;;
  *)
    alias dkrmui='docker images -q -f dangling=true | xargs -r docker rmi' # delete all untagged docker images
    ;;
esac

# Cleanup
alias docker-clean-all='docker container stop $(docker container ls -a -q) && docker system prune -a -f --volumes'
alias docker-clean-containers='docker container stop $(docker container ls -a -q) && docker container rm $(docker container ls -a -q)'
alias docker-clean-unused='docker system prune --all --force --volumes'
