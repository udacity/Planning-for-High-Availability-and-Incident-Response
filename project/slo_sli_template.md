# API Service

| Category     | SLI                                                                                                 | SLO                                                                                                         |
|--------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------|
| Availability | Successful HTTP requests per minute / Total HTTP requests per minute over the last 5 minutes >= 99% | 99%                                                                                                         |
| Latency      | 90 percentile bucket of requests per minute in milliseconds < 100 ms                                | 90% of requests below 100ms                                                                                 |
| Error Budget | Failed HTTP requests / Total HTTP requests (over 30 days period) < 20%                              | Error budget is defined at 20%. This means that 20% of the requests can fail and still be within the budget |
| Throughput   | Average number of successful requests over 5 minutes period >= 5                                    | 5 RPS indicates the application is functioning                                                              |
