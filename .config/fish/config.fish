# Starship
starship init fish | source

# Oh-my-posh
# oh-my-posh init fish | source
# oh-my-posh init fish --config $HOME/.config/oh-my-posh/themes/kanagawa.omp.json | source

# Zoxide cd alternative
zoxide init fish | source

# mise
mise activate fish | source

## IMPORTS

# Environments
if test -f $HOME/.config/fish/exports/environments.fish
    source $HOME/.config/fish/exports/environments.fish
end

# Aliases
if [ -f $HOME/.config/fish/aliases/main.fish ]
    source $HOME/.config/fish/aliases/main.fish
end

# Load private config
if test -e $HOME/.config/fish/functions/private.fish
    source $HOME/.config/fish/functions/private.fish
end

# PATH configurations
if test -f $HOME/.config/fish/exports/path.fish
    source $HOME/.config/fish/exports/path.fish
end

# Files
if test -f $HOME/.config/fish/exports/files.fish
    source $HOME/.config/fish/exports/files.fish
end

# Theme
if test -f $HOME/.config/fish/themes/Kanagawa.fish
    source $HOME/.config/fish/themes/Kanagawa.fish
end

# Automatically spawn "Warpify" subshells
if status is-interactive
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish"}}\x9c'
end

set -Ux FZF_TMUX_OPTS "-p 55%,60%"
# apt install: pacman -S.
# apt remove: pacman -Rs.
# apt autoremove: pacman -Qdtq | pacman -Rs -.
# apt autoclean: pacman -Scc.
# apt search: pacman -Ss.
