defmodule Mix.Tasks.Start do
  @moduledoc """
  Documentation for `Task`.
  """

  use Mix.Task
  def run(_), do: DungeonCrawl.CLI.Main.start_game()
end
