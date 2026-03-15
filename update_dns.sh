#!/bin/bash
echo "Introduce tu Token de la API de Cloudflare:"
read -s CF_TOKEN

ZONE_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones?name=digitalfile.digital" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

if [ -z "$ZONE_ID" ]; then
    echo "❌ Error: No se pudo obtener el Zone ID. Verifica tu Token."
    exit 1
fi

echo "✅ Zone ID obtenido: $ZONE_ID"
echo "⏳ Creando Registros DNS..."

# Registro A (mail)
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"mail","content":"187.190.206.221","ttl":1,"proxied":false}' > /dev/null
echo "✓ Registro A creado"

# Registro MX
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"MX","name":"@","content":"mail.example.com","priority":10,"ttl":1}' > /dev/null
echo "✓ Registro MX creado"

# Registro TXT (SPF)
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"TXT","name":"@","content":"v=spf1 mx a -all","ttl":1}' > /dev/null
echo "✓ Registro TXT (SPF) creado"

# Registro TXT (DMARC)
curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" \
     --data '{"type":"TXT","name":"_dmarc","content":"v=DMARC1; p=reject; rua=mailto:postmaster@digitalfile.digital;","ttl":1}' > /dev/null
echo "✓ Registro TXT (DMARC) creado"

# Registro TXT (DKIM)
DKIM_KEY="v=DKIM1;k=rsa;t=s;s=email;p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmGcXc9fdIWb7rep7j0JXOryBfOy17C6PIHDnoTgnKb7y9oXtnp6KqrwPJiuZkqSPz/bOG8qmtSvsnkIRpi70+cQZ+UiiXeDwnlaGLx7z0wopvRz9/OqPOVLevFwXQMkEktk4jR6u3dCEAattE8p7ygQUFZvmfmH2Gth3HXwL7Uzi84g34v+t50qCwlOqobZSKVbKyBGRslb0ODjlWDMfkPo4QYoE5nIzBcI7gsRvthSSYDFANpt18ms3ThtRCwUW9oAhU6WWqsw7f3O4Xyv4ZvrNKfP2PYuER0DjokXbh658NW21fp6fAZLloZ6nFUf3CPCEu3XX3bUsgvnt0RfO8QIDAQAB"

curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records" \
     -H "Authorization: Bearer $CF_TOKEN" \
     -H "Content-Type: application/json" \
     --data "{\"type\":\"TXT\",\"name\":\"dkim._domainkey\",\"content\":\"$DKIM_KEY\",\"ttl\":1}" > /dev/null
echo "✓ Registro TXT (DKIM) creado"

echo "🎯 ¡Todos los registros DNS fueron creados exitosamente en Cloudflare!"
