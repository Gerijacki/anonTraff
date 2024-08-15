<h1 align="center">AnonTraff - Dynamic Tor IP Changer</h1>

<p align="center">
  <img src="https://github.com/Gerijacki.png" width="100" alt="Logo"/><br/>
  Hi 👋, I'm <a href="https://github.com/Gerijacki">Gerijacki</a>
</p>

<p align="center">
  <a href="https://github.com/Gerijacki/anonTraff/stargazers"><img src="https://img.shields.io/github/stars/Gerijacki/anonTraff?colorA=363a4f&colorB=b7bdf8&style=for-the-badge"></a>
  <a href="https://github.com/Gerijacki/anonTraff/issues"><img src="https://img.shields.io/github/issues/Gerijacki/anonTraff?colorA=363a4f&colorB=f5a97f&style=for-the-badge"></a>
  <a href="https://github.com/Gerijacki/anonTraff/contributors"><img src="https://img.shields.io/github/contributors/Gerijacki/anonTraff?colorA=363a4f&colorB=a6da95&style=for-the-badge"></a>
</p>

# AnonTraff

**AnonTraff** es una herramienta para cambiar dinámicamente tu dirección IP a través de la red Tor. Proporciona una manera fácil de gestionar tu dirección IP, aumentando tu privacidad en línea mediante el uso de Tor para redirigir tu tráfico de red.

## Tabla de Contenidos

- [Características](#características)
- [Requisitos](#requisitos)
- [Instalación](#instalación)
- [Uso](#uso)
- [Desinstalación](#desinstalación)
- [Contribuir](#contribuir)
- [Licencia](#licencia)

## Características

- **Cambio Dinámico de IP**: Cambia tu IP regularmente a través de Tor para mantener el anonimato.
- **Instalación Simple**: Instalación con un solo script que configura el sistema para ejecutar AnonTraff fácilmente desde la terminal.
- **Soporte para Proxy SOCKS**: Utiliza el proxy SOCKS de Tor para redirigir tu tráfico de red.

## Requisitos

- **Bash**: Asegúrate de tener Bash instalado en tu sistema (disponible por defecto en la mayoría de las distribuciones de Linux).
- **Tor**: Debe estar instalado y funcionando en tu sistema.

## Instalación

Para instalar **AnonTraff**, sigue estos pasos:

1. **Descargar los Scripts**:

   Clona el repositorio o descarga los scripts directamente desde el repositorio de GitHub:

   ```bash
   git clone https://github.com/Gerijacki/AnonTraff.git
   ```

2. **Configuración Inicial**:

   Asegúrate de que Tor esté instalado y funcionando en tu sistema. Puedes instalar Tor con:

   ```bash
   sudo apt update
   sudo apt install tor
   ```

   También asegúrate de que el servicio Tor esté en ejecución:

   ```bash
   sudo systemctl start tor
   ```

3. **Dar Permisos de Ejecución**:

   Navega al directorio donde descargaste los scripts y da permisos de ejecución al script principal:

   ```bash
   cd AnonTraff
   chmod +x anonTraff.sh
   ```

## Uso

Para cambiar tu IP utilizando **AnonTraff**, simplemente ejecuta el siguiente comando en la terminal:

```bash
./anonTraff.sh
```

El script te pedirá el intervalo en segundos para cambiar la IP y el número de veces que deseas cambiar la IP.

### Ejemplo de Uso:

1. Ejecuta el comando `./anonTraff.sh` en la terminal.
2. Ingresa el intervalo de tiempo en segundos (por ejemplo, `60`).
3. Ingresa el número de cambios de IP que deseas realizar (por ejemplo, `10`). Si deseas un número infinito de cambios, ingresa `0`.

**AnonTraff** cambiará tu IP a través de Tor en el intervalo especificado.

## Desinstalación

Para desinstalar **AnonTraff**, simplemente elimina el directorio donde se encuentran los scripts:

```bash
rm -rf /ruta/al/directorio/AnonTraff
```

## Contribuir

Si deseas contribuir al desarrollo de **AnonTraff**, puedes hacerlo de las siguientes maneras:

- **Reportar Problemas**: Abre un problema en el repositorio de GitHub para reportar errores o problemas.
- **Enviar Solicitudes de Extracción**: Contribuye con nuevas características o correcciones de errores enviando solicitudes de extracción (pull requests).

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para obtener más detalles.

---

¡Gracias por usar **AnonTraff**! Si tienes alguna pregunta o necesitas asistencia, no dudes en ponerte en contacto.

## Disclaimer

Por favor, respeta las políticas de derechos de autor al usar esta herramienta. Este proyecto está destinado únicamente para uso educativo y personal. Los desarrolladores no son responsables por cualquier mal uso del software.

---

<p align="center">
  <a href="https://github.com/Gerijacki">
    <img src="https://github-readme-stats.vercel.app/api?username=Gerijacki&show_icons=true&theme=dark&count_private=true" alt="GitHub Stats" />
  </a>
</p>

<p align="center">
  <img src="https://raw.githubusercontent.com/Trilokia/Trilokia/379277808c61ef204768a61bbc5d25bc7798ccf1/bottom_header.svg" />
</p>