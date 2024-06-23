# Unix update/grade packages
function arup
    echo -e '\a'
    echo -e "\e[32mUpgrade Arch linux System...\e[0m"

    # brew update
    # brew upgrade
    # rustup update
    # rustup self update
    # cargo update
    fisher update
    # omf update

    paru -Syu # --sync --answer --upgrade
    paru -Scc # --refresh --clean
    paru -Qdtq | paru -Rs - # --query --unrequired --deps --quiet | sudo pacman --remove --noconfirm --recursive -
    sudo pacman -Syu

    echo -e "Finished."
    echo -e "\e[32mSystem completely updated successfully! \e[0m"
    # return

end

# Create a new directory and enter it
function mkd
    mkdir -pv $argv[1]; and cd $argv[1]
end

# Git
function gini
    set message $argv

    if ! test $argv
        set message "chore: commit save point"
    end

    if ! test -d .git
        set message "initial commit"
        git init
    end

    git add .
    git commit -m $message
    git checkout -b dev
end

# Git commit browser
function fshow
    set -l commit_hash "echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
    set -l view_commit "$commit_hash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"
    git log --color=always \
        --format="%Cred%h%Creset -%C(#E6C384)%d%Creset %s %Cgreen(%ar) %C(bold #957FB8)<%an>%Creset" $argv | fzf --no-sort --tiebreak=index --no-multi --reverse --ansi \
        --header="enter to view, alt-y to copy hash" --preview="$view_commit" \
        --bind="enter:execute:$view_commit | less -R" \
        --bind="alt-y:execute:$commit_hash | xclip -selection clipboard"
end

# Print README file
function readme
    # set -l mdvp '/home/linuxbrew/.linuxbrew/lib/python3.10/site-packages/mdv/markdownviewer.py'
    for readme in {readme,README}.{md,MD,markdown,mkd,txt,TXT} or {readme,README}
        if [ -x $(command -v glow) ]; and [ -f $readme ]
            glow $readme
        else if [ -f $readme ]
            cat $readme
        end
    end
end

# Yazi File Manager
function yy
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# LF File Manager
function lfcd
    set tmp (mktemp)
    # `command` is needed in case `lfcd` is aliased to `lf`
    command lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

# Weather
function sweather
    curl 'wttr.in/?format=3'
end

function weather
    curl -s 'https://wttr.in/${}?m2F&format=v2'
end

function fweather
    curl -s 'https://wttr.in' | sed -n '1,27p'
end

function pomodoro
    set counter 1
    while test $counter -le 4
        # Armazena o primeiro argumento do usuário
        set val $argv
        set duration 3s

        # Verifica se o valor é "work" ou não
        if test "$val" = work
            set duration 45m
        end

        # Chama o comando "timer" com o tempo desejado
        clear
        echo $counter"/4 " $argv
        timer $duration -n "$argv  "
        echo -e '\a'
        paplay $HOME/Music/denkatcha.mp3
        echo $val "session done. "

        set counter (math $counter + 1)
    end
end

# PHP
function server
    php -S localhost:$argv[1] $argv[2] $argv[3]
end

# Change directories and view the contents at the same time
function g
    set -l DIR $argv

    # if no DIR given, go home
    if test (count $argv) -lt 1
        set DIR $HOME
    end

    # builtin cd $DIR; and \
    z $DIR
    clear
    # use your preferred ls command
end

# Extract  all zip types
function ex
    # Check if a file was provided
    if test -f $argv[1]
        # Remove the file extension to create a directory name
        set base (basename $argv[1] | string replace -r '\.[^.]*$' '')
        # Make the directory based on the file name (without extension)
        mkdir -p $base
        # Determine the type of archive and extract it into the created directory
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1] -C $base
            case '*.tar.gz'
                tar xzf $argv[1] -C $base
            case '*.tar.xz'
                tar xJf $argv[1] -C $base
            case '*.bz2'
                bunzip2 -c $argv[1] >$base/(basename $argv[1] .bz2)
            case '*.rar'
                unrar x $argv[1] $base/
            case '*.gz'
                gunzip -c $argv[1] >$base/(basename $argv[1] .gz)
            case '*.tar'
                tar xf $argv[1] -C $base
            case '*.tbz2'
                tar xjf $argv[1] -C $base
            case '*.tgz'
                tar xzf $argv[1] -C $base
            case '*.zip'
                unzip $argv[1] -d $base
            case '*.Z'
                uncompress -c $argv[1] >$base/(basename $argv[1] .Z)
            case '*.7z'
                7z x $argv[1] -o$base
            case '*'
                echo "'$argv[1]' cannot be extracted via ex()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end


# Anaconda fish integrate
function condafish
    $HOME/anaconda3/condabin/condafish init fish
end

# Vim / NeoVim / Neovide Configs

function astrovim
    env NVIM_APPNAME=astrovim neovide
end

function bettervim
    env NVIM_APPNAME=bettervim neovide
end

function kickstart
    env NVIM_APPNAME=kickcstart neovide
end

function lazyvim
    env NVIM_APPNAME=lazyvim neovide
end

function maxvim
    env NVIM_APPNAME=maxvim neovide
end

function normalvim
    env NVIM_APPNAME=normalvim neovide
end

function nvchad
    env NVIM_APPNAME=nvchad neovide
end

function pwnvim
    env NVIM_APPNAME=pwnvim neovide
end

function nvs
    set items astrovim bettervim kickstart lazyvim maxvim normalvim nvchad pwnvim
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config 󰄾 " --height=~50% --layout=reverse --border --exit-0)
    if [ -z $config ]
        echo "Nothing selected"
        return 0
    else if [ $config = default ]
        set config ""
    end
    env NVIM_APPNAME=$config neovide $argv
end

bind \ca 'nvs\n'```
