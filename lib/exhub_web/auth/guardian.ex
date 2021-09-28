defmodule ExhubWeb.Auth.Guardian do
  use Guardian, otp_app: :exhub

  alias Exhub.Accounts, as: UserGet
  alias Exhub.Accounts.User
  alias Exhub.Error

  def subject_for_token(%User{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    case UserGet.get_user(id) do
     nil -> {:error, "cannot find user"}
     user -> {:ok, user}
    end

  end

  def authenticate(%{"email" => email, "password" => password}) do
    with %User{password_hash: hash} = user <- UserGet.get_user_by_email(email),
         true <- Pbkdf2.verify_pass(password, hash),
         {:ok, token, _claims} <- encode_and_sign(user) do
      {:ok, token}
    else
      false -> {:error, Error.build(:unauthorized, "Verify your credentials")}
      error -> error
    end
  end

  def authenticate(), do: {:error, Error.build(:bad_request, "Invalid or missing parameters")}
end
