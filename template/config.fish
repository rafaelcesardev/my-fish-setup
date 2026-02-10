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
alias dv='docker volume'
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
