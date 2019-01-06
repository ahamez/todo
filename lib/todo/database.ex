defmodule Todo.Database do
  require Logger

  def store(key, data) do
    {_results, bad_nodes} =
      :rpc.multicall(
        __MODULE__,
        :store_local,
        [key, data],
        :timer.seconds(3)
      )

    Enum.each(bad_nodes, &Logger.info("Store failed on node #{&1}"))
  end

  def store_local(key, data) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        Todo.DatabaseWorker.store(worker_pid, key, data)
      end
    )
  end

  def get(key) do
    :poolboy.transaction(
      __MODULE__,
      fn worker_pid ->
        Todo.DatabaseWorker.get(worker_pid, key)
      end
    )
  end

  def child_spec({db_folder, db_max_workers}) do
    :poolboy.child_spec(
      __MODULE__,
      [
        name: {:local, __MODULE__},
        worker_module: Todo.DatabaseWorker,
        size: db_max_workers
      ],
      [db_folder]
    )
  end
end
