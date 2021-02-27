defmodule Pay.Accounts.Transactions.Response do
  @keys [:from_account, :to_account]

  alias Pay.Account

  defstruct @keys

  def build(%Account{} = from_account, %Account{} = to_account) do
    %__MODULE__{
      from_account: from_account,
      to_account: to_account
    }
  end
end
