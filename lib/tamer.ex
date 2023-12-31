defmodule Tamer do

  @moduledoc """
  
  
    I have a big set of business rules
    These rules can change at any time

    I need a storage for them + a way to alter them adequately

    Thoughts:
      -> create one function which inputs the field, subfield and action
        -> have several handler functions which touch on the subfields and trigger the actions

  """

  def init() do
    :ets.new(:rules, [:named_table, :bag])
  end

  def asker() do
    init()
    IO.puts("****\t\t****")
    IO.puts("**\t    \t**")
    IO.puts("*\t      \t*")
    IO.puts("*\tTAMER\t*")
    IO.puts("\n")
    topic = IO.gets("Enter your topic please: \n") |> parse()
    subtopic = IO.gets("Enter your subtopic please: \n") |> parse()
    action = IO.gets("Enter your action on the subtopic please: \n") |> parse(true)

    IO.puts("\nSo let me recall:\n")
    IO.puts("\nThe topic you want to add a new rule on is #{topic}")
    IO.puts("\nThe subtopic on where the action has to be applied to is #{subtopic}")
    IO.puts("\nThe action itself contains #{action}")

    handle_request(topic, subtopic, action)
  end

  def handle_request(topic, subtopic, action) do
    :ets.insert_new(:rules, {String.to_atom(topic), subtopic})
    :ets.insert_new(:rules, {String.to_atom(subtopic), action})
  end

  defp parse(string, trim \\ false) do
    string
    |> String.split("\n", trim: true)
    |> List.first()
  end


  @doc """
    This is currently not in use. 
    I wanted to strip down the words i got from the prompt. 
    Didn't work as intuitively as i expected so i will work on other things now.
  """

  defp trim(string, verblist \\ prepare_verbs()) do
    string
    |> String.split(" ", trim: true)
    |> Enum.reject(fn word -> word in verblist end)
  end

  defp prepare_verbs() do
    File.stream!("./lib/verbs")
    |> Stream.map(
      fn line -> 
        line
        |> String.split("\n", trim: true)
        |> List.first()
        |> String.split(",")
    end)
    |> Enum.to_list()
    |> List.flatten()
  end

end
