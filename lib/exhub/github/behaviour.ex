defmodule Exhub.Github.Behaviour do
  alias Exhub.Error

  @typep client_result :: {:ok, map()} | {:error, Error.t()}

  @callback get_repos(String.t()) :: client_result
end
