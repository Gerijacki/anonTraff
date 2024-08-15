#!/bin/bash

# Función para manejar la interrupción con Ctrl+C
cleanup() {
    echo -e "\n[!] Interrupción detectada. Restaurando el estado original de Tor..."
    if [ "$TOR_STATUS" == "active" ]; then
        sudo systemctl start tor
        echo "[!] Tor se ha restaurado al estado activo."
    else
        sudo systemctl stop tor
        echo "[!] Tor se ha restaurado al estado inactivo."
    fi
    exit 0
}

# Capturar la señal SIGINT (Ctrl+C)
trap cleanup SIGINT

echo -e "\033[1;32;40m
    _   _                       _______          __  __ 
   / \ | | __ _ _ __ ___   __ _ |__   __|_ _ __  |  \/  |
  / _ \| |/ _` | '_ ` _ \ / _` |   | |/ _` | '_ \ | |\/| |
 / ___ \ | (_| | | | | | | (_| |   | | (_| | | | || |  | |
/_/   \_\_\__,_|_| |_| |_|\__,_|   |_|\__,_|_| |_||_|  |_|

\033[1;40;31m
              AnonTraff - Dynamic Tor IP Changer
\033[1;32;40m
"

# Comprobar si pip3 está instalado
if ! dpkg -s python3-pip &>/dev/null; then
    echo "[+] pip3 no está instalado"
    sudo apt update
    sudo apt install python3-pip -y
    echo "[!] pip3 instalado correctamente"
fi

# Comprobar si requests está instalado
if ! python3 -c "import requests" &>/dev/null; then
    echo "[+] python3 requests no está instalado"
    pip3 install requests
    pip3 install requests[socks]
    echo "[!] python3 requests está instalado"
fi

# Comprobar si tor está instalado
if ! which tor &>/dev/null; then
    echo "[+] tor no está instalado"
    sudo apt update
    sudo apt install tor -y
    echo "[!] tor instalado correctamente"
fi

clear

# Guardar el estado actual del servicio Tor
TOR_STATUS=$(systemctl is-active tor)

# Iniciar el servicio Tor
sudo systemctl start tor
sleep 3

# Función para obtener la IP externa
ma_ip() {
    local url="https://www.myexternalip.com/raw"
    local get_ip=$(python3 -c "import requests; print(requests.get('$url', proxies={'http': 'socks5://127.0.0.1:9050', 'https': 'socks5://127.0.0.1:9050'}).text.strip())")
    echo "$get_ip"
}

# Función para cambiar la IP
change_ip() {
    sudo systemctl reload tor
    echo "[+] Tu IP ha sido cambiada a: $(ma_ip)"
}

echo -e "\033[1;32;40m Cambia tus SOCKS a 127.0.0.1:9050 \n\033[0m"

# Leer el tiempo y la cantidad de cambios
read -p "[+] Tiempo para cambiar la IP en segundos [tipo=60] >> " x
read -p "[+] ¿Cuántas veces quieres cambiar tu IP? [tipo=1000] para cambios infinitos de IP escribe [0] >> " lin

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