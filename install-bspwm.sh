#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Get current directory
CURRENT_DIR=$(pwd)

# Print colored message function
print_message() {
    echo -e "${2}===> ${1}${NC}"
}

# Check if package is installed
is_installed() {
    pacman -Q "$1" &> /dev/null
}

# Install base dependencies
install_base() {
    print_message "Installing base packages..." "${BLUE}"
    sudo pacman -S --needed --noconfirm base-devel git noto-fonts
    
    # Install yay if not present
    if ! command -v yay &> /dev/null; then
        print_message "Installing yay..." "${YELLOW}"
        git clone https://aur.archlinux.org/yay.git
        cd yay || exit
        makepkg -si --noconfirm
        cd "$CURRENT_DIR" || exit
        rm -rf yay
    fi
}

# Main dependencies (actualizadas según tu script original)
DEPENDENCIES=(
    archlinux-wallpaper base-devel brightnessctl bspwm dunst feh firefox geany git alacritty imagemagick jq 
    jgmenu libwebp lsd maim mpc mpd neovim ncmpcpp npm pamixer pacman-contrib 
    papirus-icon-theme physlock picom playerctl polybar polkit-gnome python-gobject ranger 
    redshift rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono ttf-jetbrains-mono-nerd 
    ttf-joypixels ttf-terminus-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs 
    xdo xdotool xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot 
    xorg-xwininfo zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting 
    zsh-completions zinit fzf reflector eww udisks2 udiskie nitrogen pywalfox xsettingsd zip 
    gtk-engines wal net-tools
)

# Install all dependencies
install_dependencies() {
    print_message "Installing dependencies..." "${BLUE}"
    for pkg in "${DEPENDENCIES[@]}"; do
        if ! is_installed "$pkg"; then
            print_message "Installing $pkg" "${YELLOW}"
            yay -S --noconfirm "$pkg" 2>> RiceError.log || print_message "Failed to install $pkg. Check RiceError.log" "${RED}"
            sleep 1
        else
            print_message "$pkg already installed" "${GREEN}"
            sleep 1
        fi
    done
}

# Backup existing configs
backup_configs() {
    print_message "Backing up existing configurations..." "${BLUE}"
    
    # Limpiar directorios de nvim
    rm -rf ~/.local/share/nvim/
    rm -rf ~/.cache/nvim/
    rm -rf ~/.local/state/nvim/
    
    # Backup
    mkdir -p ~/.config/configs_backups/
    
    CONFIGS=(
        alacritty bpytop bspwm copyq dunst flameshot gtk-2.0 gtk-3.0
        mpd ncmpcpp neofetch nitrogen nvim polybar qt5ct qt6ct
        rofi sxhkd wal
    )
    
    for config in "${CONFIGS[@]}"; do
        if [ -d "$HOME/.config/$config" ]; then
            mv "$HOME/.config/$config" "$HOME/.config/configs_backups/"
        fi
    done
}

