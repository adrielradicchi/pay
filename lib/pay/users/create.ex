defmodule Pay.Users.Create do
  alias Ecto.Multi
  alias Pay.{Account, Repo, User}

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn repo, %{create_user: user} -> insert_account(user, repo) end)
    |> Multi.run(:preload_data, fn repo, %{create_user: user} -> preload_data(user, repo) end)
    |> run_transaction()
  end

  defp insert_account(user, repo) do
    user.id
    |> account_changeset()
    |> repo.insert
  end

  defp account_changeset(user_id), do: Account.changeset(%{user_id: user_id, balance: "0.00"})

  defp preload_data(user, repo), do: {:ok, repo.preload(user, :account)}

  defp run_transaction(multi) do
    multi
    |> Repo.transaction()
    |> valid_transaction()
  end

  defp valid_transaction({:error, _operation, reason, _change}), do: {:error, reason}
  defp valid_transaction({:ok, %{preload_data: user}}), do: {:ok, user}

end
