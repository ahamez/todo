use Mix.Config

config :todo,
  http_port: String.to_integer(System.get_env("HTTP_PORT")),
  redis_server: System.get_env("REDIS_SERVER"),
  redis_password: System.get_env("REDIS_PASSWORD")
