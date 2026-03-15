# Documento de Dependencias y Auditoría de Imágenes

Este documento detalla los componentes externos y las imágenes base utilizadas en este proyecto para asegurar la transparencia y portabilidad.

## 1. Auditoría de Imágenes de Docker
Todas las imágenes utilizadas son **estándares** y provienen de fuentes oficiales o mantenidas por la comunidad de Mailcow. No se utilizan imágenes personalizadas (custom) fuera del ecosistema estándar.

| Servicio | Imagen | Fuente |
| :--- | :--- | :--- |
| **Bases de Datos** | `mariadb:10.11`, `redis:7.4-alpine` | Docker Hub (Oficial) |
| **Core Mailcow** | `ghcr.io/mailcow/*` (Postfix, Dovecot, Rspamd, Nginx, ACME, etc.) | GitHub Container Registry (Oficial Mailcow) |
| **Soporte** | `memcached:alpine`, `mcuadros/ofelia:latest` | Docker Hub |

**Conclusión:** Las imágenes son seguras y estandarizadas.

---

## 2. Dependencias de Terceros
El proyecto tiene las siguientes dependencias externas para su funcionamiento óptimo:

### A. Infraestructura (Obligatorio)
- **Docker Engine (20.10+):** Para la orquestación de servicios.
- **Docker Compose (V2):** Para la gestión del stack.

### B. Servicios de Red (Configurable)
- **SMTP2GO (Relay):** Utilizado para el envío de correos salientes y evitar bloqueos por IP.
- **Let's Encrypt:** Utilizado por el contenedor ACME para la emisión de certificados SSL.
- **Cloudflare API (Opcional):** Utilizado si se requiere actualización dinámica de DNS o validación de dominio DNS-01.

### C. Sistema Operativo
- **Terminal compatible con Bash:** Necesaria para ejecutar los scripts de ayuda (`helper-scripts/`).

---

## 3. Lista de Datos Sensibles Removidos (Sanitización)
Para la versión pública, se han removido los siguientes datos:
- `MAILCOW_HOSTNAME`: Cambiado a `mail.example.com`.
- `DBPASS`, `DBROOT`, `REDISPASS`: Cambiados a valores genéricos.
- `ACME_ACCOUNT_EMAIL`: Cambiado por un placeholder.
- Referencias al dominio gubernamental en los filtros de Rspamd.
