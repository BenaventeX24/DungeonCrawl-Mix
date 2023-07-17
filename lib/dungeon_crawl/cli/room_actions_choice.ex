defmodule DungeonCrawl.CLI.RoomActions do
  @moduledoc """
  Documentation for `DungeonCrawl.RoomActions`.
  """
  alias Mix.Shell.IO, as: Shell
  import DungeonCrawl.CLI.BaseCommands

  def start(room) do
    rooms_actions = room.actions
    find_action_by_index = &Enum.at(rooms_actions, &1)

    chosen_option =
      rooms_actions
      |> display_options()
      |> generate_question()
      |> Shell.prompt()
      |> parse_answer()
      |> find_action_by_index.()

    {room, chosen_option}
  end
end
