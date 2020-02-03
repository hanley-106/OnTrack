# Created by Jack Thompson - 1/21/2020
# Edited by Jack Thompson - 1/22/2020 - Added is_set method
# Edited by Jack Thompson - 1/25/2020 - Added initialize and fillTable methods
# Edited by Jack Hanley - 1/27/20 - Added colorCheck, shapeCheck, numberCheck
# and shadingCheck methods.  Edited is_set methods to include these methods
# Edited by Von Mbah -
# Edited by Jing George - 1/29/20 - Changed colorCheck, shapeCheck, numberCheck,
# Edited by Jack Thompson - 1/30/2020 - Removed debug print message
#
# and shadingCheck methods to attribute_check method.
require_relative 'ascii'

# Holds current cards on table (pulls from deck)
class Table
  attr_accessor :current_cards

  # Created by Jack Thompson - 1/25/20
  def initialize
    @current_cards = []
  end

  # Created by Jack Thompson - 1/25/20
  def fillTable(deck)
    if deck.card_list.size > 0
    	while @current_cards.size < 12
      		@current_cards.append(deck.card_list.shift)
      end
      
    end

  end

  # Created by Jack Thompson - 2/2/20
  def display_table
    disp = Ascii.new

    remaining = @current_cards.size
    printed = 0
    while remaining > 0
      for line in 1..8 do
        for item in printed...printed+6 do
          if @current_cards.size > item
            disp.print_by_line(@current_cards[item], line)
            print("   ")
          end

        end
        puts
      end

      puts
      for item in printed...printed+6 do
        if @current_cards.size > item
          print("Card #{item+1}")
          print("               ")
        end

      end

      puts
      puts

      printed += 6
      remaining -= 6
    end

  end

  # Adds in 3 more if the user
  # sees no possible sets
  def if_no_sets(deck)

 	  if set_present(current_cards) == false
      if deck.card_list.size > 0
  		  puts "No sets are present.  Adding 3 cards."
  		  3.times { @current_cards.append(deck.card_list.shift) }
      else
        return -1
      end

  	else
	    puts "Keep looking.  There is a set that can be found."
  	end

  end

  # Removes cards that were chosen to be a set and then replace them with new cards if
  # current card list is less than 12 cards
  def replace_cards(first, second, third, deck)
    @current_cards.delete(first)
    @current_cards.delete(second)
    @current_cards.delete(third)
    fillTable(deck)
  end

  # Created by Jack Thompson - 1/22/20
  # Edited by Jack Hanley - 1/27/20
  # Edited by Jing George - 1/29/20
  # Checks to see if three chosen cards make up a set
  def is_set(card1, card2, card3)
    # Call attribute_check method on all 4 attributes for each card.
    is_set = attribute_check(card1.color, card2.color, card3.color)
    is_set = is_set && attribute_check(card1.shape, card2.shape, card3.shape)
    is_set = is_set && attribute_check(card1.number, card2.number, card3.number)
    is_set = is_set && attribute_check(card1.shading, card2.shading, card3.shading)
    is_set
  end

  
  # Created by Jing George - 1/29/20
  # Returns true if all given attributes are either all matching or all different,
  # returns false otherwise (i.e. only two match).
  def attribute_check(attr1, attr2, attr3)
    result = (attr1 == attr2 && attr1 == attr3)
    result = result || (attr1 != attr2 && attr1 != attr3 && attr2 != attr3)
    result
  end

  # Created by Jack Hanley - 2/2/20
  # Method generates all possible combos of cards currently on table
  def create_combos(current_cards)
    currentCombos = @current_cards.combination(3).to_a
    currentCombos
  end

  # Created by Jack Hanley - 1/30/20
  # Checks to see if a set is possible given current cards
  def set_present(current_cards)
    currentCombos = create_combos(@current_cards)
    set_present = false
    count = 0
    while set_present==false && count<currentCombos.size 
      temp = currentCombos[count]
      if is_set(temp[0], temp[1], temp[2]) == true
        set_present=true
      end
      count = count + 1
    end
    set_present
  end

 #  Created by Jack Hanley
 #  Method that generates a hint for a player.  Tells the user a potential
 #  card to use
  def give_hint
    currentCombos = create_combos(@current_cards)
    if set_present(@current_cards) == false
      puts "There may not be any sets to find within these cards."
    end

    flag = false
    count = 0
    until flag == true
      temp = currentCombos[count]
      if is_set(temp[0], temp[1], temp[2]) == true
        singleCard1 = temp[0]
        singleCard2 = temp[1]
        singleCard3 = temp[2]
        count = 0
        index1 = 0
        index2 = 0
        index3 = 0
        while count < @current_cards.size
          if singleCard1 == @current_cards[count]
            index1 = count + 1
          elsif singleCard2 == @current_cards[count]
            index2 = count + 1
          elsif singleCard3 == @current_cards[count]
            index3 = count + 1
          end
          
          count = count + 1
        end
        
        puts "Try using card numbers: #{index1}, #{index2}, #{index3}"
        flag = true
      end
      
      count = count + 1

    end

  end
end
