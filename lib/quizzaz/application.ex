defmodule Quizzaz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Quizzaz.Repo,
      # Start the Telemetry supervisor
      QuizzazWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Quizzaz.PubSub},
      # Start the Endpoint (http/https)
      QuizzazWeb.Endpoint
      # Start a worker by calling: Quizzaz.Worker.start_link(arg)
      # {Quizzaz.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Quizzaz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    QuizzazWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
