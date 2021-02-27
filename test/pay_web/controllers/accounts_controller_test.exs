defmodule Pay.AccountsControllerTest do
  use PayWeb.ConnCase, async: true

  alias Pay.{Account, User}

  describe "deposit/1" do
    setup %{conn: conn} do
      params = %{
        name: "Adriel",
        password: "1234567",
        nickname: "radicchi",
        email: "adriel@teste.com.br",
        age: 28
      }

      {:ok, %User{account: %Account{id: account_id}}} = Pay.create_user(params)

      conn = put_req_header(conn, "authorization", "Basic cGF5OnBheTEyMw==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, make the deposit", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{"account" => %{"balance" => "50.00", "id" => _id}, "message" => "Ballance changed successfully\d!"} = response
    end

    test "when there are valid, return a error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "a"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:bad_request)

      assert response == %{"message" => %{"message" => "Invalid deposit value", "status" => 400}}
    end
  end

end
