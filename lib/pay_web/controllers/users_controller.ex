defmodule PayWeb.UsersController do
  use PayWeb, :controller

  alias Pay.User

  action_fallback PayWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Pay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
