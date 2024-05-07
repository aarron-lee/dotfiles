# bazzite/ublueOS

ujust install-brew

brew install bat
brew install btop
brew install tldr

# setup atuin
brew install atuin
curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
echo '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh' >> ~/.bashrc
sudo chcon -u system_u -r object_r --type=bin_t "$HOME/.bash-preexec.sh"
echo 'eval "$(atuin init bash  --disable-up-arrow)"' >> ~/.bashrc

flatpak install flathub com.github.zocker_160.SyncThingy -y --user
flatpak install flathub com.calibre_ebook.calibre -y --user
flatpak install flathub org.videolan.VLC -y --user
flatpak install flathub com.slack.Slack -y --user
flatpak install flathub com.discordapp.Discord -y --user
flatpak install flathub com.github.tchx84.Flatseal -y --user
flatpak install flathub com.usebottles.bottles -y --user
flatpak install flathub net.davidotek.pupgui2 -y --user
flatpak install flathub com.github.tenderowl.frog -y --user
flatpak install flathub io.github.peazip.PeaZip -y --user
flatpak install flathub net.cozic.joplin_desktop -y --user
flatpak install flathub it.mijorus.smile -y --user
flatpak install flathub org.signal.Signal -y --user
flatpak install flathub org.onlyoffice.desktopeditors -y --user
flatpak install flathub fr.romainvigier.MetadataCleaner -y --user
flatpak install flathub net.ankiweb.Anki -y --user
# flatpak install flathub ua.org.brezblock.q4wine -y --user
flatpak install flathub com.sublimetext.three -y --user
flatpak install flathub com.heroicgameslauncher.hgl -y --user
flatpak install flathub dev.lapce.lapce -y --user
flatpak install flathub org.qbittorrent.qBittorrent -y --user
flatpak install flathub com.system76.Popsicle -y --user
flatpak install flathub com.ultimaker.cura -y --user
flatpak install flathub net.sapples.LiveCaptions -y --user
flatpak install flathub org.kde.kdenlive -y --user
flatpak install flathub org.x.Warpinator -y --user
flatpak install flathub com.tomjwatson.Emote -y --user
flatpak install flathub org.mozilla.firefox -y --user
flatpak install flathub com.google.Chrome -y --user
flatpak install flathub org.jdownloader.JDownloader -y --user
flatpak install flathub net.retrodeck.retrodeck -y --user
flatpak install flathub com.github.Matoking.protontricks -y --user
flatpak install flathub com.github.jeromerobert.pdfarranger -y --user
flatpak install flathub eu.scarpetta.PDFMixTool -y --user
flatpak install flathub io.gitlab.adhami3310.Converter -y --user
flatpak install flathub net.nokyan.Resources -y --user

# gnome extension manager
# flatpak install flathub com.mattjakeman.ExtensionManager -y --user

# manage Appimages
# flatpak install flathub it.mijorus.gearlever -y --user

# setup KDE dolphin w/ dark backgroud
# flatpak install flathub org.kde.dolphin -y --user
# cp ./kdeglobals ~/.config/kdeglobals

cat ./.bashrc >> ~/.bashrc
cp ./.bash_dotfiles ~/.bash_dotfiles
mv ./.dotfiles ~/.dotfiles

mkdir ~/.fonts
cp ./.fonts/*.ttf ~/.fonts

echo "export CALIBRE_USE_DARK_PALETTE=1" >> ~/.bash_profile

# enable touchscreen scrolling on firefox wayland
echo export MOZ_ENABLE_WAYLAND=1 | sudo tee /etc/profile.d/use-moz-enable-wayland.sh

# TODO: input remapper: https://github.com/sezanzeb/input-remapper
# TODO: manga-ocr, tesseract-ocr, zbar-tools
