defmodule Queue.Supervisor do
  use Supervisor

  def start_link(queue) do
    result = {:ok, sup } = Supervisor.start_link(__MODULE__, [queue])
    start_workers(sup, queue)
    result
  end  

  def start_workers(sup, queue) do
    # Start the queue
    {:ok, stash} = Supervisor.start_child(sup, worker(Queue.Server, [queue]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one                          
  end
end
