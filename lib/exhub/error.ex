defmodule Exhub.Error do
  @required_keys [:payload, :status]

  @enforce_keys @required_keys
  defstruct @required_keys

  def build(status, message) do
    %__MODULE__{
      status: status,
      payload: %{status: "error", message: message}
    }
  end
end
