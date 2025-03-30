#!/bin/bash

# Remove the virtual environment directory
VENV_DIR="$HOME/.uv_env"
if [ -d "$VENV_DIR" ]; then
    echo "Removing UV environment directory..."
    rm -rf "$VENV_DIR"
fi

# Remove the activation line from .zshrc if it exists
if [ -f ~/.zshrc ]; then
    echo "Removing UV environment activation from .zshrc..."
    # Remove any lines containing .venv or .uv_env
    sed -i '' '/source.*\.venv\/bin\/activate/d' ~/.zshrc
    sed -i '' '/source.*\.uv_env\/base\/bin\/activate/d' ~/.zshrc
    # Remove any UV-related aliases
    sed -i '' '/alias pip="uv pip"/d' ~/.zshrc
    sed -i '' '/alias python="uv python"/d' ~/.zshrc
    # Remove the UV Environment Setup section
    sed -i '' '/# UV Environment Setup/,/source \$HOME\/.cargo\/env/d' ~/.zshrc
fi

echo "Cleanup complete! You can now run setup_uv_env.sh again to create a new environment." 