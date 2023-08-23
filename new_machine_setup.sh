
flatpak remote-delete flathub
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub me.kozec.syncthingtk -y
flatpak install flathub com.calibre_ebook.calibre -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub com.slack.Slack -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.github.Eloston.UngoogledChromium -y
flatpak install flathub com.usebottles.bottles -y
flatpak install flathub net.davidotek.pupgui2 -y
flatpak install flathub com.github.johnfactotum.Foliate -y
flatpak install flathub info.febvre.Komikku -y
flatpak install flathub com.github.tenderowl.frog -y
flatpak install flathub io.github.peazip.PeaZip -y
flatpak install flathub net.cozic.joplin_desktop -y
flatpak install flathub it.mijorus.smile -y
flatpak install flathub org.signal.Signal -y
flatpak install flathub org.onlyoffice.desktopeditors -y
flatpak install flathub io.github.cboxdoerfer.FSearch -y
flatpak install flathub fr.romainvigier.MetadataCleaner -y
flatpak install flathub net.ankiweb.Anki -y
flatpak install flathub com.microsoft.Edge -y
flatpak install flathub ua.org.brezblock.q4wine -y
flatpak install flathub com.sublimetext.three -y
flatpak install flathub org.kde.gwenview -y
flatpak install flathub com.heroicgameslauncher.hgl -y
flatpak install flathub dev.lapce.lapce -y
flatpak install flathub org.qbittorrent.qBittorrent -y
flatpak install flathub com.authy.Authy -y
flatpak install flathub com.github.tchx84.Flatseal -y
flatpak install flathub com.system76.Popsicle -y
flatpak install flathub com.ultimaker.cura -y
flatpak install flathub io.github.cboxdoerfer.FSearch -y
flatpak install flathub net.sapples.LiveCaptions -y
flatpak install flathub org.ferdium.Ferdium -y
flatpak install flathub org.kde.kdenlive -y
flatpak install flathub org.videolan.VLC -y
flatpak install flathub org.x.Warpinator -y
flatpak install flathub com.tomjwatson.Emote -y
flatpak install flathub org.mozilla.firefox -y
flatpak install flathub com.google.Chrome -y
flatpak install flathub org.jdownloader.JDownloader -y
flatpak install flathub net.retrodeck.retrodeck -y
flatpak install flathub com.github.Matoking.protontricks -y
flatpak install flathub com.github.jeromerobert.pdfarranger -y
flatpak install flathub eu.scarpetta.PDFMixTool -y
flatpak install flathub io.gitlab.adhami3310.Converter -y

# gnome extension manager
flatpak install flathub com.mattjakeman.ExtensionManager -y


# setup KDE dolphin w/ dark backgroud
flatpak install flathub org.kde.dolphin -y
cp ./kdeglobals ~/.config/kdeglobals

cat ./.bashrc >> ~/.bashrc
cp ./.bash_dotfiles ~/.bash_dotfiles
mv ./.dotfiles ~/.dotfiles

echo "export CALIBRE_USE_DARK_PALETTE=1" >> ~/.bash_profile

# sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
# sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# sudo dnf -y install ffmpeg

# enable touchscreen scrolling on firefox wayland
echo export MOZ_ENABLE_WAYLAND=1 | sudo tee /etc/profile.d/use-moz-enable-wayland.sh

# TODO: input remapper: https://github.com/sezanzeb/input-remapper
# TODO: manga-ocr, tesseract-ocr, zbar-tools
