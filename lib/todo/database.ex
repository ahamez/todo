defmodule Todo.Database do
  def child_spec(redis_server) do
    Supervisor.child_spec({Redix, name: :redix}, id: :redix)
  end

  def store(key, data) do
    key = :erlang.term_to_binary(key)
    data = :erlang.term_to_binary(data)
    {:ok, "OK"} = Redix.command(:redix, ["SET", key, data])
  end

  def get(key) do
    key = :erlang.term_to_binary(key)

    case Redix.command(:redix, ["GET", key]) do
      {:ok, nil} -> nil
      {:ok, data} -> :erlang.binary_to_term(data)
      _ -> nil
    end
  end
end
