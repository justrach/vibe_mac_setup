#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Set up a fixed location for the virtual environment in home directory
VENV_DIR="$HOME/.uv_env"
VENV_PATH="$VENV_DIR/base"

# Check if Homebrew is installed
if ! command_exists brew; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Xcode Command Line Tools
echo "Installing Xcode Command Line Tools..."
xcode-select --install

# Install build dependencies
echo "Installing build dependencies..."
brew install pkg-config cmake

# Check if Rust is installed
if ! command_exists rustc; then
    echo "Rust is not installed. Installing Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source "$HOME/.cargo/env"
fi

# Check if Bun is installed
if ! command_exists bun; then
    echo "Bun is not installed. Installing Bun..."
    curl -fsSL https://bun.sh/install | bash -s "bun-v1.2.7"
    source "$HOME/.bashrc" 2>/dev/null || source "$HOME/.zshrc"
fi

# Check if UV is installed
if ! command_exists uv; then
    echo "UV is not installed. Installing UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Create directory for virtual environment if it doesn't exist
mkdir -p "$VENV_DIR"

# Change to the virtual environment directory
cd "$VENV_DIR"

# Create a new virtual environment named 'base'
echo "Creating a new virtual environment named 'base'..."
uv venv base

# Activate the virtual environment
echo "Activating the virtual environment..."
source "$VENV_PATH/bin/activate"

# Upgrade pip and install basic packages
echo "Upgrading pip and installing basic packages..."
uv pip install --upgrade pip
uv pip install wheel setuptools

# Create a requirements.txt file with some basic packages
echo "Creating requirements.txt..."
cat > "$VENV_DIR/requirements.txt" << EOL
black
pylint
pytest
ipython
EOL

# Install packages from requirements.txt
echo "Installing packages from requirements.txt..."
uv pip install -r "$VENV_DIR/requirements.txt"

# Create .zshrc if it doesn't exist
if [ ! -f ~/.zshrc ]; then
    echo "Creating .zshrc file..."
    touch ~/.zshrc
fi

# Add activation and aliases to .zshrc if they don't exist
if ! grep -q "source $VENV_PATH/bin/activate" ~/.zshrc; then
    echo "Adding virtual environment activation and UV aliases to .zshrc..."
    cat >> ~/.zshrc << EOL

# UV Environment Setup
source $VENV_PATH/bin/activate

# UV aliases for convenience
alias pip="uv pip"
alias python="uv python"

# Rust and Cargo
source "\$HOME/.cargo/env"
EOL
fi

echo "UV environment setup complete!"
echo "The virtual environment will be automatically activated in new terminal windows."
echo "To deactivate the environment when needed, run: deactivate"
echo "Note: 'pip' and 'python' commands are now aliased to use UV for better performance." 