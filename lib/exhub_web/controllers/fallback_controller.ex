defmodule ExhubWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ExhubWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ExhubWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ExhubWeb.ErrorView)
    |> render(:"404")
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, %Exhub.Error{status: status, payload: payload}}) do
    conn
    |> put_status(status)
    |> put_view(ExhubWeb.ErrorView)
    |> render("error.json", error: payload)
  end
end
