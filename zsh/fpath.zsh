#
# path.zsh
#

# Add Each Topic Folder To fpath So That They Can Add Functions And Completion Scripts
for topic_folder ($ZSH/*) if [ -d $topic_folder ]; then  fpath=($topic_folder $fpath); fi;

