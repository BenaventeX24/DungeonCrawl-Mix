defmodule DungeonCrawl.Room do
  @moduledoc """
  Documentation for `DungeonCrawl.Room`.
  """
  alias DungeonCrawl.Room
  alias DungeonCrawl.Room.Triggers
  import DungeonCrawl.Room.Action

  defstruct description: nil, actions: [], trigger: nil

  def all,
    do: [
      %Room{
        description: "You found a quiet place. Looks safe for a little nap.",
        actions: [forward(), rest()],
        trigger: Triggers.MoveForward
      },
      %Room{
        description: "You can see the light of day. You found the exit!",
        actions: [forward()],
        trigger: Triggers.Exit
      },
      %Room{
        description: "An Enemy lol",
        actions: [forward()],
        trigger: Triggers.Enemy
      }
    ]
end
