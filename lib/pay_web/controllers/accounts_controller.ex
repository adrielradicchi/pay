defmodule PayWeb.AccountsController do
  use PayWeb, :controller

  alias Pay.Account
  alias Pay.Accounts.Transactions.Response, as: TransactionResponse

  action_fallback PayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Pay.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Pay.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transaction(conn, params) do #Transaction
    with {:ok, %TransactionResponse{} = transaction} <- Pay.transaction(params) do
      conn
      |> put_status(:ok)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
