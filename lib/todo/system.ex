defmodule Todo.System do
  require Logger

  @db_folder ".persistence"
  @db_max_workers 3

  def start_link() do
    Logger.info("#{Application.fetch_env!(:todo, :foo)}")

    http_port = Application.fetch_env!(:todo, :http_port)

    File.mkdir_p!(@db_folder)

    topologies = Application.get_env(:libcluster, :topologies)

    Logger.info("Cookie: #{inspect(Node.get_cookie())}")

    Supervisor.start_link(
      [
        {Cluster.Supervisor, [topologies, [name: Todo.ClusterSupervisor]]},
        Todo.Metrics,
        {Todo.Database, {@db_folder, @db_max_workers}},
        Todo.ServerCache,
        {Todo.Web, {http_port}},
        Todo.Shutdown
      ],
      strategy: :one_for_one
    )
  end
end
