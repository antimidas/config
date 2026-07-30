source /usr/share/cachyos-fish-config/cachyos-config.fish
starship init fish | source
alias cp2='rsync -aPWh'
set -gx EDITOR nano


# Replace ls with exa (or eza)
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -lah --icons --color=always --group-directories-first --git'
alias la='eza -a --icons --color=always --group-directories-first'
alias lt='eza --tree --level=2 --icons --color=always'
alias l='eza -1 --icons --color=always'


# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end
