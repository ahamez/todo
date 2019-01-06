defmodule Todo.Web do
  require Logger
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def child_spec({http_port}) do
    Logger.info("Will listen on #{http_port}")

    Plug.Adapters.Cowboy.child_spec(
      scheme: :http,
      options: [
        port: http_port
      ],
      plug: __MODULE__
    )
  end

  post "/add_entry" do
    conn = Plug.Conn.fetch_query_params(conn)

    list = Map.fetch!(conn.params, "list")
    date = Map.fetch!(conn.params, "date") |> Date.from_iso8601!()
    text = Map.fetch!(conn.params, "text")

    list
    |> Todo.Cache.server_process()
    |> Todo.Server.add_entry(date, text)

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "#{Node.self()} #{inspect(Node.list())}\n OK")
  end

  get "/entries" do
    conn = Plug.Conn.fetch_query_params(conn)

    list = Map.fetch!(conn.params, "list")
    date = Map.fetch!(conn.params, "date") |> Date.from_iso8601!()

    entries =
      list
      |> Todo.Cache.server_process()
      |> Todo.Server.entries(date)
      |> Enum.join("\n")

    conn
    |> Plug.Conn.put_resp_content_type("text/plain")
    |> Plug.Conn.send_resp(200, "#{Node.self()} #{inspect(Node.list())}\n #{entries}")
  end
end
