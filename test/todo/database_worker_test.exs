# defmodule Todo.DatabaseWorkerTest do

#   use ExUnit.Case

#   test "store/get" do
#     tmp_dir = Path.join(System.tmp_dir!(), "#{System.unique_integer([:positive])}")
#     File.mkdir_p!(tmp_dir)
#     {:ok, pid} = Todo.DatabaseWorker.start_link({tmp_dir, 100})

#     Todo.DatabaseWorker.put(pid, "key", "value")
#     assert Todo.DatabaseWorker.get(pid, "key") == "value"
#   end

# end
