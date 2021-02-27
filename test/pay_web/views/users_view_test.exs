defmodule PayWeb.UsersViewTest do
  use PayWeb.ConnCase, async: true

  import Phoenix.View

  alias Pay.{Account, User}
  alias PayWeb.UsersView

  test "render create.json" do
    params = %{name: "Adriel", nickname: "Radicchi", email: "adriel@teste.com.br", age: 28, password: "1234567"}

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} = Pay.create_user(params)

    response = render(UsersView, "create.json", user: user)

    assert %{message: "User created!", user: %{account: %{account: %{balance: Decimal.new("0.00"), id: account_id}}, id: user_id, name: "Adriel", nickname: "Radicchi"}} == response
  end
end
