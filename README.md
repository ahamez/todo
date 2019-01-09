# Introduction

An Elixir playground based on the Todo application built in [Elixir in Action](https://www.manning.com/books/elixir-in-action-second-edition) to test various things like deployment with Kubernetes, releases with distillery, etc.

# More things to do

- Find how a service should be exposed in K8S
- Write real tests
- Typespecs
- Interact with a DB deployed with K8S, find how to have a nice dev workflow

# Sources

- https://www.manning.com/books/elixir-in-action-second-edition
- https://engineering.dollarshaveclub.com/elixir-otp-applications-on-kubernetes-9944636b8609
- https://hexdocs.pm/distillery/home.html
- https://medium.com/polyscribe/a-complete-guide-to-deploying-elixir-phoenix-applications-on-kubernetes-part-3-deploying-to-bd5b1fcbef87

# Related

- On Mnesia and CAP: https://medium.com/@jlouis666/mnesia-and-cap-d2673a92850

# Some commands

Launch locally
`NODES="node1@127.0.0.1 node2@127.0.0.1 node3@127.0.0.1" iex --erl "-todo http_port 9091" --name node1@127.0.0.1 -S mix`
