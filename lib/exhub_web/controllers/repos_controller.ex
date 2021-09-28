defmodule ExhubWeb.ReposController do
  use ExhubWeb, :controller

  alias Exhub.Github.Client

  action_fallback ExhubWeb.FallbackController

  def index(conn, %{"username" => username}) do
    with {:ok, repos} <- Client.get_repos(username) do
      render(conn, "index.json", repos: repos)
    end
  end
end
