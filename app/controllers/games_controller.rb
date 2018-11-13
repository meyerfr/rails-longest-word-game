require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
  # TODO: generate random grid of letters
    @grid = (0...10).map { ("A".."Z").to_a.sample }
  end

  def score
    @word = params[:word]
    @grid = params[:grid].split(' ')
    user = read_json(@word)
    if include_letters(@word, @grid)
      if user['found']
        @answer = "Congratulations!"
      else
        @answer = "not english"
      end
    else
      @answer = "not grid"
    end
  end

  def read_json(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    user_serialized = open(url).read
    JSON.parse(user_serialized)
  end

  def include_letters(word, grid)
    word_array = word.upcase.split(//)
    word_array.all? do |letter|
      word_array.count(letter) <= grid.count(letter)
    end
  end
end

# def score(attempt, start_time, end_time, messages)
#   final_time = end_time - start_time
#   if attempt.class == String
#     result = { time: final_time, score: attempt.length - final_time, message: messages }
#   else
#     result = { time: final_time, score: attempt, message: messages }
#   end
#   return result
# end
