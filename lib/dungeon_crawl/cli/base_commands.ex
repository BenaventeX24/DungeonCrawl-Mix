defmodule DungeonCrawl.CLI.BaseCommands do
  @moduledoc """
  Documentation for `DungeonCrawl.BaseCommands`.
  """
  alias Mix.Shell.IO, as: Shell

  def ask_for_index(options) do
    answer =
      options
      |> display_options
      |> generate_question
      |> Shell.prompt()
      |> Integer.parse()
      |> take_user_input(options)

    answer
  end

  defp take_user_input(:error, options) do
    display_invalid_option()
    ask_for_index(options)
  end

  defp take_user_input({option, _}, _options), do: option - 1

  def ask_for_option(options) do
    index = ask_for_index(options)
    chosen_option = Enum.at(options, index)
    chosen_option || (display_invalid_option() && ask_for_option(options))
  end

  def check_option(_chosen_option = nil, options) do
    display_invalid_option()
    ask_for_option(options)
  end

  def check_option(chosen_option, _options), do: chosen_option

  def display_invalid_option do
    Shell.cmd("clear")
    Shell.error("Invalid option.")
    Shell.prompt("Press Enter to try again.")
    Shell.cmd("clear")
  end

  def display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  def generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "Which one? [#{options}]\n"
  end
end
