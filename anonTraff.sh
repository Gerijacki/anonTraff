#!/bin/bash

# Función para instalar paquetes de Python
install_package() {
    package_name=$1
    if ! pip show "$package_name" > /dev/null 2>&1; then
        echo "[+] Instalando el paquete $package_name..."
        pip install "$package_name"
        if [ $? -eq 0 ]; then
            echo "[!] $package_name instalado exitosamente"
        else
            echo "[!] Error instalando $package_name"
            exit 1
        fi
    else
        echo "[+] El paquete $package_name ya está instalado"
    fi
}

# Función para ejecutar comandos del sistema y retornar su salida
run_command() {
    command=$1
    output=$(eval "$command" 2>&1)
    if [ $? -ne 0 ]; then
        echo "[!] Error al ejecutar comando: $command"
        echo "$output"
        exit 1
    fi
}

# Función para verificar si un paquete de sistema está instalado
is_installed() {
    package_name=$1
    dpkg -s "$package_name" > /dev/null 2>&1
}

# Verificar si pip3 está instalado
if ! is_installed "python3-pip"; then
    echo '[+] pip3 no está instalado. Instalando...'
    run_command 'sudo apt update'
    run_command 'sudo apt install python3-pip -y'
    echo '[!] pip3 instalado exitosamente'
fi

# Asegurarse de que requests y requests[socks] estén instalados
if ! python3 -c 'import requests' > /dev/null 2>&1; then
    echo '[+] python3 requests no está instalado. Instalando...'
    install_package 'requests'
    install_package 'requests[socks]'
    echo '[!] python3 requests instalado exitosamente'
fi

# Verificar si Tor está instalado
if ! command -v tor > /dev/null 2>&1; then
    echo '[+] Tor no está instalado. Instalando...'
    run_command 'sudo apt update'
    run_command 'sudo apt install tor -y'
    echo '[!] Tor instalado exitosamente'
fi

# Limpiar pantalla
clear

get_current_ip() {
    url='https://www.myexternalip.com/raw'
    ip=$(curl -s --proxy socks5://127.0.0.1:9050 "$url")
    if [ $? -eq 0 ]; then
        echo "$ip"
    else
        echo "[!] Error al obtener la IP actual"
        return 1
    fi
}

change_ip() {
    run_command "sudo service tor reload"
    new_ip=$(get_current_ip)
    if [ $? -eq 0 ]; then
        echo "[+] Tu IP ha sido cambiada a: $new_ip"
    else
        echo '[!] No se pudo obtener la nueva IP'
    fi
}

disable_ipv6() {
    run_command "sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1"
    run_command "sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1"
    run_command "sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1"
    echo "[!] IPv6 ha sido deshabilitado para mayor privacidad"
}

prevent_dns_leaks() {
    resolv_conf_path="/etc/resolv.conf"
    echo "nameserver 127.0.0.1" | sudo tee "$resolv_conf_path" > /dev/null
    if [ $? -eq 0 ]; then
        echo "[!] Fuga de DNS prevenida configurando /etc/resolv.conf"
    else
        echo "[!] Error al configurar /etc/resolv.conf para prevenir fugas de DNS"
    fi
}

# Deshabilitar IPv6 para evitar fugas de IP
disable_ipv6

# Prevenir fugas de DNS configurando el resolv.conf
prevent_dns_leaks

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

run_command "sudo service tor start"
sleep 3
echo -e "\033[1;32;40m Cambia tu SOCKS a 127.0.0.1:9050 \n"

read -p "[+] Tiempo para cambiar la IP en segundos [default=60] >> " change_interval
change_interval=${change_interval:-60}
read -p "[+] ¿Cuántas veces deseas cambiar tu IP? [default=1000, infinito=0] >> " change_count
change_count=${change_count:-1000}

if [ "$change_count" -eq 0 ]; then
    echo "[+] Modo de cambio de IP infinito activado."
    while true; do
        sleep "$change_interval"
        change_ip
    done
else
    for ((i=0; i<change_count; i++)); do
        sleep "$change_interval"
        change_ip
    done
    echo "[!] Proceso de cambio de IP completado."
fi
