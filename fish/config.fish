# Add local bin to path
fish_add_path ~/.local/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source

    # Aliases
    alias ls='eza --icons --group-directories-first'
    alias cat='bat'
    alias htop='btm'
    alias g='lazygit'
    alias grep='ripgrep'
    alias dev='dev-env.sh' # Start dev environment
    
    # Navigation
    alias ..='cd ..'
    alias ...='cd ../..'
end

# Set greeting
set -g fish_greeting ""
