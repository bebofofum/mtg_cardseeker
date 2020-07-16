#This will store and what interate over data retrieved?.

module MtgCardseeker
  class MtgCards

    attr_accessor :name, :manacost, :types, :colors, :text

    # @@all = []
    # @@all = (MtgCards.new("Avarice", "{3}{W}{W}", "Creature", "White", "Enters the battlefield indestructible"))

    def self.all
      @@all ||= self.load
    end

    def self.all_uniq
      @@new_all = []
      @@new_all = MtgCards.all.uniq {|instance| instance.name}
    end

    def self.load
      API.get_cards.collect do |card_data_hash|
          MtgCards.new(card_data_hash)
        end
    end
    
    def initialize(attribute = {})
      # attributes.each {|key, value| self.send(("#{key}="), value)}
      @name = attribute["name"]
      @manacost = attribute["manaCost"]
      @types = attribute["types"]
      @colors = attribute["colors"]
      @text = attribute["text"]
    end

    # ----Insert Find By section?----

  end
end
