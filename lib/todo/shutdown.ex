defmodule Todo.Shutdown do
  require Logger
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, [])
  end

  @impl GenServer
  def init(_args) do
    # Will receive a message for SIGTERM
    Process.flag(:trap_exit, true)
    {:ok, nil}
  end

  @impl GenServer
  def terminate(reason, _state) do
    Logger.info("Terminating #{inspect(reason)}")
    Process.sleep(5000)
  end
end
