#This will store and return data.

module MtgCardseeker
  class MtgCards

    attr_accessor :name, :manacost, :types, :colors, :text

    # @@all = []
    # @@all = (MtgCards.new("Avarice", "{3}{W}{W}", "Creature", "White", "Enters the battlefield indestructible"))

    def self.load
      API.get_cards.collect do |card_data_hash|
          MtgCards.new(card_data_hash)
        end
    end

    def self.all
      @@all ||= self.load
    end

    def self.all_uniq
      @@new_all = []
      @@new_all = MtgCards.all.uniq {|instance| instance.name}
    end


    # ----Insert Find By section----

    def self.find_card_by_type(type)
      MtgCards.all_uniq.find_all {|instance| instance.types.join == type}
    end
    
    
    def initialize(attribute = {})
      @name = attribute["name"]
      @manacost = attribute["manaCost"]
      @types = attribute["types"]
      @colors = attribute["colors"]
      @text = attribute["text"]
    end

    

  end
end
