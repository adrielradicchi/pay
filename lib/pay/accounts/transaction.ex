defmodule Pay.Accounts.Transaction do
  alias Ecto.Multi
  alias Pay.{Accounts.Operation, Repo}

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    Multi.new()
    |> Multi.merge(fn _changes -> build_params(from_id, value) |> Operation.call(:withdraw) end)
    |> Multi.merge(fn _changes -> build_params(to_id, value) |> Operation.call(:deposit) end)
    |> run_transaction()
  end

  defp build_params(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(multi) do
    multi
    |> Repo.transaction()
    |> valid_transaction()
  end

  defp valid_transaction({:error, _operation, reason, _change}), do: {:error, reason}
  defp valid_transaction({:ok, %{deposit: to_account, withdraw: from_account}}), do: {:ok, %{to_account: to_account, from_account: from_account}}
end
