# Antigravity Skills


# 🛠 Antigravity Skills: Mailcow Local

## check_system_security
Description: Escanea el host buscando puertos abiertos que no sean necesarios.
Usage: Ejecuta esto antes de iniciar Docker.
### Implementation
```bash
netstat -tulpn | grep LISTEN

## check_mailcow_health
Description: Verifica que todos los contenedores de mailcow estén en estado 'healthy'.
Usage: Corre este comando antes de realizar cualquier migración de datos.

### Implementation
```bash
docker-compose ps | grep "unhealthy"

## verify_tls_config
Description: Verifica que el archivo nginx.conf use solo TLS 1.2 o 1.3.
Usage: Validar después de generar la configuración inicial.

### Implementation
```bash
grep "ssl_protocols" data/conf/nginx/site.conf
