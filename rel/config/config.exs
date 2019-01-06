use Mix.Config

port = String.to_integer(System.get_env("PORT") || "8080")
foo = System.get_env("FOO") || "unfoo"

config :todo,
  http_port: port,
  foo: foo
