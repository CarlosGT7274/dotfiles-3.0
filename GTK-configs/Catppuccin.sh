killall xsettingsd

# gtk3 theme
sed -i '2s/.*/gtk-theme-name=oomox-Catppuccin/' ~/.config/gtk-3.0/settings.ini
sed -i '3s/.*/gtk-icon-theme-name=oomox-Catppuccin/' ~/.config/gtk-3.0/settings.ini

# xsettingsd
sed -i '1s/.*/Net\/ThemeName "oomox-Catppuccin"/' ~/.xsettingsd
sed -i '2s/.*/Net\/IconThemeName "oomox-Catppuccin"/' ~/.xsettingsd

# gtk2 and qt theme
sed -i '1s~.*~include "/home/mike/.themes/oomox-Catppuccin/gtk-2.0/gtkrc"~' ~/.gtkrc-2.0
sed -i '2s/.*/gtk-icon-theme-name = "oomox-Catppuccin"/' ~/.gtkrc-2.0
sed -i '3s/.*/gtk-font-name="Hurmit Nerd Font Light 9"/' ~/.gtkrc-2.0

sed -i '1s~.*~include "/home/mike/.themes/oomox-Catppuccin/gtk-2.0/gtkrc"~' ~/.gtkrc.mine
sed -i '2s/.*/gtk-icon-theme-name = "oomox-Catppuccin"/' ~/.gtkrc.mine
sed -i '3s/.*/gtk-font-name="Hurmit Nerd Font Light 9"/' ~/.gtkrc.mine


sed -i '4s/.*/icon_theme=oomox-Catppuccin/' ~/.config/qt6ct/qt6ct.conf
sed -i '4s/.*/icon_theme=oomox-Catppuccin/' ~/.config/qt5ct/qt5ct.conf

sleep 1
# Reload GTK theme
xsettingsd &
sleep 1
killall xsettingsd

# pywal change theme
wal --theme Catppuccin
~/.config/bspwm/colors.sh

# walogram (telegram theme)
walogram -s

# nitrogen Wallpaper
cd "$(xdg-user-dir PICTURES)" && nitrogen --random --set-scaled Wallpapers/Catppuccin
echo "cd "$(xdg-user-dir PICTURES)" && nitrogen --random --set-scaled Wallpapers/Catppuccin" >> ~/.config/bspwm/wallpaper.sh

# ly Display Manager colors
cp ~/.cache/wal/ly.service /lib/systemd/system/ly.service

# Pywalfox
pywalfox update
