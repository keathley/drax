defmodule Drax do
  @moduledoc """
  Documentation for Drax.
  """

  def tag do
    32
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, 32)
  end
end
