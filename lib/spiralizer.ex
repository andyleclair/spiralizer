defmodule Spiralizer do
  def spiralize(arrays, acc \\ "") do
    if length(arrays) == 0 do
      acc
    else
      {head_chunk, rest} = List.pop_at(arrays, 0)
      next_to_process = split_off_ends(rest)
      current_chunk = head_chunk ++ tails(next_to_process)
      out_text = if acc == "" do
        String.downcase(Enum.join(current_chunk, " "))
      else
        "#{acc} #{String.downcase(Enum.join(current_chunk, " "))}"
      end

      remainers(next_to_process) |>
        Enum.map(fn(list) -> Enum.reverse(list) end) |>
        Enum.reverse |>
        spiralize(out_text)
    end
  end

  def tails(pairs) do
    pairs |>
    Enum.map fn({tail, _}) -> tail end
  end

  def remainers(pairs) do
    pairs |>
    Enum.map fn({_, remainer}) -> remainer end
  end

  def split_off_ends(arrays) do
    arrays |>
    Enum.map fn(arr) -> List.pop_at(arr, length(arr) - 1) end
  end
end
