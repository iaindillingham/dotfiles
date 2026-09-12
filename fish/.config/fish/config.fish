# config.fish
# ===========
# Configuration for fish, a command line shell for the 90s.
if status is-interactive
    brew shellenv | source
    pyenv init - --no-rehash fish | source
    direnv hook fish | source # must come after other tools that manipulate the prompt
end
