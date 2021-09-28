defmodule ExhubWeb.ReposView do
  use ExhubWeb, :view

  def render("index.json", %{repos: repos}) do
    repos
  end
end
