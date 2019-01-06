defmodule Todo.List do
  alias __MODULE__

  @enforce_keys [:data]
  defstruct data: %{}

  def new() do
    %List{data: %{}}
  end

  def add_entry(list, date, text) do
    new_data =
      list.data
      |> Map.get_and_update(
        date,
        fn
          nil -> {nil, [text]}
          xs -> {xs, [text | xs]}
        end
      )
      |> elem(1)

    %List{data: new_data}
  end

  def entries(list, date) do
    Map.get(list.data, date) || []
  end
end
