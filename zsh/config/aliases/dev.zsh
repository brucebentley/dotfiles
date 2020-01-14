# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# DEV Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# Apache
# - - - - - - - - - - - - - - - - - - - -

# alias startapache="sudo brew services start httpd"
# alias stopapache="sudo brew services stop httpd"
# alias restartapache="sudo brew services restart -k httpd"
alias startapache="sudo apachectl start"
alias stopapache="sudo apachectl -k stop"
alias restartapache="sudo apachectl -k restart"


# - - - - - - - - - - - - - - - - - - - -
# Brew Graph
# - - - - - - - - - - - - - - - - - - - -

alias brew-deps="brew deps --installed"
#alias brew-graph="brew graph --installed | dot -tpng -ograph.png && open graph.png"
alias brew-graph="brew graph --installed --highlight-leaves | fdp -tpng -ograph.png && open graph.png"


# - - - - - - - - - - - - - - - - - - - -
# Google Chrome
# - - - - - - - - - - - - - - - - - - - -

alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary'

# Kill All The Tabs In Chrome To Free Up Memory.
#alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"


# - - - - - - - - - - - - - - - - - - - -
# Dnsmasq
# - - - - - - - - - - - - - - - - - - - -

alias startdnsmasq="sudo brew services start dnsmasq"
alias stopdnsmasq="sudo brew services stop dnsmasq"
alias restartdnsmasq="sudo brew services restart dnsmasq"


# - - - - - - - - - - - - - - - - - - - -
# Mongo Database
# - - - - - - - - - - - - - - - - - - - -

alias startmongo='mongod --dbpath ~/data/db --fork --logpath /dev/null'
alias stopmongo='mongo admin --eval 'db.shutdownserver()' > /dev/null'


# - - - - - - - - - - - - - - - - - - - -
# MySQL Database
# - - - - - - - - - - - - - - - - - - - -

# MariaDB
#alias startmysql='brew services start mariadb'
#alias stopmysql='brew services stop mariadb'

# MySQL
alias startmysql='brew services start mysql'
alias stopmysql='brew services stop mysql'
alias restartmysql='brew services restart mysql'

# MySQL ( v5.7 )
alias startmysql57='brew services start mysql@5.7'
alias stopmysql57='brew services stop mysql@5.7'
alias restartmysql57='brew services restart mysql@5.7'


# - - - - - - - - - - - - - - - - - - - -
# PostgreSQL Database
# - - - - - - - - - - - - - - - - - - - -

alias startpostgres='brew services start postgresql'
alias stoppostgres='brew services stop postgresql'


# - - - - - - - - - - - - - - - - - - - -
# Sketch
# - - - - - - - - - - - - - - - - - - - -

alias sketchtool='$(mdfind kMDItemCFBundleIdentifier == "com.bohemiancoding.sketch3" | head -n 1)/Contents/Resources/sketchtool/bin/sketchtool'

