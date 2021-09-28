defmodule Exhub.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @required_params [:password, :email]

  @derive {Jason.Encoder, only: [:id, :email]}

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc """
    Returns a changeset for the user

  ## Examples

      iex> changeset(user, attrs)
      [:ok, %Changeset{}]

  """
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> put_password_hash()
  end

  @doc """
    Returns a changeset for the user

  ## Examples

      iex> changeset(attrs)
      [:ok, %Changeset{}]

  """
  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email])
    |> handle_password(attrs)
  end

  defp handle_password(changeset, attrs) do
    case Map.get(attrs, :password) do
      nil -> changeset
      _value -> changeset |> validate_length(:password, min: 6) |> put_password_hash()
    end
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
