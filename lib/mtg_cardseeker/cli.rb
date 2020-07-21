# The CLI controller. Interface controlling prompts.

module MtgCardseeker
  class CLI

    def start
      puts
      puts "Welcome to the Card Seeker. Let's look at some cards!".colorize(:green)
      @input = nil
      menu
      get_input
      goodbye
    end

    # ---Displaying first menu to user---

    def menu
      # This uses a HEREDOC for multiline listing
      puts "-------------------------".colorize(:green) 
      puts <<-MENU

Choose a how you would like to see a card. You can view by name, creature, enchantment or sorcery:
1. See cards by Name 
2. See cards by Creature 
3. See cards by Enchantment 
4. See cards by Sorcery

Or type 'exit' at any time to leave the program. Type 'menu' to return to the main menu.
      MENU
    end

    # ---getting user input and displaying list of choices---

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
          puts "Type" + " 'menu'".colorize(:green) + " to see options or " + "'exit'".colorize(:green) + " to end."
        elsif @input == "2"
          list_sorted_by("Creature")
          prompt_and_display_type("Creature")
          puts
          puts "Type" + " 'menu'".colorize(:green) + " to see options or " + "'exit'".colorize(:green) + " to end."
        elsif @input == "3"
          list_sorted_by("Enchantment")
          prompt_and_display_type("Enchantment")
          puts
          puts "Type" + " 'menu'".colorize(:green) + " to see options or " + "'exit'".colorize(:green) + " to end."
        elsif @input == "4"
          list_sorted_by("Sorcery")
          prompt_and_display_type("Sorcery")
          puts
          puts "Type" + " 'menu'".colorize(:green) + " to see options or " + "'exit'".colorize(:green) + " to end."
        elsif @input ==  "menu"
          menu
        elsif @input == "exit" || @input == "quit"
          
        else
          puts "Sorry, I didn't get that. Here are the options again.".colorize(:red)
          menu  
        end
      end
    end

    # ---Ending and exiting method---

    def goodbye
      puts "Thanks for using the Card Seeker. Come back soon."
    end    

    # ---List section---

    def list_sorted_by_name
      puts "-------------------------".colorize(:green)
      card_sorted = MtgCards.all_uniq.take(20).sort_by {|card_array| card_array.name}
      card_sorted.each.with_index(1) {|card, index| puts "#{index}. #{card.name}"}
    end

    def list_sorted_by(type)
      puts "-------------------------".colorize(:green)
      cards_sorted = MtgCards.find_card_by_type(type).sort_by {|card_array| card_array.name}
      cards_sorted.each.with_index(1) {|card, index| puts "#{index}. #{card.name}"}
    end

    # ---Prompt section---

    def prompt_and_display_card_choice
      puts "-------------------------".colorize(:green)
      puts "Enter the card number would you like to see more details about."
      @input = gets.strip.downcase
      index = @input.to_i - 1
      if (1..20).include?(index) 
        if index >= 0
          puts "Name: ".colorize(:green) + "#{MtgCards.all_uniq[index].name}"
          puts "Color: ".colorize(:green) + "#{MtgCards.all_uniq[index].colors.join}"
          puts "ManaCost: ".colorize(:green) + "#{MtgCards.all_uniq[index].manacost}"
          puts "Type: ".colorize(:green) + "#{MtgCards.all_uniq[index].types.join}"
          puts "Description: ".colorize(:green) + "#{MtgCards.all_uniq[index].text}"
        end
      else
        puts "Sorry, that's not a valid entry.".colorize(:red)
        puts
      end
    end

    def prompt_and_display_type(type)
      puts "-------------------------".colorize(:green)
      puts "Enter the card number would you like to see more details about."
      @input = gets.strip.downcase
      index = @input.to_i - 1
      range = MtgCards.find_card_by_type(type).length - 1
      if (1..range).include?(index) 
        if index >= 0
        card = MtgCards.find_card_by_type(type)[index]
        puts "Name: ".colorize(:green) + "#{card.name}"
        puts "Color: ".colorize(:green) + "#{card.colors.join}"
        puts "ManaCost: ".colorize(:green) + "#{card.manacost}"
        puts "Type: ".colorize(:green) + "#{card.types.join}"
        puts "Description: ".colorize(:green) + "#{card.text}"
        end
      else
        puts "Sorry, that's not a valid entry".colorize(:red)
        puts
      end
    end


  end
end
