use Mix.Config

config :todo,
  http_port: 9090,
  redis_server: "oldfashioned-condor-redis-master",
  redis_password: "F2lI53Weyf"

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
