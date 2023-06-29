
## Grafana - Guia configuracion alerta para el apdex

Sirve principalmente para la alerta apdex, pero cambiando algunos campos puede servir para cualquier otra. Tambien se puede dirigir al dashboard deseado y generar la alerta desde ahi.

Se realizó esta guia por la dificultad que se encuentra de editar y/o eliminar alertas importadas.

### 1) Configurar Contact Points

    A) Integracion con discord:
        
        - Webhook URL: https://discord.com/api/webhooks/1123740873990090782/EN05jIlHv5Hgr7588-R20fis2GPoqteCTq4aS3kvE4oL4SgMnj9dqODhGxivLIc_0usk
    
    B) Integracion con telegram: (revisar en "alermanager/config.yaml" en el conjunto de claves en "telegram_receiver")

        - BOT API Token: (en "telegram_receiver" campo "bot_token")
        - Chat ID: (en "telegram_receiver" campo "chat_id")
        - Message: (en "telegram_receiver" campo "message")

![Contact Points](./contact_points.png)


### 2) Configurar Notification policies con los valores que se encuentran en la imagen de debajo:

![Notification Policies](./notification_policies.png)


### 3) Importar en grafana el alert rule del apdex del yaml ubicado en el presente repo `grafana\provisioning\alerts\alert_rule_apdex.yaml`

Sino cargarlo manual con los siguientes campos:

```
(
  sum(rate(http_request_duration_seconds_bucket{le="0.5"}[2m])) by (job) +
  (
    sum(rate(http_request_duration_seconds_bucket{le="1"}[2m])) by (job) - 
    sum(rate(http_request_duration_seconds_bucket{le="0.5"}[2m])) by (job)
  ) / 2
) / 
sum(rate(http_request_duration_seconds_count[2m]) > 0) by (job)

```

Nota: desestimar el "irate" y "> 0" en la query en la imagen, ya que con un filtro te los elimina.

![alert_rule_1_apdex_img](./alert_rule_1_apdex.png)

En el paso (4), agregar el annotation "Summary" con el siguiente texto:

```text
In last hour, apdex average is below than 0.55 points
```

Luego en el paso (5) agregar los "Labels":
 - category = business
 - severity = critical

![alert_rule_2_apdex_img](./alert_rule_2_apdex.png)