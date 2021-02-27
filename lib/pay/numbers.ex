defmodule Pay.Numbers do

  def sum_from_file(filename) do
    "#{filename}.csv"
    |> File.read()
    |> handle_response()
  end

  defp handle_response({:ok, numbers}) do
    result =
      numbers
      |> String.split(",")
      |> Stream.map(&String.to_integer(&1))
      |> Enum.sum()

    {:ok, %{result: result}}
  end

  defp handle_response({:error, _reason}), do:  {:error, %{message: "Invalid file!", status: 400}}
end
