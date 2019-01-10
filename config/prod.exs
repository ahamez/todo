use Mix.Config

config :todo,
  http_port: "${HTTP_PORT}",
  redis_server: "${REDIS_SERVER}",
  redis_password: "${REDIS_PASSWORD}"

config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
      config: [
        service: "todo-headless",
        application_name: "todo",
        polling_interval: 3_000
      ]
    ]
  ]
