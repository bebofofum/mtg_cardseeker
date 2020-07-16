# The CLI controller. Interface controlling prompts.

module MtgCardseeker
  class CLI

    def start
      puts "Welcome to the Card Seeker. Choose a type of card:"
      @input = nil
      menu
      get_input
      goodbye
    end

    def menu
      # This uses a HEREDOC for multiline listing 
      puts <<-MENU
      1. See cards by Name 
      2. See cards by Creature 
      3. See cards by Enchantment 
      4. See cards by Sorcery

      Or type 'exit' at any time to leave the program. Type 'menu' to return to the main menu.
      MENU
    end

    def valid?
      @input != "exit" && @input != "quit"
    end

    def get_input
      while valid?
        @input = gets.strip.downcase
        if @input == "1"
          list_sorted_by_name
          prompt_and_display_card_choice
          puts
          puts "Would you like to see another card? Type 'menu' to see options or 'exit' to end."
        elsif @input ==  "2"
          list_sorted_by("Creature")
          prompt_and_display_type("Creature")
          puts
          puts "Would you like to see another card? Type 'menu' to see options or 'exit' to end."
        elsif @input ==  "3"
          list_sorted_by("Enchantment")
          prompt_and_display_type("Enchantment")
          puts
          puts "Would you like to see another card? Type 'menu' to see options or 'exit' to end."
        elsif @input ==  "4"
          list_sorted_by("Sorcery")
          prompt_and_display_type("Sorcery")
          puts
          puts "Would you like to see another card? Type 'menu' to see options or 'exit' to end."
        elsif @input ==  "menu"
          menu
        elsif @input == "exit" || @input == "quit"
          
        else
          puts "Sorry, I didn't get that. Here are the options again."
          menu  
        end
      end
    end

    def goodbye
      puts "Thanks for using the Card Seeker. Come back soon."
    end

    # ---Find By section--Move this to MtgCards class?---

    def find_card_by_type(type)
      MtgCards.all_uniq.find_all {|instance| instance.types.join == type}
    end

    # ---List section---

    def list_sorted_by_name
      card_sorted = MtgCards.all_uniq.take(20).sort_by {|card_array| card_array.name}
      card_sorted.each.with_index(1) {|card, index| puts "#{index}. #{card.name}"}
    end

    def list_sorted_by(type)
      creature_cards_sorted = find_card_by_type(type).take(20).sort_by {|card_array| card_array.name}
      creature_cards_sorted.each.with_index(1) {|card, index| puts "#{index}. #{card.name}"}
    end

    # ---Prompt section---

    def prompt_and_display_card_choice
      puts "Enter the card number would you like to see more details about."
      @input = gets.strip.downcase
      index = @input.to_i - 1
      if (1..20).include?(index) 
        if index >= 0
          puts "Name: #{MtgCards.all_uniq[index].name}"
          puts "Color: #{MtgCards.all_uniq[index].colors.join}"
          puts "ManaCost: #{MtgCards.all_uniq[index].manacost}"
          puts "Type: #{MtgCards.all_uniq[index].types.join}"
          puts "Description: #{MtgCards.all_uniq[index].text}"
        end
      else
        puts "Sorry, that's not a valid entry. Please pick a number 1-20."
      end
    end

    def prompt_and_display_type(type)
      puts "Enter the card number would you like to see more details about."
      @input = gets.strip.downcase
      index = @input.to_i - 1
      if (1..20).include?(index) 
        if index >= 0
          puts "Name: #{find_card_by_type(type)[index].name}"
          puts "Color: #{find_card_by_type(type)[index].colors.join}"
          puts "ManaCost: #{find_card_by_type(type)[index].manacost}"
          puts "Type: #{find_card_by_type(type)[index].types.join}"
          puts "Description: #{find_card_by_type(type)[index].text}"
        end
      else
        puts "Sorry, that's not a valid entry. Please pick a number 1-20."
      end
    end


  end
end
