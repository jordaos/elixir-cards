defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
    """
  
  @doc """
    Returns a list of string containing the cards of a deck
    """
  def create_deck do
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamounds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card
    
    ## Example
        
        iex()> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true

    """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.
    
    ## Examples
    
        iex> deck = Cards.create_deck
        iex> {hand, _deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
    """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write("decks/#{filename}", binary)
  end
  
  def load(filename) do
    case File.read("decks/#{filename}") do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, reason} -> "File not found: #{reason}"
    end
  end
  
  def create_hand(hand_size) do
    # Instead of
    # deck = Cards.create_deck
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)
    
    # do
    {hand, _remaing_deck} = Cards.create_deck
    |> Cards.shuffle # Automatically inject the return for the prev function into the first argument of this function
    |> Cards.deal(hand_size) # The first param was automatically injected by the pipe |>
    
    hand
  end
end
