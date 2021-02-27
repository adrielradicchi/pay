defmodule PayWeb.UsersView do

  alias Pay.{Account, User}

  def render("create.json", %{user: %User{account: account, id: id, name: name, nickname: nickname}}) do
    %{
      message: "User created!",
      user: %{
        id: id,
        name: name,
        nickname: nickname,
        account: render_account(account)
      }
    }
  end

  defp render_account(%Account{id: id, balance: balance}) do
    %{
      account: %{
        id: id,
        balance: balance
      }
    }
  end

end
