use Mix.Config

config :todo,
  redis_server: "redis://localhost:6379"

config :libcluster,
  topologies: [
    example: [
      strategy: LibCluster.LocalStrategy
    ]
  ]
