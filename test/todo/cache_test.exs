defmodule Todo.CacheTest do
  use ExUnit.Case

  test "server_process" do
    foo_pid_1 = Todo.Cache.server_process("foo")
    foo_pid_2 = Todo.Cache.server_process("foo")
    bar_pid = Todo.Cache.server_process("bar")

    assert foo_pid_1 == foo_pid_2
    assert foo_pid_1 != bar_pid
  end
end
