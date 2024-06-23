# Local
if test -e $HOME/.local/bin
  set -gx PATH $HOME/.local/bin $PATH
end

# Cargo Rust
if test -e $HOME/.cargo/bin
    set -gx PATH $HOME/.cargo/bin $PATH
end

# Golang
if test -e $HOME/go/bin
  set -gx PATH $HOME/go/bin $PATH
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# if test -f /opt/anaconda/bin/conda
#     eval /opt/anaconda/bin/conda "shell.fish" hook $argv | source
# else
#     if test -f "/opt/anaconda/etc/fish/conf.d/conda.fish"
#         . "/opt/anaconda/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH /opt/anaconda/bin $PATH
#     end
# end
# <<< conda initialize <<<
