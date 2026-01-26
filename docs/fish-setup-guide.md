# Fish Shell Development Environment Setup

This comprehensive guide provides step-by-step instructions for setting up a complete Fish shell development environment with modern tools and utilities.
This guide targets Ubuntu and includes the current Fish config below.

## Install [`oh-my-fish`](https://github.com/oh-my-fish/oh-my-fish)

```sh
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
```

## Install [`bat`](https://github.com/sharkdp/bat) [`zoxide`](https://github.com/ajeetdsouza/zoxide)

```sh
sudo apt install -y bat zoxide
```

Ubuntu installs `bat` as `batcat`; the Fish config adds `alias bat='batcat'`.

## Install [`fzf`](https://github.com/junegunn/fzf)

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Install [`eza`](https://github.com/eza-community/eza)

```sh
sudo apt update
sudo apt install -y gpg

sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

## Install [`starship`](https://starship.rs/)

```sh
curl -sS https://starship.rs/install.sh | sh
```

```sh
starship init fish | source
```

Configure starship.toml (optional) by copying the template:

```sh
mkdir -p ~/.config
cp template/starship.toml ~/.config/starship.toml
```

Template file: [`template/starship.toml`](../template/starship.toml)

## Install [`nvm`](https://github.com/nvm-sh/nvm)

Install and integrate it with Fish:

```sh
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Install Oh My Fish plugin for nvm integration
omf install nvm

# Install and set Node.js LTS as default
nvm install --lts
nvm use --lts
nvm alias default "lts/*"
npm update -g npm
```

## Install [`pnpm`](https://pnpm.io/)

```sh
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

## Install [`bun`](https://bun.sh/)

```sh
sudo apt install -y unzip
curl -fsSL https://bun.sh/install | bash
```

### Bonus: AI Development Tools

Install popular AI CLI tools for enhanced development workflow:

```sh
# claude-code + gemini + codex
bun i -g @anthropic-ai/claude-code @google/gemini-cli @openai/codex
```

## Install [`uv`](https://docs.astral.sh/uv/)

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh

uv python install --default
```

## Install Docker Engine

Follow the official installation guide for [`Ubuntu`](https://docs.docker.com/engine/install/ubuntu/).

## Configure Fish Shell

Copy the Fish configuration template to the exact location:

```sh
mkdir -p ~/.config/fish
cp template/config.fish ~/.config/fish/config.fish
```

Template file: [`template/config.fish`](../template/config.fish)

You can edit the file afterward if needed:

```sh
code ~/.config/fish/config.fish
```

After saving the configuration, reload your Fish shell:

```sh
source ~/.config/fish/config.fish
```
Or close and open terminal.
