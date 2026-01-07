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

Configure starship.toml (optional):

```sh
mkdir -p ~/.config
printf 'add_newline = false\n' > ~/.config/starship.toml
```

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

Edit your Fish configuration file:

```sh
mkdir -p ~/.config/fish
code ~/.config/fish/config.fish
```

Then copy and paste the following configuration:

```sh
# ===========================================
# Fish Shell Configuration
# ===========================================

# Skip greeting message
set fish_greeting
set SPACEFISH_PROMPT_ADD_NEWLINE false

# ===========================================
# Interactive Shell Setup
# ===========================================
if status is-interactive
  # Starship prompt
  starship init fish | source

  # Zoxide (smart cd)
  zoxide init fish | source
  function cd
    mkdir -p $argv[1]
    z $argv[1]
  end

  # FZF (fuzzy finder)
  set -Ux FZF_DEFAULT_OPTS "--style full --no-clear"
  set -Ux FZF_CTRL_T_OPTS "--preview 'batcat -n --color=always {}'"
  set -Ux FZF_CTRL_R_OPTS ""
  fzf --fish | source
end

# ===========================================
# PATH Configuration
# ===========================================

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# uv / local bin
set -x PATH $HOME/.local/bin $PATH

# go (uncomment if needed)
# set -gx PATH $PATH /usr/local/go/bin

# ===========================================
# Aliases - System
# ===========================================
alias cls='clear'
alias mkdir='mkdir -pv'
alias bat='batcat'
alias ls='eza --color --long --git --no-filesize --icons --no-time --no-user --no-permissions'

# ===========================================
# Aliases - APT Package Manager
# ===========================================
alias i='sudo apt install'
alias i-get='sudo apt-get install'
alias upd='sudo apt update && sudo apt upgrade -y'
alias clean='sudo apt-get autoremove && sudo apt-get autoclean && sudo apt-get clean'

# ===========================================
# Aliases - Fish Config
# ===========================================
set -gx fish ~/.config/fish/config.fish
alias f5='source $fish'

# ===========================================
# Aliases - Docker
# ===========================================
alias d='docker'
alias dps='docker ps'
alias ds='docker stop'
alias di='docker images'
alias dex='docker exec -it'

# Docker Compose
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcs='docker compose stop'
alias dcr='docker compose restart'
alias dcl='docker compose logs'
alias dcps='docker compose ps'
alias dcb='docker compose build'
alias dcp='docker compose pull'
```

After saving the configuration, reload your Fish shell:

```sh
source ~/.config/fish/config.fish
```
