defmodule Day2 do
  def loadData() do
    {:ok, file} = File.open("input_day2.txt", [:read])
    IO.read(file, :all) |> data()
  end

  def data(input) do
    input = input
    |> String.split(",")
    |> Enum.map(&(String.to_integer(&1)))

    for verb <- 0..99, noum <- 0..99 do
      temp = input |> List.replace_at(1, verb) |> List.replace_at(2, noum)
      case startProgramm(temp, 0) do
        true ->
          IO.puts verb
          IO.puts noum
        false -> ""
      end
    end
  end

  defp startProgramm(input, start) do
    map = code(input, start, 4)
    case map[:opCode] do
      :error -> "Programm Crashed"
      :eop -> Enum.at(input,0) == 19690720
      :add ->
        value1 = Enum.at(input,map[:pos1])
        value2 = Enum.at(input,map[:pos2])
        newList = List.replace_at(input, map[:pos3], value1 + value2)
        Enum.at(newList,map[:pos3])
        startProgramm(newList, start + 4)
      :mul ->
        value1 = Enum.at(input,map[:pos1])
        value2 = Enum.at(input,map[:pos2])
        newList = List.replace_at(input, map[:pos3], value1 * value2)
        Enum.at(newList,map[:pos3])
        startProgramm(newList, start + 4)
      _ -> "unkown"
    end
  end

  defp code(input, start, endPos) do
     [opCode, pos1, pos2, pos3] = Enum.slice(input, start, endPos)
     case opCode do
      1 -> %{:opCode => :add, :pos1 => pos1, :pos2 => pos2, :pos3 => pos3}
      2 -> %{:opCode => :mul, :pos1 => pos1, :pos2 => pos2, :pos3 => pos3}
      99 -> %{:opCode => :eop}
      _ -> %{:opCode => :error}
     end
  end

end

Day2.loadData()
