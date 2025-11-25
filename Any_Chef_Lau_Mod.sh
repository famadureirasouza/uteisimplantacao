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

# 2. Rodar o primeiro script adicional (setup-chrome-chef.sh)
echo "Executando setup-chrome-chef.sh..."
sudo wget --inet4-only -O- https://gitlab.com/-/snippets/4900834/raw/main/setup-chrome-chef.sh | bash
echo "setup-chrome-chef.sh concluído."

# 3. Rodar o segundo script adicional (UpdateBobs.sh)
echo "Executando UpdateBobs.sh..."
sudo wget --inet4-only -O- https://raw.githubusercontent.com/vsimplantacao/vsimplantacao/main/UpdateBobs.sh | bash
echo "UpdateBobs.sh concluído."

# --- Fim dos Novos Passos ---
