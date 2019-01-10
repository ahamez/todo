use Mix.Config

config :todo,
  redis_server: "localhost",
  redis_password: nil

config :libcluster,
  topologies: [
    example: [
      strategy: LibCluster.LocalStrategy
    ]
  ]
