use Mix.Config

config :todo,
  http_port: 9090,
  redis_server: nil,
  redis_password: nil

import_config "#{Mix.env()}.exs"
