import os
import sys

def run_command(command):
    """Ejecuta un comando del sistema y maneja posibles errores."""
    result = os.system(command)
    if result != 0:
        print(f"[!] Error al ejecutar: {command}")
        sys.exit(1)

def install_anon_traff():
    """Instala AnonTraff."""
    try:
        # Cambiar permisos del archivo principal
        run_command('chmod 777 anonTraff.py')

        # Crear directorio para el archivo
        run_command('mkdir -p /usr/share/anonTraff')

        # Copiar el archivo principal al directorio adecuado
        run_command('cp anonTraff.py /usr/share/anonTraff/anonTraff.py')

        # Crear un script de inicio en /usr/bin
        cmnd = '#!/bin/sh\nexec python3 /usr/share/anonTraff/anonTraff.py "$@"'
        with open('/usr/bin/anonTraff', 'w') as file:
            file.write(cmnd)
        
        # Cambiar permisos del script de inicio y del archivo principal
        run_command('chmod +x /usr/bin/anonTraff')
        run_command('chmod +x /usr/share/anonTraff/anonTraff.py')

        print("\n\n[+] Felicitaciones, AnonTraff se ha instalado correctamente.")
        print("    Desde ahora, solo escribe \x1b[6;30;42manonTraff\x1b[0m en la terminal.")
    except Exception as e:
        print(f"[!] Error durante la instalación: {e}")
        sys.exit(1)

def uninstall_anon_traff():
    """Desinstala AnonTraff."""
    try:
        # Eliminar archivos y directorios instalados
        run_command('rm -rf /usr/share/anonTraff')
        run_command('rm -f /usr/bin/anonTraff')
        print('[!] Ahora AnonTraff ha sido eliminado correctamente.')
    except Exception as e:
        print(f"[!] Error durante la desinstalación: {e}")
        sys.exit(1)

def main():
    # Mostrar banner
    print('''\033[1;32;40m
    _   _                       _______          __  __ 
   / \ | | __ _ _ __ ___   __ _ |__   __|_ _ __  |  \/  |
  / _ \| |/ _` | '_ ` _ \ / _` |   | |/ _` | '_ \ | |\/| |
 / ___ \ | (_| | | | | | | (_| |   | | (_| | | | || |  | |
/_/   \_\_\__,_|_| |_| |_|\__,_|   |_|\__,_|_| |_||_|  |_|

\033[1;40;31m
              AnonTraff - Dynamic Tor IP Changer
\033[1;32;40m
''')
    
    # Solicitar elección al usuario
    choice = input('[+] Para instalar, presiona (Y). Para desinstalar, presiona (N) >> ').strip().lower()

    if choice == 'y':
        install_anon_traff()
    elif choice == 'n':
        uninstall_anon_traff()
    else:
        print('[!] Opción no válida. Por favor, ingresa "Y" para instalar o "N" para desinstalar.')

if __name__ == "__main__":
    main()
