# Mailcow-Gov: Plantilla de Despliegue Genérico

Este repositorio contiene una configuración optimizada de Mailcow para entornos institucionales, incluyendo configuraciones de Relay SMTP y filtros anti-spam personalizados.

## Prerrequisitos
- **Docker Engine** 20.10+ y **Docker Compose V2**.
- Un nombre de dominio (FQDN) con acceso a DNS.
- Cuenta en un servicio de Relay (opcional, ej: SMTP2GO).

## Instalación en 3 Pasos

1. **Clonar y Preparar Configuración:**
   ```bash
   # Copiar las plantillas genéricas
   cp mailcow.conf.dist mailcow.conf
   cp data/conf/rspamd/local.d/settings.conf.dist data/conf/rspamd/local.d/settings.conf
   ```

2. **Editar Secretos:**
   Abre `mailcow.conf` y configura:
   - `MAILCOW_HOSTNAME`: Tu dominio (ej: mail.tuservidor.com).
   - `DBPASS`, `DBROOT`, `REDISPASS`: Genera contraseñas aleatorias seguras.
   - `TZ`: Tu zona horaria.

3. **Desplegar:**
   ```bash
   docker compose up -d
   ```

## Características Incluidas
- **Protección Institucional:** Configuración de Rspamd para confianza de dominios específicos.
- **Relay Externo:** Preparado para integrarse con Smarthosts.
- **Seguridad:** Hardening de protocolos TLS y antivirus activado por defecto.

---
*Este proyecto es una distribución genérica basada en Mailcow Dockerized.*
