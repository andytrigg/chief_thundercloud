defmodule Queue.Server do
  use GenServer

  def start_link(queue) do
    GenServer.start_link(__MODULE__, queue, name: __MODULE__)
  end

  def push(data) do
    GenServer.cast __MODULE__, {:push, data}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def init(queue) do
    { :ok, queue }
  end

  def handle_call(:pop, _from, [head|queue]) do
    { :reply, head, queue }
  end

  def handle_call(:pop, _from, []) do
    { :reply, :no_element_in_queue, [] }
  end

  def handle_cast({ :push, data }, queue) do
    { :noreply, :lists.append(queue, [data]) }
  end
end
