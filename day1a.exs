defmodule Day1 do
  def loadData() do
    {:ok, file} = File.open("input_day1.txt", [:read])
    IO.read(file, :all)
  end


  def sumFuel(input) do
    input
    |> String.split("\n")
    |> Enum.map(&(String.to_integer(&1)))
    |> Enum.map(&(sum_fuel(&1, 0)))
    |> Enum.sum
  end

  defp sum_fuel(input) do
    div(input, 3) - 2
  end

  defp sum_fuel(input, accumulator) do
    x = sum_fuel(input)
    if x < 0 do
      accumulator
    else
      sum_fuel(x,accumulator + x)
    end
  end
end




IO.puts Day1.sumFuel(Day1.loadData())
