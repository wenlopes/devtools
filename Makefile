.PHONY: up down restart logs \
	up-otel-collector down-otel-collector restart-otel-collector logs-otel-collector \
	up-jaeger down-jaeger restart-jaeger logs-jaeger \
	up-prometheus down-prometheus restart-prometheus logs-prometheus \
	up-grafana down-grafana restart-grafana logs-grafana \
	up-opensearch down-opensearch restart-opensearch logs-opensearch \
	up-opensearch-dashboards down-opensearch-dashboards restart-opensearch-dashboards logs-opensearch-dashboards \
	up-appsmith down-appsmith restart-appsmith logs-appsmith \
	up-nodered down-nodered restart-nodered logs-nodered

COMPOSE=docker compose

# ─── All services ────────────────────────────────────────────────────────────

up: ## Start all services
	$(COMPOSE) up -d

down: ## Stop all services
	$(COMPOSE) down

restart: ## Restart all services
	$(COMPOSE) restart

logs: ## Tail logs for all services
	$(COMPOSE) logs -f

# ─── OTel Collector ──────────────────────────────────────────────────────────

up-otel-collector: ## Start otel-collector
	$(COMPOSE) up -d otel-collector

down-otel-collector: ## Stop otel-collector
	$(COMPOSE) stop otel-collector

restart-otel-collector: ## Restart otel-collector
	$(COMPOSE) restart otel-collector

logs-otel-collector: ## Tail logs for otel-collector
	$(COMPOSE) logs -f otel-collector

# ─── Jaeger ──────────────────────────────────────────────────────────────────

up-jaeger: ## Start jaeger
	$(COMPOSE) up -d jaeger

down-jaeger: ## Stop jaeger
	$(COMPOSE) stop jaeger

restart-jaeger: ## Restart jaeger
	$(COMPOSE) restart jaeger

logs-jaeger: ## Tail logs for jaeger
	$(COMPOSE) logs -f jaeger

# ─── Prometheus ──────────────────────────────────────────────────────────────

up-prometheus: ## Start prometheus
	$(COMPOSE) up -d prometheus

down-prometheus: ## Stop prometheus
	$(COMPOSE) stop prometheus

restart-prometheus: ## Restart prometheus
	$(COMPOSE) restart prometheus

logs-prometheus: ## Tail logs for prometheus
	$(COMPOSE) logs -f prometheus

# ─── Grafana ─────────────────────────────────────────────────────────────────

up-grafana: ## Start grafana
	$(COMPOSE) up -d grafana

down-grafana: ## Stop grafana
	$(COMPOSE) stop grafana

restart-grafana: ## Restart grafana
	$(COMPOSE) restart grafana

logs-grafana: ## Tail logs for grafana
	$(COMPOSE) logs -f grafana

# ─── OpenSearch ──────────────────────────────────────────────────────────────

up-opensearch: ## Start opensearch
	$(COMPOSE) up -d opensearch

down-opensearch: ## Stop opensearch
	$(COMPOSE) stop opensearch

restart-opensearch: ## Restart opensearch
	$(COMPOSE) restart opensearch

logs-opensearch: ## Tail logs for opensearch
	$(COMPOSE) logs -f opensearch

# ─── OpenSearch Dashboards ───────────────────────────────────────────────────

up-opensearch-dashboards: ## Start opensearch-dashboards
	$(COMPOSE) up -d opensearch-dashboards

down-opensearch-dashboards: ## Stop opensearch-dashboards
	$(COMPOSE) stop opensearch-dashboards

restart-opensearch-dashboards: ## Restart opensearch-dashboards
	$(COMPOSE) restart opensearch-dashboards

logs-opensearch-dashboards: ## Tail logs for opensearch-dashboards
	$(COMPOSE) logs -f opensearch-dashboards

# ─── Appsmith ────────────────────────────────────────────────────────────────

up-appsmith: ## Start appsmith
	$(COMPOSE) up -d appsmith

down-appsmith: ## Stop appsmith
	$(COMPOSE) stop appsmith

restart-appsmith: ## Restart appsmith
	$(COMPOSE) restart appsmith

logs-appsmith: ## Tail logs for appsmith
	$(COMPOSE) logs -f appsmith

# ─── Node-RED ────────────────────────────────────────────────────────────────

up-nodered: ## Start nodered
	$(COMPOSE) up -d nodered

down-nodered: ## Stop nodered
	$(COMPOSE) stop nodered

restart-nodered: ## Restart nodered
	$(COMPOSE) restart nodered

logs-nodered: ## Tail logs for nodered
	$(COMPOSE) logs -f nodered

# ─── Help ────────────────────────────────────────────────────────────────────

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'