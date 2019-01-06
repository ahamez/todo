use Mix.Config

config :todo,
  http_port: 9090,
  foo: :default_foo

import_config "#{Mix.env()}.exs"
