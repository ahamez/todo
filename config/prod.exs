use Mix.Config

config :todo,
  http_port: nil,
  redis_server: nil,
  redis_password: nil

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
