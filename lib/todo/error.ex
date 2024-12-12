defmodule Todo.Error do
  @keys [:status, :result]
  @enforce_keys @keys

  @type t() :: %__MODULE__{
          status: atom(),
          result: any()
        }

  defstruct @keys

  @spec build(atom(), any()) :: t()
  def build(status, result) do
    %__MODULE__{status: status, result: result}
  end

  @spec build_user_not_found() :: t()
  def build_user_not_found, do: build(:not_found, "User not found")
end
