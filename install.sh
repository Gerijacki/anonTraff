#!/bin/bash

run_command() {
    command=$1
    eval "$command"
    if [ $? -ne 0 ]; then
        echo "[!] Error al ejecutar: $command"
        exit 1
    fi
}

install_anon_traff() {
    echo "[+] Instalando AnonTraff..."

    # Cambiar permisos del archivo principal
    run_command 'chmod 777 anonTraff.sh'

    # Crear directorio para el archivo
    run_command 'mkdir -p /usr/share/anonTraff'

    # Copiar el archivo principal al directorio adecuado
    run_command 'cp anonTraff.sh /usr/share/anonTraff/anonTraff.sh'

    # Crear un script de inicio en /usr/bin
    script_content='#!/bin/bash\nexec /usr/share/anonTraff/anonTraff.sh "$@"'
    echo -e "$script_content" | sudo tee /usr/bin/anonTraff > /dev/null

    # Cambiar permisos del script de inicio y del archivo principal
    run_command 'chmod +x /usr/bin/anonTraff'
    run_command 'chmod +x /usr/share/anonTraff/anonTraff.sh'

    echo -e "\n\n[+] Felicitaciones, AnonTraff se ha instalado correctamente."
    echo "    Desde ahora, solo escribe \x1b[6;30;42manonTraff\x1b[0m en la terminal."
}

uninstall_anon_traff() {
    echo "[+] Desinstalando AnonTraff..."

    # Eliminar archivos y directorios instalados
    run_command 'sudo rm -rf /usr/share/anonTraff'
    run_command 'sudo rm -f /usr/bin/anonTraff'

    echo '[!] Ahora AnonTraff ha sido eliminado correctamente.'
}

# Mostrar banner
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

# Solicitar elección al usuario
read -p '[+] Para instalar, presiona (Y). Para desinstalar, presiona (N) >> ' choice
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

if [ "$choice" == "y" ]; then
    install_anon_traff
elif [ "$choice" == "n" ]; then
    uninstall_anon_traff
else
    echo '[!] Opción no válida. Por favor, ingresa "Y" para instalar o "N" para desinstalar.'
    exit 1
fi
