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

set -a PATH $HOME/go/bin $HOME/.atuin/bin $HOME/.yarn/bin $HOME/.local/bin /usr/local/go/bin

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

if test -d /opt/cuda/bin
    set -gx PATH /opt/cuda/bin $PATH
end

# End of Docker CLI completions

if test -d $HOME/.cargo/bin
    set -a PATH $HOME/.cargo/bin
end

if test -f "$HOME/.local/bin/env"
    bass source "$HOME/.local/bin/env"
end

if test -f "$HOMEBREW_PATH/bin/brew"
    eval "$($HOMEBREW_PATH/bin/brew shellenv)"
end

if test -d /usr/local/go/bin
    set -a PATH /usr/local/go/bin
end

if test -d $HOME/.pub-cache/bin
    set -a PATH $HOME/.pub-cache/bin
end

zoxide init fish | source
atuin init fish | source

if type -q vacuum
    vacuum completion fish | source
end

if type -q mise
    mise hook-env --shell=fish | source
end

if test -d $HOME/Android/Sdk
    set -Ux ANDROID_HOME $HOME/Android/Sdk
    set -a PATH $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/cmdline-tools/latest/bin
    set -a PATH $ANDROID_HOME/emulator
    set ANDROID_AVD_HOME $HOME/.config/.android/avd
end

if test -d $HOME/.npm-global
    set -a PATH $HOME/.npm-global/bin
end

# AWS completer
test -x (which aws_completer); and complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

if status is-interactive
    # VIM key bindings
    fish_vi_key_bindings default

    # Setup fish config
    starship init fish | source
end

# FVM — global default Flutter SDK; switch it with `fvm global <version>`.
# Per-project pins (.fvmrc) are NOT picked up here; use `fvm flutter` / `fvm dart`.
if test -d $HOME/fvm/default/bin
    set -gx PATH $HOME/fvm/default/bin $PATH
end

set --export LIBVIRT_DEFAULT_URI "qemu:///system"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
