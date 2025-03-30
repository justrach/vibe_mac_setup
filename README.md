# UV Environment Setup

This repository contains scripts to set up a fast and efficient Python development environment using UV (a blazing-fast Python package installer and resolver).

## Features

- 🚀 UV-based Python environment for faster package installation
- 🔧 Automatic installation of development tools:
  - Xcode Command Line Tools
  - Homebrew
  - pkg-config and cmake
  - Rust
  - Bun
- 🐍 Pre-configured Python environment with common development packages
- 🔄 Automatic environment activation in new terminal windows
- ⚡ UV-powered pip and python commands

## Prerequisites

- macOS (tested on macOS 24.3.0)
- zsh shell
- Internet connection for package installation

## Installation

1. Clone this repository:
```bash
git clone <your-repo-url>
cd install_uv
```

2. Make the scripts executable:
```bash
chmod +x setup_uv_env.sh cleanup_uv_env.sh
```

3. Run the setup script:
```bash
./setup_uv_env.sh
```

The script will:
- Install Xcode Command Line Tools
- Install Homebrew and system dependencies
- Install Rust and Bun
- Create a UV-based Python virtual environment
- Configure your shell to automatically activate the environment

## Usage

### Activating the Environment

The environment is automatically activated in new terminal windows. If you need to activate it manually:

```bash
source ~/.uv_env/base/bin/activate
```

### Deactivating the Environment

To deactivate the environment when needed:

```bash
deactivate
```

### Package Management

The environment uses UV for package management. You can use either:

```bash
pip install <package>  # Automatically uses UV
# or
uv pip install <package>  # Explicitly using UV
```

### Cleaning Up

To remove the environment and its configuration:

```bash
./cleanup_uv_env.sh
```

## Included Packages

The environment comes pre-installed with:
- `black`: Code formatter
- `pylint`: Code linter
- `pytest`: Testing framework
- `ipython`: Enhanced Python shell

## Customization

You can modify the `requirements.txt` file in the setup script to add or remove packages from the initial installation.

## Troubleshooting

If you encounter any issues:
1. Run the cleanup script
2. Make sure Xcode Command Line Tools are installed
3. Run the setup script again

## License

MIT License - feel free to use and modify as needed.
