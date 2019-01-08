use Mix.Config

config :todo,
  http_port: 9090

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
