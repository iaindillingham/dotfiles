echo "Install Homebrew"
if ! hash brew 2>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Get brewing"
brew tap Homebrew/bundle
brew bundle
