defmodule Dictionary.Runtime.Application do
  # managing how dictionary is started
  use Application

  def start(_type, _args) do
    #start supervisor to start the server
    children = [
      { Dictionary.Runtime.Server, [] }
    ]

    options = [
      name: Dictionary.Runtime.Supervisor,
      strategy: :one_for_one
    ]

    Supervisor.start_link(children, options)
  end
end
