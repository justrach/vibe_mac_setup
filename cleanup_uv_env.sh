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
    sed -i '' '/source .*uv_env\/.venv\/bin\/activate/d' ~/.zshrc
fi

echo "Cleanup complete! You can now run setup_uv_env.sh again to create a new environment." 