# Setup directories and copy configs
setup_configs() {
    print_message "Setting up new configurations..." "${BLUE}"
    
    # Create necessary directories
    mkdir -p \
        "$HOME"/.config \
        "$HOME"/.cache \
        "$HOME"/.fonts \
        "$HOME"/.icons \
        "$HOME"/.themes \
        "$HOME"/.GTK-configs 

    # Copy configurations
    cp -r config/* "$HOME"/.config/
    cp -r cache/* "$HOME"/.cache/
    
    # Extract and setup themes/icons
    tar -xf icons.tar.gz
    mv -f .icons/* "$HOME"/.icons/
    
    tar -xf themes.tar.gz
    mv -f .themes/* "$HOME"/.themes/
    
    # Setup wallpapers
    mkdir -p "$HOME/Imágenes/Wallpapers"
    cp -r Wallpapers/* "$HOME/Imágenes/Wallpapers/"
    
    # Copy GTK configs
    cp -r GTK-configs/* "$HOME"/.GTK-configs/
    cp xsettingsd "$HOME"/.xsettingsd
    cp gtkrc-2.0 "$HOME"/.gtkrc-2.0
    
    # Copy aliases
    cp aliases "$HOME"/.aliases
}

# Setup Telegram theme
setup_telegram() {
    print_message "Setting up Telegram theme..." "${BLUE}"
    cd "$HOME" || exit
    git clone https://codeberg.org/thirtysixpw/walogram
    cp "$CURRENT_DIR/constantsTelegram.tdesktop-theme" "$HOME/walogram/constants.tdesktop-theme"
    cd walogram || exit
    sudo make install
    cd "$CURRENT_DIR" || exit
}

# Setup Pywal and related
setup_pywal() {
    print_message "Setting up Pywal and related tools..." "${BLUE}"
    
    # Install Pywal and related
    pip install PyGObject pywal --break-system-packages
    
    # Install pywalfox if not present
    if ! command -v pywalfox &> /dev/null; then
        pip install pywalfox --break-system-packages
    fi
    
    # Try to install pywalfox
    if ! pywalfox install; then
        print_message "Error al instalar pywalfox" "${RED}"
    fi
    
    # Setup nitrogen-pywal
    ln -s "$HOME/.config/bspwm/nitrogen-pywal.sh" "$HOME/.local/bin/nitrogen-pywal.sh"
    
    # Setup bpytop theme
    mkdir -p "$HOME/.config/bpytop/themes/"
    ln -s "$HOME/.cache/wal/bpytopPywal.theme" "$HOME/.config/bpytop/themes/bpytopPywal.theme"
    
    # Setup dunst theme
    mkdir -p "$HOME/.config/dunst/"
    ln -s "$HOME/.cache/wal/dunstrc" "$HOME/.config/dunst/dunstrc"
    wal --theme Dracula

    # Oomox install (themes GTK generator)
    cd ~/ && git clone https://github.com/themix-project/oomox.git --recursive
    cd ~/oomox && make -f po.mk install
    mv ~/oomox/ ~/.oomox
}

# Setup environment
setup_environment() {
    print_message "Setting up environment..." "${BLUE}"
    
    # Add to bashrc
    {
        echo
        echo 'export VISUAL="${EDITOR}"'
        echo 'export EDITOR="xed"'
        echo 'export TERM="alacritty"'
        echo 'export TERMINAL="alacritty"'
        echo 'export BROWSER="firefox"'
        echo 'export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"'
        echo
        echo 'export PATH="$HOME/.local/bin:$PATH"'
    } >> "$HOME/.bashrc"
    
    # Copy zshrc
    cp .zshrc "$HOME/"
    
    # Environment variables
    echo '_JAVA_AWT_WM_NONREPARENTING=1' | sudo tee -a /etc/environment
    echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment
    
    # Setup GRUB for dual boot
    echo "GRUB_DISABLE_OS_PROBER=false" | sudo tee -a /etc/default/grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    
    # Fix for visudo
    sudo ln -s "$(which nvim)" /usr/bin/vi
}

# Final configurations
final_setup() {
    print_message "Performing final configurations..." "${BLUE}"
    
    # Set permissions
    chmod +x "$HOME"/.config/bspwm/bspwmrc
    chmod +x "$HOME"/.config/bspwm/*.sh
    chmod +x "$HOME"/.config/polybar/*.sh
    chmod -R +x "$HOME"/.GTK-configs/*.sh
    
    # Install Qt plugins
    cd "$HOME" || exit
    git clone https://aur.archlinux.org/qt5-styleplugins.git
    cd qt5-styleplugins || exit
    makepkg -si --noconfirm
    cd "$HOME" || exit
    git clone https://aur.archlinux.org/qt6gtk2.git
    cd qt6gtk2 || exit
    makepkg -si --noconfirm
    cd "$CURRENT_DIR" || exit
    
    # Setup display manager
    # sudo chmod 0777 /lib/systemd/system/ly.service
    # systemctl enable ly.service
    
    # Set terminal defaults
    gsettings set org.gnome.desktop.default-applications.terminal exec /usr/bin/alacritty
    gsettings set org.cinnamon.desktop.default-applications.terminal exec /usr/bin/alacritty
    
    # Set volume
    pactl set-sink-volume @DEFAULT_SINK@ 100%
    
    # Set theme
    "$HOME"/.GTK-configs/Nord.sh
    
    # Setup nitrogen
    echo "dirs=/home/$(whoami)/Imágenes/Wallpapers;" >> "$HOME"/.config/nitrogen/nitrogen.cfg
    
    print_message "Installation completed!" "${GREEN}"
    print_message "Please logout and login to your new environment" "${YELLOW}"
}

# Main installation function
main() {
    print_message "Starting installation..." "${BLUE}"
    
    install_base
    install_dependencies
    backup_configs
    setup_configs
    setup_telegram
    setup_pywal
    setup_environment
    final_setup
}

# Execute main function
main
