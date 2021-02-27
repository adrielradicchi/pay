defmodule Pay.Accounts.Deposit do
  alias Pay.{Accounts.Operation, Repo}

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(multi) do
    multi
    |> Repo.transaction()
    |> valid_transaction()
  end

  defp valid_transaction({:error, _operation, reason, _change}), do: {:error, reason}
  defp valid_transaction({:ok, %{deposit: account}}), do: {:ok, account}
end
