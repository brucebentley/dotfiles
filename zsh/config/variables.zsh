# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Zsh Variables
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# User Directories
# - - - - - - - - - - - - - - - - - - - -

#DESKTOP=~/Desktop
#DOCUMENTS=~/Documents
#DOWNLOADS=~/Downloads
#DROPBOX=~/Dropbox
#PICTURES=~/Pictures
#VIDEOS=~/Videos
#PROJECTS=~/Projects
#SITES=~/Sites
#BIN=~/bin
#DATA=~/data
export DEV="${WORKSPACE}/dev"
export DOTFILES="${WORKSPACE}/dotfiles"
#NOTES=~/Desktop/—[ DEV NOTES ]—
#SSH=~/.ssh


# - - - - - - - - - - - - - - - - - - - -
# DEV Utilities
# - - - - - - - - - - - - - - - - - - - -

export DEV_PERSONAL="${WORKSPACE}/dev/personal"
export DEV_GOCANVAS="${WORKSPACE}/dev/gocanvas"
#DEV_MBO="${DEV}/mbo"

# Personal
export CERTS_PERSONAL="${DEV_PERSONAL}/certs"
export CERT_LOCALHOST="${DEV_PERSONAL}/certs/localhost"
export ENVIRONMENTS_PERSONAL="${DEV_PERSONAL}/environments"
export SCRIPTS_PERSONAL="${DEV_PERSONAL}/scripts"
export VENVS_PERSONAL="${DEV_PERSONAL}/venvs"

# GoCanvas
export CERTS_GOCANVAS="${DEV_GOCANVAS}/gocanvas/certs"
export CERT_GOCANVAS="${DEV_GOCANVAS}/gocanvas/certs/gocanvas.com.test"
#ENVIRONMENTS_GOCANVAS=~/dev/gocanvas/environments
#SCRIPTS_GOCANVAS=~/dev/gocanvas/scripts
#VENVS_GOCANVAS=~/dev/gocanvas/venvs


# MBO
#CERTS_MBO="${DEV_MBO}/certs"
#CERT_MBOPARTNERS="${DEV_CERTS}/mbopartners.com.test"
#ENVIRONMENTS_MBO="${DEV_MBO}/environments"
#SCRIPTS_MBO="${DEV_MBO}/scripts"
#VENVS_MBO="${DEV_MBO}/venvs"


# - - - - - - - - - - - - - - - - - - - -
# Projects
# - - - - - - - - - - - - - - - - - - - -
#GITHUB_PROJECTS=~/Projects/GitHub
#GITLAB_PROJECTS=~/Projects/GitLab
#GOCANVAS_PROJECTS=~/Projects/GoCanvas
#MBO_PROJECTS=~/Projects/MBO
#PERSONAL_PROJECTS=~/Projects/Personal
#PROTOTYPES_PROJECTS=~/Projects/Prototypes
#SAMPLES_PROJECTS=~/Projects/Samples

# Personal
#PERSONAL_DOTFILES=~/Projects/Personal/dotfiles
#PERSONAL_WEBSITE=~/Projects/Personal/brucebentley.io
#PERSONAL_UTILITIES=~/Projects/Personal/utilities

# GoCanvas
#GOCANVAS_DISCOVERY_HOME=~/Projects/GoCanvas/discovery
#GOCANVAS_RND_HOME=~/Projects/GoCanvas/rnd
#GOCANVAS_WEB_HOME=~/Projects/GoCanvas/web
#GOCANVAS_PILLARS_HOME=~/Projects/GoCanvas/pillars
#WEB_APPBUILDER=~/Projects/GoCanvas/web/appbuilder
#WEB_MAIN=~/Projects/GoCanvas/web/main

# MBO
#MBO_CLIENTS_HOME="${MBO_PROJECTS}/CLIENTS"
#MBO_CONNECT_HOME="${MBO_PROJECTS}/CONNECT"
#MBO_DEVOPS_HOME="${MBO_PROJECTS}/DEVOPS"
#MBO_DOCKER_HOME="${MBO_PROJECTS}/DOCKER"
#MBO_INTRANET_HOME="${MBO_PROJECTS}/INTRANET"
#MBO_KEYCLOAK_HOME="${MBO_PROJECTS}/KEYCLOAK"
#MBO_MARKETING_HOME="${MBO_PROJECTS}/MARKETING"
#MBO_MISC_HOME="${MBO_PROJECTS}/MISC"
#MBO_PARDOT_HOME="${MBO_PROJECTS}/PARDOT"

#CONNECT_API="${MBO_CONNECT_HOME}/connect-api"
#CONNECT_API_VENV="${VENVS_MBO}/connect-api"
#CONNECT_API_ENVIRONMENT="${ENVIRONMENTS_MBO}/connect-api"
#CONNECT_CLIENT="${MBO_CLIENTS_HOME}/connect-client-ng"
#CONNECT_WEBAPP="${MBO_CONNECT_HOME}/connect-webapp-ng2"


# - - - - - - - - - - - - - - - - - - - -
# Git
# - - - - - - - - - - - - - - - - - - - -

GIT_AUTHOR_NAME="Bruce Bentley"
GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
git config --global user.name "${GIT_AUTHOR_NAME}"
GIT_AUTHOR_EMAIL="bruce.bentley@gocanvas.com"
GIT_AUTHOR_EMAIL="brucebentley@me.com"
GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL}"
git config --global user.email "${GIT_AUTHOR_EMAIL}"
