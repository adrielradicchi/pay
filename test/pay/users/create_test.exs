defmodule Pay.Users.CreateTest do
  use Pay.DataCase, async: true

  alias Pay.User
  alias Pay.Users.Create

  describe "call/1" do
    test "when all params are valid, return a user" do
      params = %{name: "Adriel", nickname: "Radicchi", email: "adriel@teste.com.br", age: 28, password: "1234567"}

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Adriel",  age: 28, id: ^user_id} = user
    end

    test "when there are invalid, return a error" do
      params = %{name: "Adriel", nickname: "Radicchi", email: "adriel@teste.com.br", age: 10}

      {:error, response} = Create.call(params)

      assert errors_on(response) == %{age: ["must be greater than or equal to 18"], password: ["can't be blank"]}
    end
  end
end
