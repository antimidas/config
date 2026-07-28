source /usr/share/cachyos-fish-config/cachyos-config.fish
starship init fish | source
alias cp2='rsync -aPWh'
set -gx EDITOR nano

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
