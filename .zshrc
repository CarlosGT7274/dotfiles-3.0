setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
#setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
#setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twiceun
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt histignorealldups sharehistory
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY

export VISUAL="${EDITOR}"
export EDITOR='nvim'
export BROWSER='chromium'

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info

_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]'

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
alias history="history 0"



function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{cyan}%f%b"
  else
    echo "%B%F{cyan}%f%b"
  fi
}

precmd () { vcs_info }

# PS1="%F{blue}  %F{yellow}%F{cyan}$(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_}%F{yellow} %F{blue}%f "
PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}>.%F{red}>)%f%b '


source /usr/share/zinit/zinit.zsh
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search



alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias mantenimiento="yay -Sc && sudo pacman -Scc"
alias purga="sudo pacman -Rns $(pacman -Qtdq) ; sudo fstrim -av"
alias update="paru -Syu --nocombinedupgrade"

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias musica="ncmpcpp"

alias ls='lsd --group-directories-first'
alias ll='lsd -la --group-directories-first'



WORDCHARS=${WORDCHARS//\/}

# configure key keybindings
bindkey -e
bindkey '^[[5~' beginning-of-buffer-or-history    # page up
bindkey '^[[6~' end-of-buffer-or-history          # page down
bindkey "^[[H" beginning-of-line                  # home
bindkey "^[[F" end-of-line                        # end
bindkey '^H' backward-kill-word                   # delete previous word
bindkey '^[[3;5~' kill-word                       # ctrl + Supr - delete next word
bindkey '^[[3~' delete-char                       # delete - delete next character
bindkey '^U' backward-kill-line                   # ctrl + U - delete line backward
bindkey '^[[1;5C' forward-word                    # ctrl + -> - move forward one word
bindkey '^[[1;5D' backward-word                   # ctrl + <- - move backward one word
bindkey ' ' magic-space                           # space - do history expansion
bindkey '^[[Z' undo                               # shift + tab - undo last action





export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"