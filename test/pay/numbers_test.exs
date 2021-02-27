defmodule Pay.NumbersTest do
  use ExUnit.Case, async: true

  alias Pay.Numbers

  describe "sum_from_file/1" do
    test "when all params is valid, return the sum of numbers" do
      {:ok, %{result: result}} = Numbers.sum_from_file("numbers")

      assert result == 37
    end

    test "when there is no file with a give name, return a error" do
      {:error, result} = Numbers.sum_from_file("banana")

      assert result == %{message: "Invalid file!", status: 400}
    end
  end
end
