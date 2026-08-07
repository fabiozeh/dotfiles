# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\[\e[38;5;223m\]\u\[\e[38;5;248m\]@\h\[\e[0m\] \[\e[32m\]\w\[\e[38;5;213m\] ${PS1_CMD1:+(${PS1_CMD1})}\[\e[0m\]\$ '

complete -cf sudo

export TERMINAL="foot"

alias sdf="ssh fabiozeh@sdf.org"

alias servers="cat ~/.bashrc | awk '/.+ssh\s/'"  # imprime a lista de servidores com alias pra ssh.

alias ocean-vpn="nmcli connection up fortega"
alias tpn-vpn="nmcli connection up TPN"

alias dropbox-start="systemctl --user start dropbox"
alias dropbox-stop="systemctl --user stop dropbox"
alias onedrive-start="systemctl --user start onedrive"
alias onedrive-stop="systemctl --user stop onedrive"

export PATH=$PATH:~/.scripts:~/.local/share/nvim/mason/bin:~/.local/bin

# pnpm
export PNPM_HOME="/home/fabio/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
