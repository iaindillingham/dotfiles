echo "Install Homebrew"
if ! hash brew 2>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Get brewing"
brew tap Homebrew/bundle
brew bundle

echo "Install Poetry"
if ! hash poetry 2>/dev/null; then
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python3 -
    poetry completions bash > $(brew --prefix)/etc/bash_completion.d/poetry.bash-completion
fi
