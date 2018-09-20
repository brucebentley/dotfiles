################################################################################
#                                                                              #
# DEV ALIASES                                                                  #
#                                                                              #
################################################################################

##################################################
# ANSIBLE                                        #
##################################################
# alias startansible="pyenv shell 2.7.13 && source ${DEV}/personal/ansible/bin/activate";


##################################################
# APACHE                                         #
##################################################
alias startapache="sudo brew services start httpd"
alias stopapache="sudo brew services stop httpd"
alias restartapache="sudo brew services restart -k httpd"


##################################################
# DNSMASQ                                        #
##################################################
alias startdnsmasq="sudo brew services start dnsmasq"
alias stopdnsmasq="sudo brew services stop dnsmasq"


##################################################
# MONGO DATABASE                                 #
##################################################
alias startmongo="mongod --dbpath ~/data/db --fork --logpath  /dev/null"
alias stopmongo="mongo admin --eval 'db.shutdownServer()' > /dev/null"


##################################################
# MYSQL DATABASE                                 #
##################################################
alias startmysql="brew services start mariadb"
alias stopmysql="brew services stop mariadb"
alias restartmysql="brew services restart mariadb"


##################################################
# POSTGRESQL DATABASE                                #
##################################################
alias startpostgres="brew services start postgresql"
alias stoppostgres="brew services stop postgresql"
alias restartpostgres="brew services restart postgresql"


##################################################
# CELERY                                         #
##################################################
alias startcelery="cd ${CONNECT_API} && source ${CONNECT_API_VENV}/bin/activate && MBO_ENV=development celery -A connect -l INFO worker";


##################################################
# KEYCLOAK                                       #
##################################################
alias associatetoken="getauthtoken";     # blee, cclark1, agreen, sevans, thansen
alias enterprisetoken="getauthtoken";    # blucas, dcooke, mcavaluzzi, mlucero
alias entadmintoken="getauthtoken";      # tberg

