#!/bin/bash

# URL da página HTML
url="https://download.anydesk.com/linux/"

# Obter o conteúdo da página HTML usando wget e filtrar o primeiro link .deb encontrado
package=$(wget -qO- "$url" | grep -oP '(?<=<a href="./)[^"]*(\.deb)')

# Exibir a versão encontrada
echo "AnyDesk package found: $package"

# Baixar e instalar o AnyDesk
sudo wget --inet4-only -c https://download.anydesk.com/linux/$package && sudo dpkg -i $package

# --- Novos Passos Solicitados ---

# 1. Trocar o launcher do Food2 para o Food3
echo "Troca do launcher Food2 para Food3..."
# O comando abaixo deve apresentar a mensagem "Launcher atualizado para Food3"
vsd-launcher -s food
echo "Launcher do Food atualizado."

# 2. Atualizar os módulos do terminal
log() 
{
    echo $(date)
    rm ~/update-status.txt
    echo "$1" > ~/update-status.txt
}

# Versions
VsOsInterface="2.28.4"
VsAutoPagSE="2.33.7"

# Output
killall chrome
wget --inet4-only -c https://images.food.vsd.app/uploads/10075/advertising/2024/05/09/8645317ab77b45f7.gif
google-chrome --password-store=basic --kiosk --disable-pinch 8645317ab77b45f7.gif &>/dev/null &

# Prepare
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo ufw disable
sudo modprobe usbcore autosuspend=-1
xfconf-query -c xfwm4 -p /general/use_compositing -s false
sudo apt install intel-media-va-driver -y
# sudo snap remove brave
# sudo apt remove google-chrome-stable -y

log "Parando serviços..."
# Stop all services
killall node

# Backups
log "Criando Backups..."
sudo mkdir -p /opt/videosoft_bkp_log/vs-autopag-se/
sudo mkdir -p /opt/videosoft_bkp_log/vs-os-interface/

sudo mv /opt/videosoft/*tar.gz /opt/videosoft_bkp_log/
sudo mv /opt/videosoft/vs-autopag-se/log/ /opt/videosoft_bkp_log/vs-autopag-se/
sudo mv /opt/videosoft/vs-os-interface/log/ /opt/videosoft_bkp_log/vs-os-interface/

# Error apport Ubuntu remove
sudo rm /var/crash/*
sudo apt remove apport apport-symptoms -y

# Download packages
log "Download VS OS Interface...."
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-os-interface/$VsOsInterface/vs-os-interface_$VsOsInterface'_amd64.deb'
log "Download VS Autopag S.E...." 
wget --inet4-only -c https://cdn.vsd.app/softwares/vs-autopag-se/$VsAutoPagSE/vs-autopag-se_$VsAutoPagSE'_amd64.deb'

wget https://raw.githubusercontent.com/wilker-santos/VSDImplantUpdater/main/vsd-launcher.sh -O vsd-launcher 
sudo chmod 755 vsd-launcher 
sudo mv vsd-launcher /usr/bin/

# Install packages
log "Instalando VS Autopag S.E...."
sudo dpkg -i vs-autopag-se_$VsAutoPagSE'_amd64.deb'
log "Instalando VS OS Interface...."
sudo dpkg -i vs-os-interface_$VsOsInterface'_amd64.deb'
log "Download Google Chrome...."
wget --inet4-only -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
log "Instalando Google Chrome...."
sudo dpkg -i google-chrome-stable_current_amd64.deb



log "Removendo arquivos temporários...."
# Remove packages
rm *.deb
# rm vs-food.sh

log "Restaurando Backups...."
# Restaurar Backups
# Em Construção

log "Instalação Concluida"
echo "*****************Instalação Concluida*************************"

# 3. Rodar o segundo script adicional Chef
echo "Executando setup-chrome-chef.sh..."
sudo wget --inet4-only -O- https://gitlab.com/-/snippets/4900834/raw/main/setup-chrome-chef.sh | bash
echo "setup-chrome-chef.sh concluído."


# --- Fim dos Novos Passos ---
