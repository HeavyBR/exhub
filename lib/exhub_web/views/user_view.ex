defmodule ExhubWeb.UserView do
  use ExhubWeb, :view
  alias ExhubWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, email: user.email}
  end

  def render("auth.json", %{token: token}) do
    %{access_token: token}
  end
end
