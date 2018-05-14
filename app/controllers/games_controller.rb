require 'open-uri'

class GamesController < ApplicationController
  def new
    letter = ("A".."Z").to_a
    @letters = (0...10).map { letter[rand(26)] }
  end

  def score
    message = "Well done!"
    url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
    word_check = open(url).read
    json_hash = JSON.parse(word_check)
    if json_hash["found"]
      @found_message = "This word was found in our wagon-dictionary"
      params[:guess].upcase.chars.each do |character|
        if @letters.to_a.include?(character)
          params[:grid].delete(character)
        else
          @not_message = "This is not in the grid."
        end
      end
      @included_message = "All letters included in the grid"
    else
      @found_message = "You suck"
    end
  end
end
