require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = []
    (1..10).each { |_num| @letters << rand(65..90).chr }
  end

  def score
    @result = params[:result].downcase.chars
    @letters = params[:letters].downcase.chars
    if english_word?(@result) && valid_letters?(@result, @letters)
      @score = @result.size
    else
       @score = 0
    end
  end


  def valid_letters?(result, letters)
    (result - letters) == []
  end

  def english_word?(result)
    url = "https://wagon-dictionary.herokuapp.com/#{result.join('')}"
    word_hash = JSON.parse(open(url).read)
    return word_hash['found']
  end
end
