defmodule Todo.DatabaseWorker do
  use GenServer
  require Logger

  defmodule State do
    defstruct db_folder: nil
  end

  # -----------

  def start_link(db_folder) do
    Logger.info("Starting #{__MODULE__}")

    GenServer.start_link(__MODULE__, db_folder)
  end

  def store(worker_pid, key, data) do
    GenServer.cast(worker_pid, {:store, key, data})
  end

  def get(worker_pid, key) do
    GenServer.call(worker_pid, {:get, key})
  end

  # -----------

  @impl GenServer
  def init(db_folder) do
    {:ok, %State{db_folder: db_folder}}
  end

  @impl GenServer
  def handle_cast({:store, key, data}, state) do
    key
    |> file_name(state.db_folder)
    |> File.write!(:erlang.term_to_binary(data))

    {:noreply, state}
  end

  @impl GenServer
  def handle_call({:get, key}, _, state) do
    data =
      case File.read(file_name(key, state.db_folder)) do
        {:ok, contents} -> :erlang.binary_to_term(contents)
        _ -> nil
      end

    {:reply, data, state}
  end

  # -----------

  defp file_name(key, db_folder) do
    Path.join(db_folder, to_string(key))
  end
end
