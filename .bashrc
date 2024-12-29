# sudo apt-get install fzf 
# Use fzf for reverse history search
bind '"\C-r": "\C-a history | fzf --tac +s --no-sort +m --prompt=\"History> \" --bind \"ctrl-r:reload(history)\" | cut -c 8- | sed \"s/^ *//g\" \C-m"'
