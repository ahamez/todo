defmodule Todo.System do
  require Logger

  def start_link() do
    http_port = Application.fetch_env!(:todo, :http_port)
    redis_server = Application.fetch_env!(:todo, :redis_server)
    redis_password = Application.fetch_env!(:todo, :redis_password)
    topologies = Application.get_env(:libcluster, :topologies)

    Logger.info("cookie: #{inspect(Node.get_cookie())}")
    Logger.info("http_port: #{inspect(http_port)}")
    Logger.info("redis_server = #{redis_server}")
    Logger.info("redis_password = #{redis_password}")

    Supervisor.start_link(
      [
        {Cluster.Supervisor, [topologies, [name: Todo.ClusterSupervisor]]},
        Todo.Metrics,
        {Todo.Database, {redis_server, redis_password}},
        Todo.ServerCache,
        {Todo.Web, http_port},
        Todo.Shutdown
      ],
      strategy: :one_for_one
    )
  end
end
