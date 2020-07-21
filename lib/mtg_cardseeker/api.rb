# The API. The role is to retrieve from the API.

module MtgCardseeker
  class API

    def self.get_cards
      response = HTTParty.get('https://api.magicthegathering.io/v1/cards')
      body = response.body
      JSON.parse(body)["cards"]
    end

  end
end
