defmodule Hangman.Runtime.Application do

  @super_name GameStarter

  use Application

  def start(_type, _args) do
    # DynamicSupervisor -> spawn and supervise a hangman game
    # The children are not known upfront but are started dynamically.
    supervisor_spec = [
      { DynamicSupervisor, strategy: :one_for_one, name: @super_name }
    ]

    Supervisor.start_link(supervisor_spec, strategy: :one_for_one)
  end

  # start a game server -> dynamic components
  def start_game do
    DynamicSupervisor.start_child(@super_name, { Hangman.Runtime.Server, nil })
  end
end
