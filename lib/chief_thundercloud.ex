defmodule ChiefThundercloud do
  use Application

  def start(_type, queue) do
    Queue.Supervisor.start_link(queue)
  end
end
