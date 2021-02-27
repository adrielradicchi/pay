defmodule PayWeb.FallbackController do
  use PayWeb, :controller

  def call(conn, {:error, result}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
