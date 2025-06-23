set -a PATH $PATH $HOME/go/bin

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
# End of Docker CLI completions

set -a PATH $HOME/.yarn/bin

if test -f "$HOME/.local/bin/env"
    bass source "$HOME/.local/bin/env"
end

if test -f "$HOMEBREW_REPOSITORY/bin/brew"
    eval "$($HOMEBREW_REPOSITORY/bin/brew shellenv)"
end

zoxide init fish | source
vacuum completion fish | source

# AWS completer
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

if status is-interactive
    # Commands to run in interactive sessions can go here
    tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='Two lines' --prompt_connection=Disconnected --prompt_spacing=Compact --icons='Few icons' --transient=Yes
end
