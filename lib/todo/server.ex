defmodule Todo.Server do
  require Logger
  use GenServer, restart: :temporary

  @expiry_timeout :timer.seconds(10)

  defmodule State do
    defstruct name: nil,
              todo_list: nil
  end

  # --

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: global_name(name))
  end

  def whereis(name) do
    # Lookup is local
    case :global.whereis_name({__MODULE__, name}) do
      :undefined -> nil
      pid -> pid
    end
  end

  def add_entry(pid, date, text) do
    GenServer.cast(pid, {:add_entry, date, text})
  end

  def entries(pid, date) do
    GenServer.call(pid, {:entries, date})
  end

  @impl GenServer
  def init(name) do
    send(self(), :deferred_init)

    {:ok, %State{name: name}, @expiry_timeout}
  end

  @impl GenServer
  def handle_info(:deferred_init, state) do
    list = Todo.Database.get(state.name) || Todo.List.new()
    Logger.debug("#{__MODULE__} #{state.name}'s list is #{inspect(list)}")

    {
      :noreply,
      %State{state | todo_list: list},
      @expiry_timeout
    }
  end

  @impl GenServer
  def handle_info(:timeout, state) do
    Logger.debug("#{__MODULE__} Stopping #{state.name} after #{@expiry_timeout} ms")

    {:stop, :normal, state}
  end

  @impl GenServer
  def handle_info(_uknown_message, state) do
    {:noreply, state, @expiry_timeout}
  end

  @impl GenServer
  def handle_cast({:add_entry, date, text}, state) do
    new_list = Todo.List.add_entry(state.todo_list, date, text)
    Todo.Database.store(state.name, new_list)

    {
      :noreply,
      %State{state | todo_list: new_list},
      @expiry_timeout
    }
  end

  @impl GenServer
  def handle_call({:entries, date}, _from, state) do
    {
      :reply,
      Todo.List.entries(state.todo_list, date),
      state,
      @expiry_timeout
    }
  end

  # --

  defp global_name(name) do
    {:global, {__MODULE__, name}}
  end
end
