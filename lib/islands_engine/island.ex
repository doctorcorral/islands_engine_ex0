defmodule IslansEngine.Islands do
  alias IslandsEngine.{Coordinate, Island}

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinatese]

  def new(), do:
  %Island{coordinates: MapSet.new(), hit_coordinates: MapSet.new()}

  
  
end
  
