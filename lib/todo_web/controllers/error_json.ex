defmodule TodoWeb.ErrorJSON do
  import Ecto.Changeset

  alias Ecto.Changeset

  def error(%{result: %Changeset{} = changeset}), do: %{message: translate_errors(changeset)}
  def error(%{result: result}), do: %{message: result}

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
