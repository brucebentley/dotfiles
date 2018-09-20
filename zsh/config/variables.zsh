################################################################################
#                                                                              #
# VARIABLES                                                                    #
#                                                                              #
################################################################################

##################################################
# WORKSPACES                                     #
##################################################
WORKSPACE="/Users/bbentley"

DESKTOP="${WORKSPACE}/Desktop"
DOCUMENTS="${WORKSPACE}/Documents"
DOWNLOADS="${WORKSPACE}/Downloads"
DROPBOX="${WORKSPACE}/Dropbox"
PICTURES="${WORKSPACE}/Pictures"
VIDEOS="${WORKSPACE}/Videos"
PROJECTS="${WORKSPACE}/Projects"
SITES="${WORKSPACE}/Sites"
DATA="${WORKSPACE}/data"
DEV="${WORKSPACE}/dev"
DOTFILES="${WORKSPACE}/dotfiles"

GITHUB_PROJECTS="${PROJECTS}/GitHub"
MBO_PROJECTS="${PROJECTS}/MBO"
PERSONAL_PROJECTS="${PROJECTS}/Personal"
PROTOTYPES_PROJECTS="${PROJECTS}/Prototypes"
SAMPLES_PROJECTS="${PROJECTS}/Samples"
SUGARCODEIT_PROJECTS="${PROJECTS}/SugarCodeIt"

CONNECT_HOME="${MBO_PROJECTS}/CONNECT"
DEVOPS_HOME="${MBO_PROJECTS}/DEVOPS"
DOCKER_HOME="${MBO_PROJECTS}/DOCKER"
INTRANET_HOME="${MBO_PROJECTS}/INTRANET"
KEYCLOAK_HOME="${MBO_PROJECTS}/KEYCLOAK"
MARKETING_HOME="${MBO_PROJECTS}/MARKETING"
MISC_HOME="${MBO_PROJECTS}/MISC"
PARDOT_HOME="${MBO_PROJECTS}/PARDOT"

DEV_PERSONAL="${DEV}/personal"
DEV_MBO="${DEV}/mbo"
DEV_CERTS="${DEV}/certs"
CERT_LOCALHOST="${DEV_CERTS}/localhost"
CERT_MBOPARTNERS="${DEV_CERTS}/mbopartners.com.test"

ENVIRONMENTS_PERSONAL="${DEV_PERSONAL}/environments"
SCRIPTS_PERSONAL="${DEV_PERSONAL}/scripts"
VENVS_PERSONAL="${DEV_PERSONAL}/venvs"

ENVIRONMENTS_MBO="${DEV_MBO}/environments"
SCRIPTS_MBO="${DEV_MBO}/scripts"
VENVS_MBO="${DEV_MBO}/venvs"

CONNECT_API="${CONNECT_HOME}/connect-api"
CONNECT_API_VENV="${VENVS_MBO}/connect-api"
CONNECT_API_ENVIRONMENT="${ENVIRONMENTS_MBO}/connect-api"
CONNECT_CLIENT="${CONNECT_HOME}/connect-client-ng"
CONNECT_WEBAPP="${CONNECT_HOME}/connect-webapp-ng2"


##################################################
# GIT                                            #
##################################################
GIT_AUTHOR_NAME="Bruce Bentley"
GIT_AUTHOR_EMAIL="bbentley@mbopartners.com"
GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME}"
GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL}"
git config --global user.name "${GIT_AUTHOR_NAME}"
git config --global user.email "${GIT_AUTHOR_EMAIL}"
