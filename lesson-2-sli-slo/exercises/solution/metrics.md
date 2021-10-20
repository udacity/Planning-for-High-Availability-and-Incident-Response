# Availability
sum (rate(apiserver_request_total{job="apiserver",code!~"5.."}[2d]))
/
sum (rate(apiserver_request_total{job="apiserver"}[2d]))

# Latency
histogram_quantile(0.95,
sum(rate(apiserver_request_duration_seconds_bucket{job="apiserver"}[5m])) by (le, verb))

# Throughput
sum(rate(apiserver_request_total{job="apiserver",code=~"2.."}[5m]))

# Error Budget
1 - ((1 - (sum(increase(apiserver_request_total{job="apiserver", code="200"}[7d])) by (verb)) /  sum(increase(apiserver_request_total{job="apiserver"}[7d])) by (verb)) / (1 - .90))