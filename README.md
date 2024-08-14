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

- **Python 3**: Asegúrate de tener Python 3 instalado en tu sistema.
- **Tor**: Debe estar instalado y funcionando en tu sistema.
- **Paquete `requests`**: Se utiliza para realizar solicitudes HTTP a través de Tor.

## Instalación

Para instalar **AnonTraff**, sigue estos pasos:

1. **Descargar el Script de Instalación**:

   Descarga el script `install.py` (o cualquier nombre que elijas para el script de instalación) desde el repositorio de GitHub o el sitio donde esté disponible.

2. **Ejecutar el Script de Instalación**:

   Abre una terminal y navega al directorio donde se encuentra `install.py`. Luego, ejecuta el siguiente comando:

   ```bash
   python3 install.py
   ```

   El script te pedirá confirmación para instalar. Escribe `Y` para proceder con la instalación.

3. **Configuración Inicial**:

   Asegúrate de que Tor esté instalado y funcionando en tu sistema. Puedes instalar Tor con:

   ```bash
   sudo apt update
   sudo apt install tor
   ```

   También asegúrate de que el servicio Tor esté en ejecución:

   ```bash
   sudo service tor start
   ```

## Uso

Para cambiar tu IP utilizando AnonTraff, simplemente ejecuta el siguiente comando en la terminal:

```bash
anonTraff
```

El script te pedirá el intervalo en segundos para cambiar la IP y el número de veces que deseas cambiar la IP. 

### Ejemplo de Uso:

1. Ejecuta el comando `anonTraff` en la terminal.
2. Ingresa el intervalo de tiempo en segundos (por ejemplo, `60`).
3. Ingresa el número de cambios de IP que deseas realizar (por ejemplo, `10`). Si deseas un número infinito de cambios, ingresa `0`.

**AnonTraff** cambiará tu IP a través de Tor en el intervalo especificado.

## Desinstalación

Para desinstalar **AnonTraff**, ejecuta el script de desinstalación con el siguiente comando:

```bash
python3 install.py
```

Cuando se te solicite, elige `N` para desinstalar. El script eliminará los archivos y configuraciones asociados con **AnonTraff**.

## Contribuir

Si deseas contribuir al desarrollo de **AnonTraff**, puedes hacerlo de las siguientes maneras:

- **Reportar Problemas**: Abre un problema en el repositorio de GitHub para reportar errores o problemas.
- **Enviar Solicitudes de Extracción**: Contribuye con nuevas características o correcciones de errores enviando solicitudes de extracción (pull requests).

## Licencia

Este proyecto está licenciado bajo la Licencia MIT. Consulta el archivo [LICENSE](LICENSE) para obtener más detalles.

---

¡Gracias por usar **AnonTraff**! Si tienes alguna pregunta o necesitas asistencia, no dudes en ponerte en contacto.
