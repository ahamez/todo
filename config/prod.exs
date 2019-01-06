use Mix.Config

config :todo,
  http_port: 8080

config :libcluster,
  topologies: [
    k8s_example: [
      strategy: Elixir.Cluster.Strategy.Kubernetes.DNS,
      config: [
        service: "todo-service-headless",
        application_name: "todo",
        polling_interval: 3_000
      ]
    ]
  ]
