# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# Node Aliases for Zsh
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# - - - - - - - - - - - - - - - - - - - -
# NPM
# - - - - - - - - - - - - - - - - - - - -

# Interactively Create A package.json File
alias npmnew='npm init'

# Interactively Create A package.json File ( Use Only Defaults And Not Prompt For Any Options )
alias npmnewf='npm init -f'

# Install Package / Dependencies
alias npmI='npm i'

# Install Package / Dependencies Globally
alias npmg='npm i -g'

# Install And Save To Dependencies In package.json
alias npmS='npm i -S'

# Install And Save To Dependencies In package.json With An Exact Version
alias npmSe='npm i -S -E'

# Install And Save To devDependencies In package.json
alias npmD='npm i -D'

# Install And Save To devDependencies In package.json With An Exact Version
alias npmDe='npm i -D -E'

# Install And Save To optionalDependencies In package.json
alias npmIo='npm i -O'

# Install And Save To optionalDependencies In package.json With An Exact Version
alias npmIoe='npm i -O -E'

# Update Package(s)
alias npmU='npm update'

# Update Package(s) Globally
alias npmUg='npm update -g'

# Uninstall Package / Dependencies
alias npmrm='npm rm'

# Uninstall Package / Dependencies Globally
alias npmrmg='npm rm -g'

# Uninstall And Remove From Dependencies In package.json
alias npmrms='npm rm -S'

# Uninstall And Remove From devDependencies In package.json
alias npmrmd='npm rm -D'

# Uninstall And Remove From optionalDependencies In package.json
alias npmrmo='npm rm -O'

# Remove Extraneous Packages
alias npmprn='npm prune'

# Check Which NPM Modules Are Outdated
alias npmO='npm outdated'

# Symlink A Package Folder
alias npmlnk='npm link'

# List Packages
alias npmL='npm list'

# List Packages ( Only First Level )
alias npmL0='npm list --depth=0'

# List Packages Globally
alias npmLg='npm list -g'

# List Packages Globally ( Only First Level )
alias npmLg0='npm list -g --depth=0'

# Publish A Package
alias npmP='npm publish'

# Search In The NPM Database
alias npmse='npm search'

# Create Shrinkwrap
alias npmsh='npm shrinkwrap'

# Run `npm start`
alias npmst='npm start'

# Run `npm test`
alias npmt='npm test'

# Run Custom NPM Script
alias npmR='npm run'

# Run `npm audit`
alias npmA='npm audit'

# Run `npm audit fix`
alias npmAf='npm audit fix'


# - - - - - - - - - - - - - - - - - - - -
# Remove Lock Files
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmrsh!='rm -rf ./npm-shrinkwrap.json ./package-lock.json'
alias npmrpl!='npmrsh!'


# - - - - - - - - - - - - - - - - - - - -
# Clear `node_modules` In Current Directory
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmclr!='rm -rf ./node_modules/'


# - - - - - - - - - - - - - - - - - - - -
# Reinstall Package
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmre!='npmclr! && npmI'


# - - - - - - - - - - - - - - - - - - - -
# Reinstall Package With `remove-create package-lock`
# ! For Prevent Accidental Run
# - - - - - - - - - - - - - - - - - - - -
alias npmres!='npmclr! && npmrsh! && npmI'

