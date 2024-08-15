#!/bin/bash

# Colores para el terminal
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

# Función para manejar la interrupción con Ctrl+C
cleanup() {
    echo -e "\n${YELLOW}[!] Interrupción detectada. Restaurando el estado original de Tor...${RESET}"
    if [ "$TOR_STATUS" == "active" ]; then
        sudo systemctl start tor
        echo -e "${GREEN}[!] Tor se ha restaurado al estado activo.${RESET}"
    else
        sudo systemctl stop tor
        echo -e "${RED}[!] Tor se ha restaurado al estado inactivo.${RESET}"
    fi
    exit 0
}

# Capturar la señal SIGINT (Ctrl+C)
trap cleanup SIGINT

# Banner
echo -e "${CYAN}
    _   _                       _______          __  __ 
   / \ | | __ _ _ __ ___   __ _ |__   __|_ _ __  |  \/  |
  / _ \| |/ _\` | '_ \` _ \ / _\` |   | |/ _\` | '_ \ | |\/| |
 / ___ \ | (_| | | | | | | (_| |   | | (_| | | | || |  | |
/_/   \_\_\__,_|_| |_| |_|\__,_|   |_|\__,_|_| |_||_|  |_|
${RESET}${RED}
              AnonTraff - Dynamic Tor IP Changer
${RESET}"

# Comprobar si pip3 está instalado
if ! dpkg -s python3-pip &>/dev/null; then
    echo -e "${YELLOW}[+] pip3 no está instalado${RESET}"
    sudo apt update
    sudo apt install python3-pip -y
    echo -e "${GREEN}[!] pip3 instalado correctamente${RESET}"
fi

# Comprobar si requests está instalado
if ! python3 -c "import requests" &>/dev/null; then
    echo -e "${YELLOW}[+] python3 requests no está instalado${RESET}"
    pip3 install requests
    pip3 install requests[socks]
    echo -e "${GREEN}[!] python3 requests está instalado${RESET}"
fi

# Comprobar si tor está instalado
if ! which tor &>/dev/null; then
    echo -e "${YELLOW}[+] tor no está instalado${RESET}"
    sudo apt update
    sudo apt install tor -y
    echo -e "${GREEN}[!] tor instalado correctamente${RESET}"
fi

clear

# Guardar el estado actual del servicio Tor
TOR_STATUS=$(systemctl is-active tor)

# Iniciar el servicio Tor
sudo systemctl start tor
sleep 3

# Función para obtener la IP externa
ma_ip() {
    local get_ip=$(curl --socks5 127.0.0.1:9050 -s https://www.myexternalip.com/raw)
    echo "$get_ip"
}

# Función para cambiar la IP
change_ip() {
    sudo systemctl reload tor
    echo -e "${BLUE}[+] Tu IP ha sido cambiada a: $(ma_ip)${RESET}"
}

echo -e "${CYAN}Cambia tus SOCKS a 127.0.0.1:9050${RESET}"

# Leer el tiempo y la cantidad de cambios
read -p "${YELLOW}[+] Tiempo para cambiar la IP en segundos [tipo=60] >> ${RESET}" x
read -p "${YELLOW}[+] ¿Cuántas veces quieres cambiar tu IP? [tipo=1000] para cambios infinitos de IP escribe [0] >> ${RESET}" lin

# Cambiar IP en bucle
if [ "$lin" -eq 0 ]; then
    while true; do
        sleep "$x"
        change_ip
    done
else
    for ((i=0; i<lin; i++)); do
        sleep "$x"
        change_ip
    done
fi

# Restaurar el estado de Tor al finalizar
cleanup
