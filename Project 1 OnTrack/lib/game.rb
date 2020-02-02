# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Laid out foundation of program
# Edited by Jing George - 1/26/2020 - Incorporation of new PlayerGroup class
# Edit by Von Mbah - 1/29/2020 - Changed a bit of game logic as well as included replacing cards
# Edited by Jack Thompson - 1/30/2020 - Implemented isSet() method test into main gameplay; option for quit
# Edited by Jack Thompson - 1/30/2020 - Implemented tty-prompt menu options
# Edited by Jing George - 1/30/2020 - Fixed issue with card indexing when calling isSet
# Edited by Von Mbah - 1/30/2020 - Changed prompts now to multi-select
# Controls overall game functionality

require_relative 'deck'
require_relative 'player'
require_relative 'playerGroup'
require_relative 'table'
require_relative 'view'
require "tty-prompt"

# Initialize variables
deck = Deck.new
table = Table.new
playerGroup = PlayerGroup.new
prompt = TTY::Prompt.new

# Get player information
playerGroup.addPlayers

# Place 12 cards on table
table.fillTable(deck)
tableView = View.new(table.currentCards)
gameOver = false

until gameOver do
  # Displaying the table
  #tableView.render
  table.displayTable()
  case prompt.select("Select an option.", %w(EnterCards NoSet Quit))
  when "EnterCards"
    
    # Prompting the user to select 3 cards
    cardArray = Array.new
    choices = (1..table.currentCards.length).to_a
    choices = choices.map(&:to_s)
    while cardArray.length != 3 do
      cardArray = prompt.multi_select("Select 3 cards.", choices)
      if cardArray.length != 3
        puts "Incorrect number of cards selected."
      end
    end
    card1 = cardArray[0]
    card2 = cardArray[1]
    card3 = cardArray[2]

    # Prompt for player's name
    puts("Enter your name.")
    name = gets.chomp

    puts("You've entered " + card1 + ", " + card2 + ", " + card3 + ".\n")

    # Check if entered cards are a match
    if(table.isSet(table.currentCards[card1.to_i-1],table.currentCards[card2.to_i-1],table.currentCards[card3.to_i-1]))
      # If match, continue out of loop and +1 to player Score
      playerGroup.updateScore(name, 1)
      correctSet = true
      # Replace entered cards
      table.replaceCards(table.currentCards[card1.to_i-1], table.currentCards[card2.to_i-1], table.currentCards[card3.to_i-1], deck)
    else
      # Else, return to prompting and -1 point to player Score
      playerGroup.updateScore(name, -1)
    end
  when "NoSet"
    table.ifNoSets(deck)
  when "Quit"
    gameOver = true
  else
    puts "Not a menu option"
  end
end

playerGroup.printGameResult
