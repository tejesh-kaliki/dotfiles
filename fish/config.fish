if test (uname) = Darwin
    set -gx OS_TYPE mac
else if test (uname) = Linux
    set -gx OS_TYPE linux
else
    set -gx OS_TYPE unknown
end

if test "$OS_TYPE" = mac
    if test -d /opt/homebrew
        set -gx HOMEBREW_PATH /opt/homebrew
    else if test -d /usr/local/Homebrew
        set -gx HOMEBREW_PATH /usr/local/homebrew
    end
else if test "$OS_TYPE" = linux
    if test -d /home/linuxbrew/.linuxbrew
        set -gx HOMEBREW_PATH /home/linuxbrew/.linuxbrew
    end
end

set -a PATH $HOME/go/bin $HOME/.atuin/bin $HOME/.yarn/bin $HOME/.local/bin

set -x NVM_DIR "$HOME/.nvm"
if test -s "$NVM_DIR/nvm.sh"
    bass source "$NVM_DIR/nvm.sh" # This loads nvm
end

if test -s "$NVM_DIR/bash_completion"
    bass source "$NVM_DIR/bash_completion" # This loads nvm bash_completion
end
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
# Fish doesn't use fpath like zsh, completions work differently
if test -d $HOME/.docker/completions
    set -a fish_complete_path $HOME/.docker/completions
end

if test -d /opt/nvim-linux-x86_64/bin 
  set -gx PATH /opt/nvim-linux-x86_64/bin $PATH
end

# End of Docker CLI completions

if test -f "$HOME/.local/bin/env"
    bass source "$HOME/.local/bin/env"
end

if test -f "$HOMEBREW_PATH/bin/brew"
    eval "$($HOMEBREW_PATH/bin/brew shellenv)"
end

if test -d "/usr/local/go/bin"
    set -a PATH /usr/local/go/bin
end

zoxide init fish | source
atuin init fish | source

if type -q vacuum
    vacuum completion fish | source
end

# AWS completer
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

if status is-interactive
    # VIM key bindings
    fish_vi_key_bindings default

    # Setup fish config
    starship init fish | source
end
