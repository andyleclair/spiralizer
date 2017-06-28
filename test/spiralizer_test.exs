defmodule SpiralizerTest do
  use ExUnit.Case
  doctest Spiralizer

  test "basic default input" do
    basic_data = [ ["A", "B", "C", "D"],
                 ["E", "F", "G", "H"],
                 ["I", "J", "K", "L"] ]
    expected = "a b c d h l k j i e f g"
    spiralized = Spiralizer.spiralize(basic_data)
    assert spiralized == expected
  end

  test "easier input" do
    round_two = [ ["A", "B", "C"],
                 ["E", "F", "G"],
                 ["I", "J", "K"] ]
    two_expected = "a b c g k j i e f"
    two_spiralized = Spiralizer.spiralize(round_two)
    assert two_spiralized == two_expected
  end

  test "hard mode" do
    hard_input = [ ["A", "B", "C", "D"],
               ["E", "F", "G", "H"],
               ["I", "J", "K", "L"],
               ["M", "N", "O", "P"]]
    hard_expected = "a b c d h l p o n m i e f g k j"
    hard_output = Spiralizer.spiralize(hard_input)
    assert hard_output == hard_expected
  end
end
