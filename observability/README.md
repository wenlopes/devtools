# Stack de Observabilidade Local

Stack de observabilidade agnóstica para desenvolvimento local. Pode ser usada por qualquer serviço.

## Componentes

| Serviço | Porta | URL | Descrição |
|---------|-------|-----|-----------|
| **Grafana** | 3000 | http://localhost:3000 | Dashboards e visualização |
| **Prometheus** | 9090 | http://localhost:9090 | Coleta e armazenamento de métricas |
| **Jaeger** | 16686 | http://localhost:16686 | Tracing distribuído |
| **OpenSearch** | 9200 | http://localhost:9200 | Armazenamento e busca de logs |
| **OpenSearch Dashboards** | 5601 | http://localhost:5601 | UI para explorar logs |
| **OTel Collector** | 4317/4318 | - | Coleta de telemetria (gRPC/HTTP) |

## Quick Start

```bash
cd devtools
docker compose up -d
```

## Acessos

### Grafana
- **URL:** http://localhost:3000
- **Usuário:** admin
- **Senha:** admin

Os datasources (Prometheus, Jaeger, OpenSearch) já estão pré-configurados.

### Prometheus
- **URL:** http://localhost:9090

### Jaeger UI
- **URL:** http://localhost:16686

### OpenSearch Dashboards
- **URL:** http://localhost:5601

## Configuração da Aplicação

Configure as seguintes variáveis de ambiente na sua aplicação:

### Aplicação rodando no host (go run, binário)

```bash
INSTRUMENTATION_SERVICE=otel
INSTRUMENTATION_METRICS_ENDPOINT=localhost:4317
INSTRUMENTATION_TRACES_ENDPOINT=localhost:4317
INSTRUMENTATION_LOGS_ENDPOINT=localhost:4317
INSTRUMENTATION_SAMPLE_TRACE=1
```

### Aplicação rodando em container Docker

```bash
INSTRUMENTATION_SERVICE=otel
INSTRUMENTATION_METRICS_ENDPOINT=host.docker.internal:4317
INSTRUMENTATION_TRACES_ENDPOINT=host.docker.internal:4317
INSTRUMENTATION_LOGS_ENDPOINT=host.docker.internal:4317
INSTRUMENTATION_SAMPLE_TRACE=1
```

> **Nota:** Use `host.docker.internal` quando a aplicação roda em container para alcançar serviços no host.

## Queries no Grafana

As métricas terão o label `service_name` preenchido automaticamente com o valor de `APP_NAME` da aplicação.

Exemplo de query:
```promql
sum(rate(http_server_request_duration_milliseconds_count{service_name="ms-integration"}[5m])) by (http_method, http_route)
```

## Estrutura de arquivos

```
devtools/
├── docker-compose.yml
└── observability/
    ├── README.md
    ├── grafana/
    │   ├── dashboards/           # Coloque seus dashboards .json aqui
    │   └── provisioning/
    │       ├── dashboards/
    │       │   └── dashboards.yaml
    │       └── datasources/
    │           └── datasources.yaml
    ├── otel-collector/
    │   └── otel-collector-config.yaml
    └── prometheus/
        └── prometheus.yml
```

## Portas do OTel Collector

| Porta | Protocolo | Descrição |
|-------|-----------|-----------|
| 4317 | gRPC | OTLP receiver |
| 4318 | HTTP | OTLP receiver |
| 8888 | HTTP | Métricas do próprio collector |
| 8889 | HTTP | Prometheus exporter |
| 13133 | HTTP | Health check |
| 55679 | HTTP | zPages |

## Troubleshooting

### Verificar se métricas estão chegando

```bash
# Logs do otel-collector
docker logs otel-collector.devtools --tail 50

# Verificar targets no Prometheus
curl http://localhost:9090/api/v1/targets | jq '.data.activeTargets[] | {job: .labels.job, health: .health}'

# Listar métricas disponíveis
curl -s http://localhost:9090/api/v1/label/__name__/values | jq '.data[:10]'
```

### Verificar traces no Jaeger

```bash
# Listar serviços
curl http://localhost:16686/api/services
```

### Verificar logs no OpenSearch

```bash
# Verificar se o índice de logs existe
curl http://localhost:9200/_cat/indices?v

# Buscar logs recentes
curl -X GET "http://localhost:9200/otel-logs/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "size": 10,
  "sort": [{"@timestamp": "desc"}]
}'
```

## Parando a stack

```bash
cd devtools
docker compose down
```

Para remover volumes (dados persistidos):

```bash
docker compose down -v
```
