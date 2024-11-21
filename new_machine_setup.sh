# bazzite/ublueOS

# ujust install-brew

# brew install bat
# brew install btop
# brew install tldr

# # setup atuin
# brew install atuin
# curl https://raw.githubusercontent.com/rcaloras/bash-preexec/master/bash-preexec.sh -o ~/.bash-preexec.sh
# echo '[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh' >> ~/.bashrc
# sudo chcon -u system_u -r object_r --type=bin_t "$HOME/.bash-preexec.sh"
# echo 'eval "$(atuin init bash  --disable-up-arrow)"' >> ~/.bashrc

flatpak install flathub io.github.vikdevelop.SaveDesktop -y --system
flatpak install flathub com.github.zocker_160.SyncThingy -y --system
flatpak install flathub com.calibre_ebook.calibre -y --system
flatpak install flathub org.videolan.VLC -y --system
flatpak install flathub com.slack.Slack -y --system
flatpak install flathub com.discordapp.Discord -y --system
flatpak install flathub com.github.tchx84.Flatseal -y --system
flatpak install flathub com.usebottles.bottles -y --system
flatpak install flathub net.davidotek.pupgui2 -y --system
flatpak install flathub com.github.tenderowl.frog -y --system
flatpak install flathub io.github.peazip.PeaZip -y --system
flatpak install flathub net.cozic.joplin_desktop -y --system
flatpak install flathub it.mijorus.smile -y --system
flatpak install flathub org.signal.Signal -y --system
flatpak install flathub org.onlyoffice.desktopeditors -y --system
flatpak install flathub fr.romainvigier.MetadataCleaner -y --system
flatpak install flathub net.ankiweb.Anki -y --system
# flatpak install flathub ua.org.brezblock.q4wine -y --system
flatpak install flathub com.sublimetext.three -y --system
flatpak install flathub com.heroicgameslauncher.hgl -y --system
flatpak install flathub dev.lapce.lapce -y --system
flatpak install flathub org.qbittorrent.qBittorrent -y --system
flatpak install flathub com.system76.Popsicle -y --system
flatpak install flathub com.ultimaker.cura -y --system
flatpak install flathub net.sapples.LiveCaptions -y --system
flatpak install flathub org.kde.kdenlive -y --system
flatpak install flathub org.x.Warpinator -y --system
flatpak install flathub com.tomjwatson.Emote -y --system
flatpak install flathub org.mozilla.firefox -y --system
flatpak install flathub com.google.Chrome -y --system
flatpak install flathub org.jdownloader.JDownloader -y --system
flatpak install flathub net.retrodeck.retrodeck -y --system
flatpak install flathub com.github.Matoking.protontricks -y --system
flatpak install flathub com.github.jeromerobert.pdfarranger -y --system
flatpak install flathub eu.scarpetta.PDFMixTool -y --system
flatpak install flathub io.gitlab.adhami3310.Converter -y --system
flatpak install flathub net.nokyan.Resources -y --system
flatpak install flathub org.localsend.localsend_app -y --system
flatpak install flathub de.leopoldluley.Clapgrep -y --system
flatpak install flathub org.kde.kolourpaint -y --system
flatpak install flathub com.github.flxzt.rnote -y --system
flatpak install flathub com.github.KRTirtho.Spotube -y --system
flatpak install flathub one.ablaze.floorp -y --system

# gnome extension manager
# flatpak install flathub com.mattjakeman.ExtensionManager -y --system

# manage Appimages
# flatpak install flathub it.mijorus.gearlever -y --system

# setup KDE dolphin w/ dark backgroud
# flatpak install flathub org.kde.dolphin -y --system
# cp ./kdeglobals ~/.config/kdeglobals

cat ./.bashrc >> ~/.bashrc
cp ./.bash_dotfiles ~/.bash_dotfiles
mv ./.dotfiles ~/.dotfiles

mkdir ~/.fonts
cp ./.fonts/*.ttf ~/.fonts

echo "export CALIBRE_USE_DARK_PALETTE=1" >> ~/.bash_profile

# enable touchscreen scrolling on firefox wayland
# echo export MOZ_ENABLE_WAYLAND=1 | sudo tee /etc/profile.d/use-moz-enable-wayland.sh

# TODO: input remapper: https://github.com/sezanzeb/input-remapper
# TODO: manga-ocr, tesseract-ocr, zbar-tools
