
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

cat ./.bashrc >> ~/.bashrc
cp ./.bash_dotfiles ~/.bash_dotfiles
mv ./.dotfiles ~/.dotfiles

echo "export CALIBRE_USE_DARK_PALETTE=1" >> ~/.bash_profile
