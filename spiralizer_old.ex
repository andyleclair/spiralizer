basic_data = [ ["A", "B", "C", "D"],
               ["E", "F", "G", "H"],
               ["I", "J", "K", "L"] ]

defmodule Spiralizer do

  def spiralize(full_array) do
    cursor = %{x: 0, y: 0}
    matrix = Matrix.create_matrix(full_array)
    max_y = (length full_array) - 1
    max_x = (List.first(full_array) |> length) - 1
    step(cursor, matrix, max_x, max_y)
  end

  defp step(cursor, matrix, max_x, max_y, acc \\ "") do
    element = Matrix.at(matrix, cursor)
    IO.inspect cursor
    IO.inspect element
    if length(matrix) == 0 do
      acc
    else
      accumulated = if acc == "" do
        String.downcase element.value
      else
        "#{acc} #{String.downcase element.value}"
      end

      # The real meat and potatoes of the algo
      case cursor do
        %{x: 0, y: ^max_y } ->
          step(%{x: 0, y: max_y - 1 }, List.delete(matrix, element), max_x, max_y, accumulated)

        %{x: ^max_x, y: ^max_y } ->
          step(%{x: max_x - 1, y: max_y }, List.delete(matrix, element), max_x, max_y, accumulated)

        %{x: ^max_x, y: y } ->
          step(%{x: max_x, y: y + 1 }, List.delete(matrix, element), max_x, max_y, accumulated)

        %{x: x, y: ^max_y } ->
          step(%{x: x - 1, y: max_y }, List.delete(matrix, element), max_x, max_y, accumulated)

        %{x: x, y: y} when x < max_x and y < max_y ->
          step(%{x: x + 1, y: y }, List.delete(matrix, element), max_x, max_y, accumulated)
      end
    end
  end
end

# Convenience module to make some matrix-y bits easier
defmodule Matrix do

  defmodule Element do
    defstruct position: %{ x: 0, y: 0 }, value: ""
  end

  def create_matrix(arr_of_arr) do
    arr_of_arr |>
    Enum.with_index |>
    Enum.map(fn{arr, index_y} ->
      arr |>
      Enum.with_index |>
      Enum.map(fn{value, index_x} ->
        %Element{position: %{x: index_x, y: index_y }, value: value}
      end)
    end) |>
    List.flatten
  end

  def at(matrix, cursor) do
    Enum.find(matrix, fn(elem) ->
      elem.position == cursor
    end)
  end
end

expected = "a b c d h l k j i e f g"
spiralized = Spiralizer.spiralize(basic_data)
IO.puts "Hi, I expected #{expected} and I got #{spiralized} and they are equal? #{expected == spiralized}"

IO.puts "Let's try again with a different input here:"
round_two = [ ["A", "B", "C"],
               ["E", "F", "G"],
               ["I", "J", "K"] ]
two_expected = "a b c g k j i e f"
two_spiralized = Spiralizer.spiralize(round_two)
IO.puts "Hi, I expected #{two_expected} and I got #{two_spiralized} and they are equal? #{two_expected == two_spiralized}"

IO.puts "Let's try it on hard mode:"
hard_input = [ ["A", "B", "C", "D"],
               ["E", "F", "G", "H"],
               ["I", "J", "K", "L"],
               ["M", "N", "O", "P"]]
hard_expected = "a b c d h l p o n m i e f g k j"
hard_output = Spiralizer.spiralize(hard_input)
IO.puts "Hi, I expected #{hard_expected} and I got #{hard_output} and they are equal? #{hard_expected == hard_output}"
