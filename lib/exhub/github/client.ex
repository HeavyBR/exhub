defmodule Exhub.Github.Client do
  @base_url "https://api.github.com/users"

  use Tesla

  alias Exhub.Error
  alias Exhub.Github.Behaviour
  alias Tesla.Env

  plug Tesla.Middleware.JSON

  @behaviour Behaviour

  def get_repos(username, base_url \\ @base_url) do
    "#{base_url}/#{username}/repos"
    |> get(headers: ["user-agent": "Exhub"])
    |> handle_get()
  end

  def handle_get(
        {:ok,
         %Env{
           body: body
         }}
      ),
      do:
        {:ok,
         Enum.map(body, fn %{
                             "id" => id,
                             "name" => name,
                             "html_url" => html_url,
                             "stargazers_count" => stargazers_count
                           } ->
           %{
             "id" => id,
             "name" => name,
             "html_url" => html_url,
             "stargazers_count" => stargazers_count
           }
         end)}

  def handle_get({:not_found, %Env{}}),
    do: {:error, Error.build(:not_found, "cannot find any repository!")}

  def handle_get({_, %Env{}}),
    do: {:error, Error.build(:bad_request, "something went wrong with the request!")}
end
