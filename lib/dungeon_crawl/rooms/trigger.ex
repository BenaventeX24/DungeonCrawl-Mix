defmodule DungeonCrawl.Room.Trigger do
  @moduledoc """
  Documentation for `DungeonCrawl.Room.Trigger`.
  """

  @callback run(
              character :: DungeonCrawl.Character.t(),
              action :: DungeonCrawl.Room.Action.t()
            ) :: {DungeonCrawl.Character.t(), atom}
end
