# config.fish
# ===========
# Configuration for fish, a command line shell for the 90s.
if status is-interactive
    brew shellenv | source
    fnm env --use-on-cd --shell fish | source
    pyenv init - | source
    starship init fish | source
    direnv hook fish | source # must come after other tools that manipulate the prompt
    source $HOME/.orbstack/shell/init.fish
    source $HOME/Code/tinted-theming/tinted-fzf/fish/base16-solarized-light.fish
end
