defmodule DungeonCrawl.CLI.Main do
  @moduledoc """
  Documentation for `DungeonCrawl.Main`.
  """
  alias Mix.Shell.IO, as: Shell

  def start_game do
    welcome_message()
    Shell.prompt("Press Enter to continue")
    crawl(hero_choice(), DungeonCrawl.Room.all())
  end

  defp crawl(%{hit_points: 0}, _rooms) do
    Shell.prompt("")
    Shell.cmd("clear")
    Shell.info("Unfortunately your wounds are too many to keep walking.")
    Shell.info("You fall onto the floor without strength to carry on.")
    Shell.info("Game over!")
    Shell.prompt("")
  end

  defp crawl(hero, rooms) do
    Shell.info("You keep moving forward to the next room.")
    Shell.prompt("Press Enter to continue")
    Shell.cmd("clear")

    Shell.info(DungeonCrawl.Character.current_status(hero))

    rooms
    |> Enum.random()
    |> DungeonCrawl.CLI.RoomActions.start()
    |> trigger_action(hero)
    |> handle_action_result
  end

  def welcome_message() do
    Shell.info("== Dungeon Crawl ===")
    Shell.info("You awake in a dungeon full of monsters.")
    Shell.info("You need to survive and find the exit.")
  end

  defp trigger_action({room, action}, character) do
    Shell.cmd("clear")
    room.trigger.run(character, action)
  end

  defp handle_action_result({_, :exit}),
    do: Shell.info("You found the exit. You won the game. Congratulations!")

  defp handle_action_result({character, _}),
    do: crawl(character, DungeonCrawl.Room.all())

  defp hero_choice do
    DungeonCrawl.CLI.HeroChoice.start()
  end
end
