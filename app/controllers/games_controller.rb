class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @word == (params[:word] || "").upcase
    @letters == params[:letters].split(" ")
      if included?(@word, @letters)
        if english_word?(@word)
          puts "Congratulations!"
        else puts "Sorry this is not an english word"
        end
      else puts "Sorry this word cannot be built out of these letters"
      end
  end

  private

  def included?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
