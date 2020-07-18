require "httparty"
require 'pry'
require 'colorize'
require_relative "./mtg_cardseeker/version"
require_relative "./mtg_cardseeker/cli"
require_relative "./mtg_cardseeker/api"
require_relative "./mtg_cardseeker/mtgcards"




module MtgCardseeker
  class Error < StandardError; end
  # Your code goes here...
end
