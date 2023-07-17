defmodule DungeonCrawl.Room.Triggers.Exit do
  @behaviour DungeonCrawl.Room.Trigger
  def run(character, _), do: {character, :exit}
end

defmodule DungeonCrawl.Room.Triggers.MoveForward do
  @behaviour DungeonCrawl.Room.Trigger
  def run(character, _), do: {character, :move_forward}
end

defmodule DungeonCrawl.Room.Triggers.Enemy do
  alias Mix.Shell.IO, as: Shell

  @behaviour DungeonCrawl.Room.Trigger
  def run(character, %DungeonCrawl.Room.Action{id: :forward}) do
    enemy = Enum.random(DungeonCrawl.Enemies.all())
    Shell.info(enemy.description)
    Shell.info("The enemy #{enemy.name} wants to fight.")
    Shell.info("You were prepared and attack first.")

    {updated_char, _enemy} = DungeonCrawl.Battle.fight(character, enemy)
    {updated_char, :forward}
  end
end
