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
fi

echo "Install Node Version Manager"
if ! hash nvm 2>/dev/null; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
fi

echo "Install the latest LTS version of Node"
nvm install --lts
