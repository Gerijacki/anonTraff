import time
import os
import subprocess
import sys

def install_package(package_name):
    """Instala un paquete de Python utilizando pip."""
    try:
        subprocess.check_call([sys.executable, "-m", "pip", "install", package_name])
        print(f"[!] {package_name} instalado exitosamente")
    except subprocess.CalledProcessError:
        print(f"[!] Error instalando {package_name}")
        sys.exit(1)

def run_command(command, shell=False):
    """Ejecuta un comando del sistema y retorna su salida."""
    try:
        return subprocess.check_output(command, shell=shell, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"[!] Error al ejecutar comando: {command}")
        sys.exit(1)

def is_installed(package_name):
    """Verifica si un paquete de sistema está instalado."""
    try:
        run_command(f"dpkg -s {package_name}", shell=True)
        return True
    except subprocess.CalledProcessError:
        return False

# Check if pip3 is installed
if not is_installed("python3-pip"):
    print('[+] pip3 no está instalado. Instalando...')
    run_command('sudo apt update', shell=True)
    run_command('sudo apt install python3-pip -y', shell=True)
    print('[!] pip3 instalado exitosamente')

# Ensure requests and requests[socks] are installed
try:
    import requests
except ImportError:
    print('[+] python3 requests no está instalado. Instalando...')
    install_package('requests')
    install_package('requests[socks]')
    print('[!] python3 requests instalado exitosamente')

# Check if Tor is installed
try:
    run_command('which tor', shell=True)
except subprocess.CalledProcessError:
    print('[+] Tor no está instalado. Instalando...')
    run_command('sudo apt update', shell=True)
    run_command('sudo apt install tor -y', shell=True)
    print('[!] Tor instalado exitosamente')

os.system("clear")

def get_current_ip():
    """Obtiene la IP actual usando el proxy SOCKS de Tor."""
    url = 'https://www.myexternalip.com/raw'
    try:
        response = requests.get(url, proxies=dict(http='socks5://127.0.0.1:9050', https='socks5://127.0.0.1:9050'))
        response.raise_for_status()  # Asegura que la respuesta es correcta
        return response.text.strip()
    except requests.RequestException:
        print("[!] Error al obtener la IP actual")
        return None

def change_ip():
    """Cambia la IP recargando el servicio Tor."""
    run_command("sudo service tor reload", shell=True)
    new_ip = get_current_ip()
    if new_ip:
        print(f'[+] Tu IP ha sido cambiada a: {new_ip}')
    else:
        print('[!] No se pudo obtener la nueva IP')

def disable_ipv6():
    """Deshabilita IPv6 para evitar posibles fugas de IP."""
    run_command("sudo sysctl -w net.ipv6.conf.all.disable_ipv6=1", shell=True)
    run_command("sudo sysctl -w net.ipv6.conf.default.disable_ipv6=1", shell=True)
    run_command("sudo sysctl -w net.ipv6.conf.lo.disable_ipv6=1", shell=True)
    print("[!] IPv6 ha sido deshabilitado para mayor privacidad")

def prevent_dns_leaks():
    """Configura el sistema para prevenir fugas de DNS."""
    resolv_conf_path = "/etc/resolv.conf"
    try:
        with open(resolv_conf_path, "w") as resolv_file:
            resolv_file.write("nameserver 127.0.0.1\n")
        print("[!] Fuga de DNS prevenida configurando /etc/resolv.conf")
    except IOError:
        print("[!] Error al configurar /etc/resolv.conf para prevenir fugas de DNS")

# Deshabilitar IPv6 para evitar fugas de IP
disable_ipv6()

# Prevenir fugas de DNS configurando el resolv.conf
prevent_dns_leaks()

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
run_command("sudo service tor start", shell=True)
time.sleep(3)
print("\033[1;32;40m Cambia tu SOCKS a 127.0.0.1:9050 \n")

try:
    change_interval = int(input("[+] Tiempo para cambiar la IP en segundos [default=60] >> ") or "60")
    change_count = int(input("[+] ¿Cuántas veces deseas cambiar tu IP? [default=1000, infinito=0] >> ") or "1000")
except ValueError:
    print("[!] Entrada no válida. Por favor, ingresa un número válido.")
    sys.exit(1)

if change_count == 0:
    print("[+] Modo de cambio de IP infinito activado.")
    while True:
        try:
            time.sleep(change_interval)
            change_ip()
        except KeyboardInterrupt:
            print('\n[!] Auto TOR se ha cerrado')
            sys.exit(0)
else:
    for _ in range(change_count):
        time.sleep(change_interval)
        change_ip()
    print("[!] Proceso de cambio de IP completado.")
