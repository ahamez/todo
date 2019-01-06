defmodule Todo.Cache do
  require Logger

  def start_link() do
    Logger.info("Starting #{__MODULE__}")

    DynamicSupervisor.start_link(
      name: __MODULE__,
      strategy: :one_for_one
    )
  end

  def child_spec(_arg) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :supervisor
    }
  end

  def server_process(todo_list_name) do
    Todo.Server.whereis(todo_list_name) || new_process(todo_list_name)
  end

  # --

  defp new_process(todo_list_name) do
    status =
      DynamicSupervisor.start_child(
        __MODULE__,
        {Todo.Server, todo_list_name}
      )

    case status do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
  end
end
